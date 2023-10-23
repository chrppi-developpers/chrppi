#pragma once
#include<string>

namespace utils{
    /*
    =============================EMPLACEMENT FICHIER======================================
    */
    const std::string emplacement_static_file("static_files");
    const std::string emplacement_exemple_chr("exemple_chr");
    /*
    =============================KEY HTML======================================
    */
    const std::string key_type_requete("type");
    const std::string key_Add_constrain("Add");
    const std::string key_Remove_constrain("Remove");
    const std::string key_Clear_constrain("Clear");
    const std::string key_Get_constrain("Constraint");
    const std::string key_Exemples_filenames("Exemples Filenames");
    const std::string key_id_select_exemple("exemple id");
    const std::string key_load_exemple("load exemple");
    const std::string key_content_exemple("content exemple");
    const std::string key_id_form_contenue("form content");
    
//add the view of the index.html connect the différent form with the controller and add html session
    /*
    =============================CONFIGURATION DROGON======================================
    */

    const std::string ip("0.0.0.0");
    const uint16_t port(8000);
    const int timeout_session(500000);

};