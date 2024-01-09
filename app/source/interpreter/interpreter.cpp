#include <filesystem>
#include <string>
#include <fstream>
#include <regex>

#include <cling/Interpreter/Value.h>
#include <clang/AST/Type.h>

#include "interpreter.hh"
#include "../config.hh"

void Interpreter::client_id(const std::string & client_id)
{
	_client_id = client_id;
}

void Interpreter::new_session()
{
	// Empty stored variables declaration
	_variables_declaration.clear();

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

void Interpreter::define_cpp_space()
{
	// Load C++ space definition with cling
	if (failed(_cling_interpreter->declare(_json_session["cpp_space"].asString())))
		throw Exception("Failed to load CHR space");

	// Create the space
	if (failed(_cling_interpreter->declare("auto space(" + _json_session["space_name"].asString() + "::create());")))
		throw Exception("Failed to create CHR space");
}

std::string Interpreter::full_variable_name(const std::string & name) const
{
	return name + "_" + std::to_string(_removed_variables.find(name)->second);
}

void Interpreter::define_space(const std::string & chr_path)
{
	// Start a new session
	new_session();

	// Compile space definition to C++ with chrppc
	const std::string cpp_space_path(config::file::chr_spaces + "/" + _client_id + ".cpp");
	if (std::system((config::file::chrpp_build + "/chrppc/chrppc --stdout " + chr_path + " > " + cpp_space_path).c_str()) != 0)
	{
		// Remove cpp space file
		std::remove(cpp_space_path.c_str());

		throw Exception("Failed to compile CHR space");
	}

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

	// Update json session and remove cpp space file
	std::ifstream read_chr_file(chr_path);
	_json_session["chr_space"] = std::string {std::istreambuf_iterator<char>(read_chr_file), std::istreambuf_iterator<char>()};
	std::ifstream read_cpp_file(cpp_space_path);
	_json_session["cpp_space"] = std::string {std::istreambuf_iterator<char>(read_cpp_file), std::istreambuf_iterator<char>()};
	std::remove(cpp_space_path.c_str());

	// Update json session and define space
	_json_session["space_name"] = space_name;
	define_cpp_space();
}

void Interpreter::add_variable(const std::string & type, const std::string & name, bool mutable_, const std::optional<std::string> & value)
{
	// Update removed variable
	if (_removed_variables.find(name) == _removed_variables.end())
		_removed_variables[name] = 0;

	// Declare the new variable
	if (failed(_cling_interpreter->declare("chr::Logical_var" + std::string {mutable_ ? "_mutable" : ""} + "<" + type + "> " + full_variable_name(name) + ";")))
		throw Exception("Failed to declare variable");

	// Set initial value
	if (value)
		if (failed(_cling_interpreter->execute(full_variable_name(name) + " = " + *value + ";")))
			throw Exception("Failed to assign initial value");

	// Update variable declaration
	_variables_declaration.emplace_back(type, name);

	// Update json session
	Json::Value add_variable;
	add_variable["add_variable"]["type"] = type;
	add_variable["add_variable"]["name"] = name;
	add_variable["add_variable"]["mutable"] = mutable_;
	if (value)
		add_variable["add_variable"]["value"] = *value;
	_json_session["changes"].append(add_variable);
}

void Interpreter::remove_variable(const std::string & name)
{
	// Update variables definition
	auto variable_declaration
	(
		std::find_if
		(
			_variables_declaration.begin(), 
			_variables_declaration.end(), 
			[&name](const Variable_declaration & variable_declaration_)
			{
				return variable_declaration_.name == name;
			}
		)
	);
	if (variable_declaration == _variables_declaration.end())
		throw Exception("Unknow variable");
	_variables_declaration.erase(variable_declaration);
	
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
	for (const Variable_declaration & variable_declaration: _variables_declaration)
		++_removed_variables[variable_declaration.name];

	// Clear variables declaration
	_variables_declaration.clear();

	// Update json session
	Json::Value clear_variables;
	clear_variables["clear_variables"] = true;
	_json_session["changes"].append(clear_variables);
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
	Json::Value clear_store;
	clear_store["clear_store"] = true;
	_json_session["changes"].append(clear_store);
}

bool Interpreter::has_session() const
{
	return _cling_interpreter != nullptr;
}

std::vector<Interpreter::Variable_definition> Interpreter::variables_definition() const
{
	std::vector<Variable_definition> variables_definition;
	cling::Value value;
	for (const Variable_declaration & variable_declaration: _variables_declaration)
	{
		if (failed(_cling_interpreter->process(full_variable_name(variable_declaration.name) + ".to_string();", &value)))
			throw Exception("Failed to get variable value");
		variables_definition.emplace_back(variable_declaration, *(std::string*)value.getPtr());
	}
	return variables_definition;
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
	// Try to start a new session
	try
	{
		// Start a new session
		new_session();

		// Update json session and define the given CHR space
		_json_session["chr_space"] = json_session["chr_space"];
		_json_session["space_name"] = json_session["space_name"];
		_json_session["cpp_space"] = json_session["cpp_space"];
		define_cpp_space();

		// Apply changes
		for (const Json::Value & change: json_session["changes"])
			if (change.isMember("add_constraint"))
				add_constraint(change["add_constraint"].asString());
			else if (change.isMember("remove_constraint"))
				remove_constraint(change["remove_constraint"].asString());
			else if (change.isMember("clear_store"))
				clear_store();
			else if (change.isMember("add_variable"))
				add_variable
				(
					change["add_variable"]["type"].asString(), 
					change["add_variable"]["name"].asString(), 
					change["add_variable"]["mutable"].asBool(),
						change["add_variable"].isMember("value")
					?
						std::optional<std::string> {change["add_variable"]["value"].asString()}
					:
						std::nullopt
				);
			else if (change.isMember("remove_variable"))
				remove_variable(change["remove_variable"].asString());
			else if (change.isMember("clear_variables"))
				clear_variables();
	}

	// Cannot create new session
	catch (const Exception & exception)
	{
		// Make sure session is null
		_cling_interpreter = nullptr;

		throw exception;
	}
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