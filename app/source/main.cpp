#include <drogon/HttpAppFramework.h>

int main() 
{
    // Adress: http://localhost:8000/ 
    const std::string ip("0.0.0.0");
    const uint16_t port(8000);
    drogon::app().addListener(ip, port);
    LOG_INFO << "Server running on " << ip << ":" << port;

    // Run the app
    drogon::app().setDocumentRoot("../source").run();
    return EXIT_SUCCESS;
}