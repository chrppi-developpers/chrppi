#pragma once

#include <string>

// Set constants used in code
namespace config
{
	// Drogon parameters used in main
	namespace main
	{
		const std::string ip("0.0.0.0");
		const std::string document_root("document_root");
		const std::string upload_path("uploads");
		const int session_timeout(3600);
		const size_t threads(5);
	}

	// Path of URLs
	namespace url
	{
		const std::string root("/");
		const std::string upload_session("/upload_session");
	}

	// Path of files
	namespace file
	{
		const std::string chr_spaces("chr_spaces");
		const std::string chr_examples("chr_spaces/examples");
		const std::string llvm_build("third-party/llvm/build");
		const std::string chrpp_build("third-party/chrpp/build");
		const std::string chrpp_source("third-party/chrpp/source");
	}

	// Strings used in HTML
	namespace html
	{
		// Error
		const std::string error_section("error section");
		const std::string error_list("error list");

		// Load an example
		const std::string select_example("select example");
		const std::string disable_option("disable option");
		const std::string chr_examples("chr examples");
		
		// Compile chr code
		const std::string compile("compile");
		
		// CHR code
		const std::string chr_code("chr code");

		// Download/upload session
		const std::string download_session("download session");
		const std::string upload_session("upload session");
		
		// Add a constraint
		const std::string add_constraint_value("add constraint value");
		const std::string add_constraint("add constraint");
		
		// Add a variable
		const std::string variable_type("variable type");
		const std::string variable_name("variable name");
		const std::string variable_mutable("variable mutable");
		const std::string variable_value("variable value");
		const std::string add_variable("add variable");

		// Constraint store
		const std::string constraint_store("constraint store");
		const std::string store_body("store body");
		const std::string remove_constraint("remove constraint");
		const std::string clear_constraint_store("clear constraint store");

		// Variables
		const std::string variables("variables");
		const std::string variables_body("variables body");
		const std::string remove_variable("remove variable");
		const std::string clear_variables("clear variables");
		
		// Ajax request
		const std::string ajax_request("ajax request");
	}

	// Session keys
	namespace session
	{
		const std::string json("json");
	}
};