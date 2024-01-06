#include <syslog.h>
#include <filesystem>
#include <vector>
#include <fstream>
#include <regex>
#include <exception>
#include <cstdio>

#include "Index.hh"

namespace fs = std::filesystem;

std::string to_string(drogon::HttpMethod httpMethod)
{
	switch (httpMethod)
	{
		case drogon::Get:	return "GET";
    	case drogon::Post:	return "POST";
    	default:			return std::to_string(httpMethod);
	}
}

void Index::asyncHandleHttpRequest(const drogon::HttpRequestPtr & req, std::function<void(const drogon::HttpResponsePtr &)> && callback)
{
	drogon::MultiPartParser req_multi_part;
    req_multi_part.parse(req);
    std::map<std::string,std::string> req_parameter(req_multi_part.getParameters());
	
	drogon::HttpViewData data;
	drogon::HttpResponsePtr resp(nullptr);
	Json::Value json_response;

	LOG_INFO
		<< "[thread " << std::distance(_interpreter_pool.begin(), _interpreter_pool.find(std::this_thread::get_id())) + 1 
		<< "] session @" << req->session()->sessionId() << ": " << req->getMethodString() << " " << req->getPath(); 

	// Get interpreter corresponding to current thread
	Interpreter & interpreter(_interpreter_pool[std::this_thread::get_id()]);

	// Get back user session
	{
		std::optional<Json::Value> json_session(req->session()->getOptional<Json::Value>(config::session::json));
		if (json_session)
			interpreter.new_session(*json_session);
		interpreter.session_id(req->session()->sessionId());
	}

	// Index
	if (req->getPath() == config::url::root)
	{		
		// Load an example
		if (req_parameter.find(config::html::select_example) != req_parameter.end())
		{
			std::string chr_filename(config::file::chr_examples + "/" + req_parameter.find(config::html::select_example)->second);
			std::ifstream chr_file(chr_filename);
			if (chr_file.is_open())
			{
				// Define space
				try { interpreter.define_space(chr_filename); }
				catch (const Interpreter::Exception & exception)
				{ add_error(json_response, "Unable to load example (" + exception.what() + ")"); }
			}

			else
				add_error(json_response, "Unable to load example");
		}

		// Compile
		if (req_parameter.find(config::html::compile) != req_parameter.end())
		{
			if (req_parameter.find(config::html::chr_code) != req_parameter.end())
			{
				// Create space file for current session
				const std::string chr_path(config::file::chr_spaces + "/" + req->session()->sessionId() + ".txt");
				std::ofstream chr_file(chr_path, std::ios::binary);

				if (chr_file.is_open())
				{
					// Get CHR code without cariage return characters added by textarea
					std::string chr_code(std::regex_replace(req_parameter.find(config::html::chr_code)->second, std::regex {"\r\n"}, "\n"));

					// Write and close CHR file
					chr_file << chr_code;
					chr_file.close();

					// Define space
					try { interpreter.define_space(chr_path); }
					catch (const Interpreter::Exception & exception)
					{ add_error(json_response, "Unable to compile CHR code (" + exception.what() + ")"); }
				}

				else
					add_error(json_response, "Unable to compile CHR code");

				// Remove space file for current session
				std::remove(chr_path.c_str());
			}
		}

		// Download a session
		if (req_parameter.find(config::html::download_session) != req_parameter.end())
		{
			// Set the content type and body of the response
			Json::StreamWriterBuilder json_stream_writer;
			resp = drogon::HttpResponse::newHttpResponse(drogon::HttpStatusCode::k200OK, drogon::ContentType::CT_APPLICATION_JSON);
			resp->setBody(Json::writeString(json_stream_writer, interpreter.json_session()));

			// Set the content disposition header to trigger a file download
			resp->addHeader("Content-Disposition", "attachment; filename=session.json");
		}

		// Add a constraint
		if (req_parameter.find(config::html::add_constraint) != req_parameter.end())
		{
			if (req_parameter.find(config::html::add_constraint_value) != req_parameter.end())
			{
				if (!req_parameter.find(config::html::add_constraint_value)->second.empty())
				{
					try { interpreter.add_constraint(req_parameter.find(config::html::add_constraint_value)->second); }
					catch (const Interpreter::Exception & exception)
					{ 
						add_error(json_response, "Unable to add constraint (" + exception.what() + ")"); 
					}
				}
				else
				{
					add_error(json_response, "Constraint is empty ");
				}
				
			}
			else
			{
				add_error(json_response,"Unable to add constraint Ajax query not correctly form");
			}
		}

		// Remove a constraint
		if (req_parameter.find(config::html::remove_constraint) != req_parameter.end())
		{
			try { interpreter.remove_constraint(req_parameter.find(config::html::remove_constraint)->second); }
			catch (const Interpreter::Exception & exception)
			{ add_error(json_response, "Unable to remove constraint (" + exception.what() + ")"); }
		}

		// Clear constraint store
		if (req_parameter.find(config::html::clear_constraint_store) != req_parameter.end())
		{
			try { interpreter.clear_store(); }
			catch (const Interpreter::Exception & exception)
			{ add_error(json_response, "Unable to clear constraint store (" + exception.what() + ")"); }
		}

		// Add a variable
		if (req_parameter.find(config::html::add_variable) != req_parameter.end())
		{
			if (interpreter.has_session())
			{
				if 
				(
						req_parameter.find(config::html::variable_name) != req_parameter.end() 
					&&	req_parameter.find(config::html::variable_type) != req_parameter.end() 
					&&	req_parameter.find(config::html::variable_mutable)!=req_parameter.end() 
				)
				{
					try
					{
						interpreter.add_variable
						(
							req_parameter.find(config::html::variable_type)->second, 
							req_parameter.find(config::html::variable_name)->second, 
							req_parameter.find(config::html::variable_mutable)->second == "true"
						);
					}
					catch (const Interpreter::Exception & exception)
					{ add_error(json_response, "Unable to add variable (" + exception.what() + ")"); }
				}

				// Variable parameter must have a value
				else
					add_error(json_response, "A variable must have a type and a name");
			}

			// Interpreter must have a session
			else
				add_error(json_response, "You must commpile a CHR space first");
		}

		// Remove a variable
		if (req_parameter.find(config::html::remove_variable) != req_parameter.end())
		{
			try { interpreter.remove_variable(req_parameter.find(config::html::remove_variable)->second); }
			catch (const Interpreter::Exception & exception)
			{ add_error(json_response, "Unable to remove variable (" + exception.what() + ")"); }
		}

		// Clear variables
		if (req_parameter.find(config::html::clear_variables) != req_parameter.end())
		{
			try { interpreter.clear_variables(); }
			catch (const Interpreter::Exception & exception)
			{ add_error(json_response, "Unable to clear variables (" + exception.what() + ")"); }
		}
	}

	// Upload a session
	else if (req->getPath() == config::url::upload_session)
	{
		// Invalid file upload
		drogon::MultiPartParser file_upload;
		if (file_upload.parse(req) != 0 || file_upload.getFiles().size() == 0)
			add_error(json_response, "Invalid file upload");

		else
		{
			// Parse and update session
			Json::CharReaderBuilder json_char_reader;
			std::istringstream json_session_stream(std::string {file_upload.getFiles()[0].fileContent()});
			Json::Value json_session;
			if (Json::parseFromStream(json_char_reader, json_session_stream, &json_session, nullptr))
			{
				// Start a new session based on given json
				try { interpreter.new_session(json_session); }
				catch (const Interpreter::Exception & exception)
				{ add_error(data, "Cannot upload session (" + exception.what() + ")"); }
			}
 
			else
				add_error(data, "Uploaded session could not be parsed");
		}

		// Update json session
		if (interpreter.has_session())
		{
			req->session()->erase(config::session::json);
			req->session()->insert(config::session::json, interpreter.json_session());
		}
	}

	// Insert examples
	fs::path path;
	std::string file_name;
	std::vector<std::string> chr_examples;
	for (fs::directory_entry directory: fs::directory_iterator(config::file::chr_examples))
	{
		path = directory.path();
		chr_examples.push_back(path.filename());
		json_response[config::html::chr_examples].append(path.filename().c_str());
	}
	data[config::html::chr_examples] = chr_examples;

	// Insert constraint store if session is started
	if (interpreter.has_session())
		try 
		{ 
			data[config::html::constraint_store] = interpreter.constraint_store();
			for (const std::string & constraint:interpreter.constraint_store())
				json_response[config::html::constraint_store].append(constraint);
		}
		catch (const Interpreter::Exception & exception)
		{ 
			add_error(data, "Cannot get constraint store (" + exception.what() + ")");
			add_error(json_response, "Cannot get constraint store (" + exception.what() + ")");
		}

	// Insert variables
	try 
	{
		data[config::html::variables] = interpreter.variables_values();
		Json::Value aux;
		for (const std::pair<std::string,std::string> & variable: interpreter.variables_values())
		{
			aux.clear();
			aux.append(variable.first);
			aux.append(variable.second);
			
			json_response[config::html::variables].append(aux);
		}
	}
	catch (const Interpreter::Exception & exception)
	{ 
		add_error(data, "Cannot get variables (" + exception.what() + ")");
		add_error(json_response, "Cannot get variables (" + exception.what() + ")"); 
	}

	// Send CHR code to HTML
	data[config::html::chr_code] = interpreter.space();
	json_response[config::html::chr_code] = interpreter.space();

	// Response has not been set yet
	if (!resp)
	{
		// Return an update in Json format
		if (req_parameter.find(config::html::ajax_request) != req_parameter.end())
 			resp = drogon::HttpResponse::newHttpJsonResponse(json_response);

		// Return the view with data
		else
			resp = drogon::HttpResponse::newHttpViewResponse("index_view", data);
	}

	// Update json session
	if (interpreter.has_session())
	{
		req->session()->erase(config::session::json);
		req->session()->insert(config::session::json, interpreter.json_session());
	}

	callback(resp);
}

void Index::add_error(drogon::HttpViewData & data, const std::string & error)
{
	std::vector<std::string> errors = data.get<std::vector<std::string>>(config::html::error_id);
	errors.push_back(error);
	data[config::html::error_id] = errors;
}

void Index::add_error(Json::Value & json_response, const std::string & error)
{
	json_response[config::html::error_id].append(error);
}