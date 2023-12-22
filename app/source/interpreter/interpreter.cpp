#include <filesystem>
#include <string>
#include <fstream>
#include <regex>

#include <cling/Interpreter/Value.h>
#include <clang/AST/Type.h>

#include "interpreter.hh"
#include "../config.hh"

#include <iostream>
#include <any>

int argc(const char * argv[])
{
	int argc(0);
	while(argv[++argc]);
	return argc;
}

void Interpreter::new_session()
{
	// Empty stored variables
	_variables.clear();

	// Empty and initialize json session
	_json_session.clear();
	_json_session["add_variable"] = Json::arrayValue;
	_json_session["add_constraint"] = Json::arrayValue;

	// Create a new cling session
	_cling_interpeter = std::make_unique<cling::Interpreter>(argc(_cling_argv), _cling_argv, config::path::llvm_build.c_str());

	// Allow to print a space
	_cling_interpeter->declare("#include <iostream>");

	// Allow declaration shadowing
	_cling_interpeter->execute("gClingOpts->AllowRedefinition = 1;");

	// Enable O3 optimization
	_cling_interpeter->setDefaultOptLevel(3);

	// Include chrpp sources
	_cling_interpeter->AddIncludePath(config::path::chrpp_source + "/runtime");
	_cling_interpeter->AddIncludePath(config::path::chrpp_build + "/runtime");
	_cling_interpeter->AddIncludePath(config::path::chrpp_build + "/examples");
/*
	_cling_interpeter->declare("int integer(123);");
	cling::Value integer_value;
	_cling_interpeter->execute("++integer");
	_cling_interpeter->process("integer;", &integer_value);
	std::cout << "integer is " << integer_value.getPtr();
	std::cout << " = " << integer_value.getAs<long long>() << " = ";
	integer_value.dump();

	_cling_interpeter->declare("#include <string>");
	_cling_interpeter->declare("std::string str;");
	cling::Value str_value;
	_cling_interpeter->execute("str = \"test\"");
	_cling_interpeter->process("str;", &str_value);
	std::cout << "str is " << *(std::string*)(str_value.getPtr()) << " = ";
	std::string dump;
	llvm::raw_string_ostream out(dump);
	str_value.print(out);
	out.str().pop_back();
	std::cout << out.str() << std::endl;
*/
}

void Interpreter::define_cpp_space(const std::string & cpp_path, const std::string & space_name)
{
	// Load C++ space definition with cling
	if (_cling_interpeter->loadFile(cpp_path) != cling::Interpreter::kSuccess)
		throw Exception("Failed to load CHR space");

	// Create the space
	if (_cling_interpeter->declare("auto space(" + space_name + "::create());") != cling::Interpreter::kSuccess)
		throw Exception("Failed to create CHR space");
}

void Interpreter::define_space(const std::string & chr_path)
{
	// Start a new session
	new_session();

	// Compile space definition to C++ with chrppc
	const std::string cpp_path(config::path::chr_spaces + "/space.cpp");
	if (std::system((config::path::chrpp_build + "/chrppc/chrppc --stdout " + chr_path + " > " + cpp_path).c_str()) != 0)
		throw Exception("Failed to compile CHR space");

	// Append print function to C++ file
	std::ofstream append_cpp_file(cpp_path, std::ios::app);
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
	define_cpp_space(cpp_path, space_name);

	// Update json session
	std::ifstream read_chr_file(chr_path);
	_json_session["chr_space"] = std::string {std::istreambuf_iterator<char>(read_chr_file), std::istreambuf_iterator<char>()};
	_json_session["space_name"] = space_name;
	std::ifstream read_cpp_file(cpp_path);
	_json_session["cpp_space"] = std::string {std::istreambuf_iterator<char>(read_cpp_file), std::istreambuf_iterator<char>()};
}

void Interpreter::add_variable(const std::string & type, const std::string & name, bool mutable_)
{
	// Declare the new variable
	if (_cling_interpeter->declare("chr::Logical_var" + std::string {mutable_ ? "_mutable" : ""} + "<" + type + "> " + name + ";") != cling::Interpreter::kSuccess)
		throw Exception("Failed to declare variable");

	// Update json session
	Json::Value add_variable;
	add_variable["type"] = type;
	add_variable["name"] = name;
	add_variable["mutable"] = mutable_;
	_json_session["add_variable"].append(add_variable);

	// Save variable name
	_variables.emplace_back(name);
}

void Interpreter::add_constraint(const std::string & constraint)
{
	// Add constraint
	if (_cling_interpeter->execute("space->" + constraint + ";") != cling::Interpreter::kSuccess)
		throw Exception("Failed to add constraint");

	// Update json session
	_json_session["add_constraint"].append(constraint);
}

bool Interpreter::has_session() const
{
	return _cling_interpeter != nullptr;
}

std::vector<std::pair<std::string, std::string>> Interpreter::variables_values() const
{
	std::vector<std::pair<std::string, std::string>> variables_values;
	cling::Value value;
	for (const std::string & name: _variables)
	{
		_cling_interpeter->process(name + ".to_string();", &value);
		variables_values.emplace_back(name, *(std::string*)value.getPtr());
	}
	return variables_values;
}

std::vector<std::string> Interpreter::constraint_store() const
{
	// Get gonstraints in a string
	cling::Value value;
	_cling_interpeter->process("constraints(*space);", &value);
	 return *(std::vector<std::string>*)value.getPtr();
}

const Json::Value & Interpreter::json_session() const
{
	return _json_session;
}

void Interpreter::new_session(const Json::Value & json_session)
{
	// Start a new session
	new_session();

	// Save cpp space to a file
	const std::string cpp_path(config::path::chr_spaces + "/space.cpp");
	std::ofstream cpp_file(cpp_path);
	cpp_file << json_session["cpp_space"].asString();
	cpp_file.close();

	// Define the given CHR space
	define_cpp_space(cpp_path, json_session["space_name"].asString());

	// Add variables
	for (const Json::Value & variable: json_session["add_variable"])
		add_variable(variable["type"].asString(), variable["name"].asString(), variable["mutable"].asBool());
	
	// Add constraints
	for (const Json::Value & constraint: json_session["add_constraint"])
		add_constraint(constraint.asString());
	
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
	"-std=c++17"
};