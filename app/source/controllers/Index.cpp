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

void Index::traitement_Get_Post(drogon::HttpViewData &data,const drogon::HttpRequestPtr &req)
{
    if(!req->getParameter(utils::key_Add_constrain).empty())
    {
        //traitement add un contrainte
        //la contrainte est retrouvable grace a req->getParameter(utils::key_Get_constrain)
        std::cout << "add constrainte" << std::endl;
    }
    if (!req->getParameter(utils::key_Clear_constrain).empty())
    {       
        std::cout << "Clear store " << std::endl;
        //traitement Clear le store des contraintes
    }
    if (!req->getParameter(utils::key_load_exemple).empty())
    {       
        //traitement ajout d'un exemple
        std::cout << "load exemple " << std::endl;
        chargement_exemples(req,req->getParameter(utils::key_id_select_exemple));
    }
    if (!req->getParameter(utils::key_champs_variable_track_button).empty())
    {       
        //traitement ajout du tracking d'une variable
        // le nom de la variable a track est retrouvable avec req->getParameter(utils::key_champs_variable_track)
        std::cout << "track button "<< std::endl;
        if(!req->getParameter(utils::key_champs_variable_track).empty())
        {
            
            std::cout << req->getParameter(utils::key_champs_variable_track) << std::endl;
            if(!req->getParameter(utils::name_value_variable_mutable_checkbox).empty())
            {
                if(!req->getParameter(utils::name_champs_variable_track_valeur_mutable).empty())
                {
                    std::cout << "valeur du mutable " << req->getParameter(utils::name_champs_variable_track_valeur_mutable) << std::endl;
                }else{
                    //création d'une erreur parce que la variables est dis mutable mais on a pas mis de valeur
                    ajoute_une_erreur(data,utils::erreur_mutable);
                }
            }
        }else{
            //creation d'une erreur parce que la variable est vide
            ajoute_une_erreur(data,utils::erreur_track_variable);
        }
        
        
    }
    if(!req->getParameter(utils::key_id_button_variable_store).empty())
    {
        //clear the variable store
        std::cout << "clear the variable store "<< std::endl;
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

void Index::ajoute_une_erreur(drogon::HttpViewData &data,std::string error)
{
    std::vector<std::string> errors=data.get<std::vector<std::string>>( utils::id_erreur);
    errors.push_back(error);
    data[utils::id_erreur]=errors;
}