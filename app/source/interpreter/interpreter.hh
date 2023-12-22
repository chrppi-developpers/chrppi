#pragma once

#include <cling/Interpreter/Interpreter.h>
#include <memory>
#include <json/value.h>

// chrpp interpreter
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

		// Define a CHR space
		void define_space(const std::string & chr_path);
		
		// Add a variable to the store
		void add_variable(const std::string & type, const std::string & name, bool mutable_);

		// Add a CHR constraint to the store
		void add_constraint(const std::string & constraint);

		// Clear the constraint store
		void clear_store();

		// Return true if there is an active session
		bool has_session() const;

		// Get logical variables name and values
		std::vector<std::pair<std::string, std::string>> variables_values() const;

		// Get Constraint store
		std::vector<std::string> constraint_store() const;

		// Return a read reference to json session
		const Json::Value & json_session() const;

		// Start a new session from given json session
		void new_session(const Json::Value & json_session);

		// Return current CHR space
		std::string space() const;

	private:

		// Cling arguments
		static const char * _cling_argv[];

		// Start a new empty session (restart cling)
		void new_session();

		// Define a CHR space from given C++ code
		void define_cpp_space(const std::string & cpp_path, const std::string & space_name);

		// C++ interpreter used to compile CHR statement with chrppc
		std::unique_ptr<cling::Interpreter> _cling_interpeter;

		// Store logical variables name
		std::vector<std::string> _variables;

		// Store session in Json format
		Json::Value _json_session;
};