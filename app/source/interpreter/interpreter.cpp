#include <filesystem>
#include <string>
#include <fstream>
#include <regex>

#include <cling/Interpreter/Value.h>
#include <clang/AST/Type.h>

#include "interpreter.hh"
#include "../config.hh"

void Interpreter::session_id(const std::string & session_id)
{
	_session_id = session_id;
}

std::string Interpreter::cpp_space_path() const
{
	return config::file::chr_spaces + "/" + _session_id + ".cpp";
}

void Interpreter::new_session()
{
	// Empty stored variables
	_variables.clear();

	// Empty removed variables
	_removed_variables.clear();

	// Empty and initialize json session
	_json_session.clear();
	_json_session["changes"] = Json::arrayValue;

	// Create a new cling session
	int cling_argc(0);
	while(_cling_argv[++cling_argc]);
	_cling_interpreter = std::make_shared<cling::Interpreter>(cling_argc, _cling_argv, config::file::llvm_build.c_str());

	// Allow to print a space
	if (failed(_cling_interpreter->declare("#include <iostream>")))
		throw Exception("Failed to start CHR session");

	// Allow declaration shadowing
	_cling_interpreter->getRuntimeOptions().AllowRedefinition = true;

	// Enable O3 optimization
	_cling_interpreter->setDefaultOptLevel(3);

	// Include chrpp sources
	_cling_interpreter->AddIncludePath(config::file::chrpp_source + "/runtime");
	_cling_interpreter->AddIncludePath(config::file::chrpp_build + "/runtime");
}

void Interpreter::define_cpp_space(const std::string & space_name)
{
	// Load C++ space definition with cling
	if (failed(_cling_interpreter->loadFile(cpp_space_path())))
		throw Exception("Failed to load CHR space");

	// Create the space
	if (failed(_cling_interpreter->declare("auto space(" + space_name + "::create());")))
		throw Exception("Failed to create CHR space");
}

std::string Interpreter::variable_name(const std::string name) const
{
	return name + "_" + std::to_string(_removed_variables.find(name)->second);
}

void Interpreter::define_space(const std::string & chr_path)
{
	// Start a new session
	new_session();

	// Compile space definition to C++ with chrppc
	const std::string cpp_space_path(this->cpp_space_path());
	if (std::system((config::file::chrpp_build + "/chrppc/chrppc --stdout " + chr_path + " > " + cpp_space_path).c_str()) != 0)
		throw Exception("Failed to compile CHR space");

	// Append print function to C++ file
	std::ofstream append_cpp_file(cpp_space_path, std::ios::app);
	append_cpp_file << R"EOF(
template <typename T>
std::vector<std::string> constraints(T & pb)
{
	std::vector<std::string> constraints;
	for (auto it = pb.chr_store_begin(); !it.at_end(); ++it)
		constraints.push_back(it.to_string());
	return constraints;
}
    )EOF";
	append_cpp_file.close();

	// Get space name
	std::ifstream chr_file(chr_path);
	if (!chr_file.is_open())
		throw Exception("Failed to open CHR space file");
	std::smatch chr_match;
	std::string chr_line;
	while (std::getline(chr_file, chr_line) && !std::regex_match(chr_line, chr_match, std::regex {".*<CHR\\s*name\\s*=\\s*\"([^\"]*)\".*"}));
	const std::string & space_name(chr_match[1]);
	chr_file.close();

	// Define space
	define_cpp_space(space_name);

	// Update json session
	std::ifstream read_chr_file(chr_path);
	_json_session["chr_space"] = std::string {std::istreambuf_iterator<char>(read_chr_file), std::istreambuf_iterator<char>()};
	_json_session["space_name"] = space_name;
	std::ifstream read_cpp_file(cpp_space_path);
	_json_session["cpp_space"] = std::string {std::istreambuf_iterator<char>(read_cpp_file), std::istreambuf_iterator<char>()};

	// Remove cpp space file
	std::remove(cpp_space_path.c_str());
}

void Interpreter::add_variable(const std::string & type, const std::string & name, bool mutable_)
{
	// Update removed variable
	if (_removed_variables.find(name) == _removed_variables.end())
		_removed_variables[name] = 0;

	// Declare the new variable
	if (failed(_cling_interpreter->declare("chr::Logical_var" + std::string {mutable_ ? "_mutable" : ""} + "<" + type + "> " + variable_name(name) + ";")))
		throw Exception("Failed to declare variable");

	// Update variables
	_variables.emplace_back(name);

	// Update json session
	Json::Value add_variable;
	add_variable["add_variable"]["type"] = type;
	add_variable["add_variable"]["name"] = name;
	add_variable["add_variable"]["mutable"] = mutable_;
	_json_session["changes"].append(add_variable);
}

