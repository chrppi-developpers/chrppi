#include <drogon/HttpAppFramework.h>
#include"utils/utils.hh"


int main(int , char * []) 
{

    // Adress: http://localhost:8000/ 
    
    drogon::app().addListener(utils::ip, utils::port);
    drogon::app().setDocumentRoot(utils::emplacement_static_file);
    drogon::app().enableSession(utils::timeout_session);
    //drogon::app().setFileTypes({"csp"});
    LOG_INFO << "Server running on " << utils::ip << ":" << utils::port;
    // Run the app
    drogon::app().run();
    return EXIT_SUCCESS;
}
