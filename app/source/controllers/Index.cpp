#include"Index.hh"
#include<syslog.h>
#include<filesystem>
#include"../utils/utils.hh"
#include<vector>
#include<fstream>
void Index::asyncHandleHttpRequest
(
    const drogon::HttpRequestPtr &req,
    std::function<void(const drogon::HttpResponsePtr &)> &&callback
) 
{
    drogon::HttpAppFramework::instance().enableSession(utils::timeout_session);

    drogon::HttpViewData data;
    //data["name"] = req->getParameter("name");
    traitement_Get_Post(data,req);
    detection_exemples(req);
    Session_to_data(req,data);

    auto resp = drogon::HttpResponse::newHttpViewResponse("index_view", data);
    callback(resp);


}

void Index::traitement_Get_Post(drogon::HttpViewData &/*data*/,const drogon::HttpRequestPtr &req)
{
    if(req->getParameter(utils::key_type_requete)==utils::key_Add_constrain)
    {
        //traitement add un contrainte
        //la contrainte est retrouvable grace a req->getParameter(utils::key_Get_constrain)
    }
    if (req->getParameter(utils::key_type_requete)==utils::key_Remove_constrain)
    {       
        //traitement remove un contrainte
        //la contrainte est retrouvable grace a req->getParameter(utils::key_Get_constrain)
    }
    if (req->getParameter(utils::key_type_requete)==utils::key_Clear_constrain)
    {       
        //traitement Clear le store des contraintes
    }
    if (req->getParameter(utils::key_type_requete)==utils::key_load_exemple)
    {       
        //traitement ajout d'un exemple
        chargement_exemples(req,req->getParameter(utils::key_id_select_exemple));
    }


}

void Index::detection_exemples(const drogon::HttpRequestPtr &req)
{
    std::filesystem::path p;
    std::string nomfichier;
    std::vector<std::string> res;

    for(std::filesystem::directory_entry d: std::filesystem::directory_iterator(utils::emplacement_exemple_chr))
    {
        p =d.path();
        res.push_back(p.filename());
    }
    req->session()->insert(utils::key_Exemples_filenames,res);
}

void Index::chargement_exemples(const drogon::HttpRequestPtr &req,std::string  const&filename)
{
    std::ifstream file;
    file.open(utils::emplacement_exemple_chr+"/"+filename);
    if(file.is_open())
    {
        std::ostringstream ss;
        ss << file.rdbuf();
        req->session()->insert(utils::key_content_exemple,ss.str());
    }else{
        std::cout << "le fichier n'est pas ouvert" << std::endl;
    }
}

void Index::Session_to_data(const drogon::HttpRequestPtr &req,drogon::HttpViewData &data)
{
    
    data[utils::key_content_exemple]= req->session()->get<std::string>(utils::key_content_exemple);
    data[utils::key_Exemples_filenames]= req->session()->get<std::vector<std::string>>(utils::key_Exemples_filenames);

}
