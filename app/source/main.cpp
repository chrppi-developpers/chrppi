#include <drogon/HttpAppFramework.h>
int main() 
{
    // Adress: http://localhost:8000/ 
    const std::string ip("0.0.0.0");
    const uint16_t port(8000);
    drogon::app().addListener(ip, port);
    drogon::app().setDocumentRoot("static_files");
    LOG_INFO << "Server running on " << ip << ":" << port;
    // Run the app
    drogon::app().run();
    return EXIT_SUCCESS;
}
