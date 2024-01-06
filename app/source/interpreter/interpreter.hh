#pragma once

#include <memory>
#include <optional>

#include <cling/Interpreter/Interpreter.h>

#include <json/value.h>

// chrpp interpreter
// Use chrppc and cling to make a working session
class Interpreter
{
	public:

		class Exception
		{
			public:

				Exception(const std::string & what): 
					_what(what)
				{}

			const std::string & what() const
			{
				return _what;
			}

			private:

				std::string _what;
		};

		// Store a logical variable declaration
		struct Variable_declaration
		{
			std::string type;
			std::string name;
		};

		// Store a logical variable definition
		struct Variable_definition
		{
			Variable_declaration declaration;
			std::string value;
		};		

		// Set session id
		void session_id(const std::string & session_id);

		// Return path of cpp space
		std::string cpp_space_path() const;

		// Define a CHR space
		void define_space(const std::string & chr_path);
		
		// Add a logical variable
		void add_variable(const std::string & type, const std::string & name, bool mutable_, const std::optional<std::string> & value);

		// Remove a logical variable
		void remove_variable(const std::string & name);

		// Clear logical variables
		void clear_variables();

		// Add a CHR constraint to the store
		void add_constraint(const std::string & constraint);

		// Remove a CHR constraint
		void remove_constraint(const std::string & constraint);

		// Clear the constraint store
		void clear_store();

		// Return true if there is an active session
		bool has_session() const;

		// Get logical variables definition
		std::vector<Variable_definition> variables_definition() const;

		// Get Constraint store
		std::vector<std::string> constraint_store() const;

		// Return a read reference to json session
		const Json::Value & json_session() const;

		// Start a new session from given json session
		void new_session(const Json::Value json_session);

		// Return current CHR space
		std::string space() const;

	private:

		// Cling arguments
		static const char * _cling_argv[];

		// Return true if a cling compilation did not succeed
		static bool failed(cling::Interpreter::CompilationResult compilationResult);

		// Start a new empty session (restart cling)
		void new_session();

		// Define a CHR space from given C++ code
		void define_cpp_space(const std::string & space_name);

		// Return stored variable full name including removed count
		std::string full_variable_name(const std::string & name) const;

		// Store session id given by an http request
		std::string _session_id;

		// C++ interpreter used to compile CHR statement with chrppc
		std::shared_ptr<cling::Interpreter> _cling_interpreter;

		// Store logical variables declarations
		std::vector<Variable_declaration> _variables_declaration;

		// Count number of time a variable with same name was removed
		// Allow to remove a variable and use it name to add a new one
		// Cannot use unload method because it fails at unloading a logical variable declaration (see https://github.com/root-project/cling/issues/318)
		std::map<std::string, std::size_t> _removed_variables;

		// Store session in Json format
		Json::Value _json_session;
};