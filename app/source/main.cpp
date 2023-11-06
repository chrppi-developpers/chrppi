#include <drogon/HttpAppFramework.h>
#include"utils/utils.hh"

// Run drogon app
// $1 is the port used by drogon
int main(int argc, char * argv[])
{
	// Fail to run
	if (argc < 2)
	{
		LOG_FATAL << "A port must be given as argument (execute run.sh to use the right port)";
		return EXIT_FAILURE;
	}

	// App constants
	const std::string ip("0.0.0.0");
	const uint16_t port(std::atoi(argv[1]));

	// Configure the app
	drogon::app()
		.addListener(ip, port)
		.setDocumentRoot("static_files")
		.enableSession(500000)
		.setClientMaxBodySize(20 * 2000 * 2000)
        	.setUploadPath(utils::upload_path)
	;

	// Run the app
	LOG_INFO << "Server running on " << ip << ":" << port;
	drogon::app().run();

	return EXIT_SUCCESS;
}