void Interpreter::remove_variable(const std::string & name)
{
	// Update variables
	auto variable(std::find(_variables.begin(), _variables.end(), name));
	if (variable == _variables.end())
		throw Exception("Unknow variable");
	_variables.erase(variable);
	
	// Update removed variable
	++_removed_variables[name];

	// Update json session
	Json::Value remove_variable;
	remove_variable["remove_variable"] = name;
	_json_session["changes"].append(remove_variable);
}

void Interpreter::clear_variables()
{
	// Update removed variable
	for (const std::string & name: _variables)
		++_removed_variables[name];

	// Clear variables
	_variables.clear();

	// Update json session
	_json_session["changes"].append("clear_variables");
}

void Interpreter::add_constraint(const std::string & constraint)
{
	// Add constraint
	if (failed(_cling_interpreter->execute("space->" + constraint + ";")))
		throw Exception("Failed to update space");

	// Update json session
	Json::Value add_constraint;
	add_constraint["add_constraint"] = constraint;
	_json_session["changes"].append(add_constraint);
}

void Interpreter::remove_constraint(const std::string & constraint)
{
	// Remove constraint
	const std::string constraint_name(constraint.substr(0, constraint.find('#')));
	if 
	(
		failed
		(
			_cling_interpreter->execute
			(
				R"EOF(
for (auto it = space->get_)EOF" + constraint_name + R"EOF(_store().begin(); it != space->get_)EOF" + constraint_name + R"EOF(_store().end(); ++it)
	if (it.to_string() == ")EOF" + constraint + R"EOF(")
		it.kill();
				)EOF"
			)
		)
	)
		throw Exception("Failed to update space");
	;

	// Update json session
	Json::Value remove_constraint;
	remove_constraint["remove_constraint"] = constraint;
	_json_session["changes"].append(remove_constraint);
}

void Interpreter::clear_store()
{
	// Save current changes
	const Json::Value old_changes(_json_session["changes"]);

	// Forced to start new session without constraint changes
	// Because AllowRedefinition and unload doesn't work for space files (see https://github.com/root-project/cling/issues/318)
	Json::Value new_changes(Json::arrayValue);
	for (auto change(_json_session["changes"].begin()); change != _json_session["changes"].end(); ++change)
		if (!(*change).isMember("add_constraint") && !(*change).isMember("remove_constraint"))
			new_changes.append(*change);
	_json_session["changes"] = new_changes;
	new_session(_json_session);

	// Update json session
	_json_session["changes"] = old_changes;
	_json_session["changes"].append("clear_store");
}

bool Interpreter::has_session() const
{
	return _cling_interpreter != nullptr;
}

std::vector<std::pair<std::string, std::string>> Interpreter::variables_values() const
{
	std::vector<std::pair<std::string, std::string>> variables_values;
	cling::Value value;
	for (const std::string & name: _variables)
	{
		if (failed(_cling_interpreter->process(variable_name(name) + ".to_string();", &value)))
			throw Exception("Failed to get variable value");
		variables_values.emplace_back(name, *(std::string*)value.getPtr());
	}
	return variables_values;
}

std::vector<std::string> Interpreter::constraint_store() const
{
	// Get gonstraints in a string
	cling::Value value;
	if (failed(_cling_interpreter->process("constraints(*space);", &value)))
		throw Exception("Failed to get constraint store");
	return *(std::vector<std::string>*)value.getPtr();
}

const Json::Value & Interpreter::json_session() const
{
	return _json_session;
}

void Interpreter::new_session(const Json::Value json_session)
{
	// Start a new session
	new_session();

	// Save cpp space to a file
	const std::string cpp_space_path(this->cpp_space_path());
	std::ofstream cpp_space_file(cpp_space_path);
	cpp_space_file << json_session["cpp_space"].asString();
	cpp_space_file.close();

	// Define the given CHR space
	define_cpp_space(json_session["space_name"].asString());

	// Remove cpp space file
	std::remove(cpp_space_path.c_str());

	// Apply changes
	for (const Json::Value & change: json_session["changes"])
		if (change.isMember("add_constraint"))
			add_constraint(change["add_constraint"].asString());
		else if (change.isMember("remove_constraint"))
			remove_constraint(change["remove_constraint"].asString());
		else if (change.isMember("clear_store"))
			clear_store();
		else if (change.isMember("add_variable"))
			add_variable(change["add_variable"]["type"].asString(), change["add_variable"]["name"].asString(), change["add_variable"]["mutable"].asBool());
		else if (change.isMember("remove_variable"))
			remove_variable(change["remove_variable"].asString());
		else if (change.isMember("clear_variables"))
			clear_variables();
	
	// Update json session
	_json_session = json_session;
}

std::string Interpreter::space() const
{
	return _json_session["chr_space"].asString();
}

const char * Interpreter::_cling_argv[]
{
	"chrppi",
	"-D ENABLE_STATISTICS",
	"-fno-exceptions",
	"-fno-inline",
	"-std=c++17",
	NULL
};

bool Interpreter::failed(cling::Interpreter::CompilationResult compilationResult)
{
	return compilationResult != cling::Interpreter::kSuccess;
}