#pragma once
#include<string>

// Set constants used in code
namespace config
{
	// Drogon parameters used in main
	namespace main
	{
		const std::string ip("0.0.0.0");
		const std::string document_root("document_root");
		const std::string upload_path("uploads");
		const int session_timeout(500000);
		const size_t client_max_body_size(20 * 2000 * 2000);
	}

	// Paths of files
	namespace path
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
		const std::string select_example("select example");
		const std::string chr_examples("chr examples");
		const std::string compile("compile");
		const std::string chr_code("chr code");

		const std::string download_session("download session");
		const std::string upload_session("upload session");
		
		const std::string add_constraint_value("add constraint value");
		const std::string add_constraint("add constraint");

		const std::string constraint_store("constraint store");
		const std::string remove_constraint("remove constraint");
		const std::string clear_constraint_store("clear constraint store");
		
		const std::string variable_type("variable type");
		const std::string variable_name("variable name");
		const std::string variable_mutable("variable mutable");
		const std::string add_variable("add variable");

		const std::string variables("variables");
		const std::string remove_variable("remove variable");
		const std::string clear_variables("clear variables");

		const std::string error_id("error");
	}

	// Session keys
	namespace session
	{
		const std::string interpreter("session");
		const std::string chr_code("chr_code");
	}
};