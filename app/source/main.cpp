#include <drogon/HttpAppFramework.h>

#include "include/cling/include/cling/Interpreter/Interpreter.h"

int main(int argc, char * argv[]) 
{
    // Create an instance of the Cling interpreter.
      cling::Interpreter interp(argc, argv);

    // Evaluate a C++ expression.
    interp.process("#include <iostream>");
    interp.process("std::cout << \"Hello, world!\" << std::endl;");

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
