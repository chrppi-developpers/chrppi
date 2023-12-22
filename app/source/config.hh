#pragma once
#include<string>

namespace config
{
	namespace drogon
	{
		const std::string ip("0.0.0.0");
		const std::string document_root("document_root");
		const std::string upload_path("uploads");
		const int session_timeout(500000);
		const size_t client_max_body_size(20 * 2000 * 2000);
	}

	namespace path
	{
		const std::string chr_examples("chr_examples");
		const std::string chr_spaces("chr_spaces");
		const std::string llvm_build("third-party/llvm/build");
		const std::string chrpp_build("third-party/chrpp/build");
		const std::string chrpp_source("third-party/chrpp/source");
	}

	namespace html
	{
		const std::string select_example("select example");
		const std::string chr_examples("chr examples");
		const std::string chr_code("chr code");
		const std::string download_session("download session");
		const std::string upload_session("upload session");
		
		const std::string add_constraint_value("add constraint value");
		const std::string add_constraint("add constraint");

		const std::string constraint_store("constraint store");
		const std::string clear_constraint_store("clear constraint store");
		
		const std::string track_variable_type("track variable type");
		const std::string track_variable_name("track variable name");
		const std::string track_variable_mutable("track variable mutable");
		const std::string track_variable("track variable");

		const std::string tracked_variables("tracked variables");
		const std::string clear_tracked_variables("clear tracked variables");

		const std::string error_id("error");
	}
};