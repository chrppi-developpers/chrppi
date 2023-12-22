#include <drogon/HttpAppFramework.h>
#include <cstdlib>

#include"config.hh"

// Run drogon app
int main()
{
	// Drogon port given by environment
	uint16_t port;
	if (const char * port_str = std::getenv("INTERNAL_PORT"))
		port = std::atoi(port_str);

	// Fail to run
	else
	{
		LOG_FATAL << "INTERNAL_PORT environment variable must be set";
		return EXIT_FAILURE;
	}

	// Configure the app
	drogon::app()
		.addListener(config::drogon::ip, port)
		.setDocumentRoot(config::drogon::document_root)
        .setUploadPath(config::drogon::upload_path)
		.enableSession(config::drogon::session_timeout)
		.setClientMaxBodySize(config::drogon::client_max_body_size)
	;

	// Run the app
	LOG_INFO << "Server running on " << config::drogon::ip << ":" << port;
	drogon::app().run();

	return EXIT_SUCCESS;
}