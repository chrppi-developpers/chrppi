//this file is generated by program(drogon_ctl) automatically,don't modify it!
#include "index_view.h"
#include <drogon/utils/OStringStream.h>
#include <string>
#include <map>
#include <vector>
#include <set>
#include <iostream>
#include <unordered_map>
#include <unordered_set>
#include <algorithm>
#include <list>
#include <deque>
#include <queue>
#include "../source/utils/utils.hh" 
using namespace drogon;
std::string index_view::genText(const DrTemplateData& index_view_view_data)
{
	drogon::OStringStream index_view_tmp_stream;
	std::string layoutName{""};
	index_view_tmp_stream << "<!DOCTYPE html>\n";
	index_view_tmp_stream << "<html>\n";
	index_view_tmp_stream << "	<head>\n";
	index_view_tmp_stream << "		<meta charset=\"utf-8\">\n";
	index_view_tmp_stream << "		<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n";
	index_view_tmp_stream << "		<title>CHRPPI</title>\n";
	index_view_tmp_stream << "		<link rel=\"stylesheet\" \n";
	index_view_tmp_stream << "        href=\"https://cdnjs.cloudflare.com/ajax/libs/bulma/0.7.0/css/bulma.min.css\">\n";
	index_view_tmp_stream << "		<script defer src=\"https://use.fontawesome.com/releases/v5.0.7/js/all.js\"></script>\n";
	index_view_tmp_stream << "        <!--<link rel=\"stylesheet\" href=\"css/debug.css\">-->\n";
	index_view_tmp_stream << "		<link rel=\"stylesheet\" href=\"css/main.css\">\n";
	index_view_tmp_stream << "		<script type=\"text/javascript\" src=\"scripts/main.js\" defer></script>		\n";
	index_view_tmp_stream << "<style>\n";
	index_view_tmp_stream << "			.grid {\n";
	index_view_tmp_stream << "	display: grid;\n";
	index_view_tmp_stream << "	grid-template-columns: 1fr 1fr 1fr;\n";
	index_view_tmp_stream << "}\n";
index_view_tmp_stream<<"\n";
	index_view_tmp_stream << ".grid * { grid-column: 2 / 3; };\n";
index_view_tmp_stream<<"\n";
	index_view_tmp_stream << ".center{\n";
	index_view_tmp_stream << "    display: flex;\n";
	index_view_tmp_stream << "    justify-content: center;\n";
	index_view_tmp_stream << "    align-items: center;\n";
	index_view_tmp_stream << "};\n";
	index_view_tmp_stream << ".block:not(:last-child) {\n";
	index_view_tmp_stream << "  margin-bottom: 1.5rem;\n";
	index_view_tmp_stream << "};\n";
index_view_tmp_stream<<"\n";
index_view_tmp_stream<<"\n";
	index_view_tmp_stream << ".flexContainer {\n";
	index_view_tmp_stream << "    display: flex;\n";
	index_view_tmp_stream << "};\n";
index_view_tmp_stream<<"\n";
	index_view_tmp_stream << ".inputField {\n";
	index_view_tmp_stream << "    flex: 1;\n";
	index_view_tmp_stream << "};\n";
	index_view_tmp_stream << "		</style>\n";
	index_view_tmp_stream << "	</head>\n";
index_view_tmp_stream<<"\n";
index_view_tmp_stream<<"\n";
index_view_tmp_stream<<"\n";
	index_view_tmp_stream << "	<body>\n";
	index_view_tmp_stream << "		<div >\n";
	index_view_tmp_stream << "			<form  id=\"";
 index_view_tmp_stream<< utils::id_form_file;
	index_view_tmp_stream << "\" action=\"\" method=\"post\" enctype=\"multipart/form-data\">\n";
	index_view_tmp_stream << "				<div class=\"field has-addons\">\n";
	index_view_tmp_stream << "					<div class=\"file\">\n";
	index_view_tmp_stream << "						<label class=\"file-label\">\n";
	index_view_tmp_stream << "						  <input class=\"file-input\" type=\"file\" name=\"";
 index_view_tmp_stream<<utils::name_file_session; 
	index_view_tmp_stream << "\" id=\"";
 index_view_tmp_stream<<utils::id_session_file; 
	index_view_tmp_stream << "\">\n";
	index_view_tmp_stream << "						  <span class=\"file-cta\">\n";
	index_view_tmp_stream << "							<span class=\"file-icon\">\n";
	index_view_tmp_stream << "							  <i class=\"fas fa-upload\"></i>\n";
	index_view_tmp_stream << "							</span>\n";
	index_view_tmp_stream << "							<span class=\"file-label\">\n";
	index_view_tmp_stream << "							  Choose a file…\n";
	index_view_tmp_stream << "							</span>\n";
	index_view_tmp_stream << "						  </span>\n";
	index_view_tmp_stream << "						  <span class=\"file-name\" id=\"";
 index_view_tmp_stream<<utils::id_session_filename; 
	index_view_tmp_stream << "\">\n";
	index_view_tmp_stream << "							Session file to load\n";
	index_view_tmp_stream << "						  </span>\n";
	index_view_tmp_stream << "						</label>\n";
	index_view_tmp_stream << "					</div>\n";
	index_view_tmp_stream << "					<input type=\"button\" id=\"";
 index_view_tmp_stream<< utils::id_load_session;
	index_view_tmp_stream << "\"  name=\"";
 index_view_tmp_stream <<utils::name_load_session;
	index_view_tmp_stream << "\"  class=\"button is-info\" value=\"load session\" />\n";
index_view_tmp_stream<<"\n";
	index_view_tmp_stream << "				</div>\n";
	index_view_tmp_stream << "			</form>\n";
index_view_tmp_stream<<"\n";
index_view_tmp_stream<<"\n";
	index_view_tmp_stream << "		</div>\n";
	index_view_tmp_stream << "		<form id=\"";
 index_view_tmp_stream<< utils::key_id_form_contenue;
	index_view_tmp_stream << "\" action=\"\" method=\"post\">	\n";
	index_view_tmp_stream << "			<section class=\"hero has-background-danger \">\n";
	index_view_tmp_stream << "        	    <div class=\"hero-body\">\n";
	index_view_tmp_stream << "					<div class=\"columns is-multiline  is-centered\">\n";
	index_view_tmp_stream << "						<div class=\"column is-one-three \">\n";
	index_view_tmp_stream << "        	    			<div class=\" center  is-info\">\n";
	index_view_tmp_stream << "        	    			    <p class=\"title\">chrppi</p>\n";
	index_view_tmp_stream << "        	    			</div>\n";
	index_view_tmp_stream << "						</div>\n";
	index_view_tmp_stream << "						<div class=\"column is-one-three center\">\n";
	index_view_tmp_stream << "							<div class=\"field has-addons\">\n";
	index_view_tmp_stream << "        	    				<div class=\"select\">\n";
	index_view_tmp_stream << "									<select id=\"";
 index_view_tmp_stream<<utils::key_id_select_exemple;
	index_view_tmp_stream << "\" name=\"";
 index_view_tmp_stream<<utils::key_id_select_exemple;
	index_view_tmp_stream << "\">\n";
	index_view_tmp_stream << "										";
										std::vector<std::string> filename_exemples=index_view_view_data.get<std::vector<std::string>>(utils::key_Exemples_filenames);
										for(std::string const&file:filename_exemples)
										{
											index_view_tmp_stream << "<option value=\"" <<file <<"\" >" << file <<"</option>"; 
										}
										
	index_view_tmp_stream << "									</select>\n";
	index_view_tmp_stream << "								</div>\n";
	index_view_tmp_stream << "								<input type=\"submit\" name=\"";
 index_view_tmp_stream <<utils::key_load_exemple;
	index_view_tmp_stream << "\"  class=\"button is-info\" value=\"Load Exemple\" />	\n";
	index_view_tmp_stream << "							</div>\n";
	index_view_tmp_stream << "						</div>\n";
	index_view_tmp_stream << "						<div class=\"column is-one-three center\">\n";
	index_view_tmp_stream << "							\n";
	index_view_tmp_stream << "						</div>\n";
	index_view_tmp_stream << "					</div>\n";
	index_view_tmp_stream << "				</div>\n";
	index_view_tmp_stream << "        	</section>\n";
	index_view_tmp_stream << "		\n";
	index_view_tmp_stream << "			";
				std::vector<std::string> errors=index_view_view_data.get<std::vector<std::string>>(utils::id_erreur);
				if(!errors.empty())
				{
					index_view_tmp_stream<<"<section class=\"section\"> <div class=\"notification is-danger\"> <p class=\"title\">ERROR</p> <ul>";
						for(std::string &error: errors)
						{
							index_view_tmp_stream<< "<li>" <<  error << "</li>";
						}
					index_view_tmp_stream<<"</ul></div></section>";
				}
			
	index_view_tmp_stream << "			<section class=\"section\">\n";
index_view_tmp_stream<<"\n";
	index_view_tmp_stream << "				<div class=\"columns is-multiline  is-centered\">\n";
	index_view_tmp_stream << "					<div class=\"column is-one-two \" >\n";
	index_view_tmp_stream << "						<div class=\"columns is-multiline  is-centered\">\n";
	index_view_tmp_stream << "							<div class=\"column is-one-third center\" >\n";
	index_view_tmp_stream << "								<button class=\"button\">AutoCompilation</button>\n";
	index_view_tmp_stream << "							</div>\n";
	index_view_tmp_stream << "							<div class=\"column is-one-third center\">\n";
	index_view_tmp_stream << "								<button class=\"button \">Persistance</button>\n";
	index_view_tmp_stream << "							</div>\n";
	index_view_tmp_stream << "							<div class=\"column is-one-third center\">\n";
	index_view_tmp_stream << "								<button class=\"button\">Tracing</button>\n";
	index_view_tmp_stream << "							</div>\n";
	index_view_tmp_stream << "						</div>\n";
	index_view_tmp_stream << "						<textarea  class=\"textarea is-primary \" placeholder=\"CHR CODE\" rows=\"20\">";
index_view_tmp_stream<< index_view_view_data.get<std::string>(utils::key_content_exemple);
	index_view_tmp_stream << "</textarea>\n";
	index_view_tmp_stream << "						<input type=\"submit\" name=\"";
 index_view_tmp_stream <<utils::name_download_session;
	index_view_tmp_stream << "\"  class=\"button is-info\" value=\"Download Your Session\" />	\n";
	index_view_tmp_stream << "					</div>\n";
	index_view_tmp_stream << "					<div class=\"column is-one-two \" >\n";
	index_view_tmp_stream << "						<div class=\"box\">\n";
	index_view_tmp_stream << "							<div class=\"block\">\n";
	index_view_tmp_stream << "								<div class=\"block\">\n";
	index_view_tmp_stream << "									<p class=\"is-size-10\">ADD Constraint</p> \n";
	index_view_tmp_stream << "									<div class=\"field has-addons\">\n";
	index_view_tmp_stream << "										<div class=\"control is-expanded\">\n";
	index_view_tmp_stream << "											<input class=\"input is-danger\" name=\"";
 index_view_tmp_stream<<utils::key_Get_constrain;
	index_view_tmp_stream << "\" size=\"20\" type=\"text\"  placeholder=\"Add Constraint\">\n";
	index_view_tmp_stream << "										</div>\n";
	index_view_tmp_stream << "										<div class=\"control\">\n";
	index_view_tmp_stream << "											<input type=\"submit\" name=\"";
 index_view_tmp_stream<<utils::key_Add_constrain;
	index_view_tmp_stream << "\"   class=\"button is-danger\" value=\"Add\" />\n";
	index_view_tmp_stream << "										</div>\n";
	index_view_tmp_stream << "									</div>							  \n";
	index_view_tmp_stream << "								</div>\n";
	index_view_tmp_stream << "							</div>\n";
	index_view_tmp_stream << "						</div>\n";
	index_view_tmp_stream << "						<div class=\"box\">\n";
	index_view_tmp_stream << "							<div class=\"block\">\n";
	index_view_tmp_stream << "								<div class=\"block\">\n";
	index_view_tmp_stream << "									<div class=\"block\">\n";
	index_view_tmp_stream << "										<p class=\"is-size-10\">Constraint Store</p>\n";
	index_view_tmp_stream << "									</div>\n";
	index_view_tmp_stream << "									<div class=\"block\">\n";
	index_view_tmp_stream << "										<input type=\"submit\" name=\"";
 index_view_tmp_stream<<utils::key_Clear_constrain;
	index_view_tmp_stream << "\" class=\"button is-danger\" value=\"Clear\" />\n";
	index_view_tmp_stream << "									</div>\n";
	index_view_tmp_stream << "								</div>\n";
	index_view_tmp_stream << "								<div class=\"block\">\n";
	index_view_tmp_stream << "									<table class=\"table is-fullwidth\">\n";
	index_view_tmp_stream << "										<thead>\n";
	index_view_tmp_stream << "										  <tr>\n";
	index_view_tmp_stream << "											<th>ID</th>\n";
	index_view_tmp_stream << "											<th>Constraint</th>\n";
	index_view_tmp_stream << "										  </tr>\n";
	index_view_tmp_stream << "										</thead>\n";
	index_view_tmp_stream << "									</table>\n";
	index_view_tmp_stream << "								</div>\n";
	index_view_tmp_stream << "							</div>\n";
	index_view_tmp_stream << "						</div>\n";
	index_view_tmp_stream << "						<div class=\"box\">\n";
	index_view_tmp_stream << "							<div class=\"block\">\n";
	index_view_tmp_stream << "								<p class=\"is-size-10\">Track a Variable</p> \n";
	index_view_tmp_stream << "								<div class=\"field has-addons\">\n";
	index_view_tmp_stream << "									<div class=\"control is-expanded\">\n";
	index_view_tmp_stream << "										<input class=\"input is-danger\" name=\"";
 index_view_tmp_stream<<utils::key_champs_variable_track;
	index_view_tmp_stream << "\" size=\"20\" type=\"text\"  placeholder=\"Variable\">\n";
	index_view_tmp_stream << "									</div>\n";
	index_view_tmp_stream << "									<div class=\"control\">\n";
	index_view_tmp_stream << "										<input type=\"submit\"  name=\"";
 index_view_tmp_stream<<utils::key_champs_variable_track_button;
	index_view_tmp_stream << "\" class=\"button is-danger\" value=\"Track\" />\n";
	index_view_tmp_stream << "									</div>\n";
	index_view_tmp_stream << "								</div>	\n";
index_view_tmp_stream<<"\n";
	index_view_tmp_stream << "								<div class=\"control\">\n";
	index_view_tmp_stream << "									<label class=\"checkbox\">\n";
	index_view_tmp_stream << "										<input type=\"checkbox\" name=\"";
 index_view_tmp_stream<<utils::name_value_variable_mutable_checkbox;
	index_view_tmp_stream << "\" id=\"";
 index_view_tmp_stream<<utils::id_value_variable_mutable_checkbox	;
	index_view_tmp_stream << "\">\n";
	index_view_tmp_stream << "										Mutable\n";
	index_view_tmp_stream << "									</label>\n";
	index_view_tmp_stream << "								</div>\n";
	index_view_tmp_stream << "								<div class=\"control\">\n";
	index_view_tmp_stream << "									<input class=\"input is-danger is-hidden\" id=\"";
 index_view_tmp_stream<<utils::id_value_variable_mutable;
	index_view_tmp_stream << "\" name=\"";
 index_view_tmp_stream<<utils::name_champs_variable_track_valeur_mutable;
	index_view_tmp_stream << "\" size=\"10\" type=\"text\"  placeholder=\"Value\">\n";
	index_view_tmp_stream << "								</div>\n";
	index_view_tmp_stream << "							</div>\n";
	index_view_tmp_stream << "						</div>\n";
index_view_tmp_stream<<"\n";
	index_view_tmp_stream << "						<div class=\"box\">\n";
	index_view_tmp_stream << "							<div class=\"block\">\n";
	index_view_tmp_stream << "								<div class=\"block\">\n";
	index_view_tmp_stream << "									<div class=\"block\">\n";
	index_view_tmp_stream << "										<p class=\"is-size-10\">Variable Tracked</p>\n";
	index_view_tmp_stream << "									</div>\n";
	index_view_tmp_stream << "									<div class=\"block\">\n";
	index_view_tmp_stream << "										<input type=\"submit\" name=\"";
 index_view_tmp_stream<< utils::key_id_button_variable_store;
	index_view_tmp_stream << "\"  class=\"button is-danger\" value=\"Clear\" />\n";
	index_view_tmp_stream << "									</div>\n";
	index_view_tmp_stream << "								</div>\n";
	index_view_tmp_stream << "								<div class=\"block\">\n";
	index_view_tmp_stream << "									<table class=\"table is-fullwidth\">\n";
	index_view_tmp_stream << "										<thead>\n";
	index_view_tmp_stream << "										  <tr>\n";
	index_view_tmp_stream << "											<th>Variable</th>\n";
	index_view_tmp_stream << "											<th>Value</th>\n";
	index_view_tmp_stream << "										  </tr>\n";
	index_view_tmp_stream << "										</thead>\n";
	index_view_tmp_stream << "									</table>\n";
	index_view_tmp_stream << "								</div>\n";
	index_view_tmp_stream << "							</div>\n";
	index_view_tmp_stream << "						</div>\n";
	index_view_tmp_stream << "					</div>\n";
	index_view_tmp_stream << "				</div>\n";
	index_view_tmp_stream << "			</section>\n";
	index_view_tmp_stream << "		</form>\n";
	index_view_tmp_stream << "	</body>\n";
	index_view_tmp_stream << "</html>\n";
if(layoutName.empty())
{
std::string ret{std::move(index_view_tmp_stream.str())};
return ret;
}else
{
auto templ = DrTemplateBase::newTemplate(layoutName);
if(!templ) return "";
HttpViewData data = index_view_view_data;
auto str = std::move(index_view_tmp_stream.str());
if(!str.empty() && str[str.length()-1] == '\n') str.resize(str.length()-1);
data[""] = std::move(str);
return templ->genText(data);
}
}
