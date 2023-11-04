#pragma once
#include<string>

namespace utils{
    /*
    =============================EMPLACEMENT FICHIER======================================
    */
    const std::string emplacement_static_file("static_files");
    const std::string emplacement_exemple_chr("exemple_chr");
    const std::string upload_path("./uploads");
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
    const std::string key_id_button_variable_store("variable store");
    const std::string key_champs_variable_track("track variable");
    const std::string key_champs_variable_track_button("track variable button");
    const std::string name_champs_variable_track_valeur_mutable("track variable mutable");
    const std::string id_value_variable_mutable("mutable id");
    const std::string id_value_variable_mutable_checkbox("mutable checkbox id");
    const std::string name_value_variable_mutable_checkbox("mutable checkbox name");
    const std::string name_file_session("name file session");
    const std::string name_load_session("name load session");
    const std::string id_load_session("id load session");
    const std::string id_session_filename("id session filename");
    const std::string id_session_file("id session file");
    const std::string id_form_file("id form file");
    const std::string name_download_session("name download session");
    
    
    

    /*
    =============================Data Key======================================
    */
    const std::string id_erreur("erreur");
    
    
//add the view of the index.html connect the différent form with the controller and add html session
    /*
    =============================CONFIGURATION DROGON======================================
    */

    const std::string ip("0.0.0.0");
    const uint16_t port(8000);
    const int timeout_session(500000);
    /*
    =============================ERROR======================================
    */
    const std::string erreur_mutable("Variable mutable but no value given");
    const std::string erreur_track_variable("Want to track variable but no name given");

};