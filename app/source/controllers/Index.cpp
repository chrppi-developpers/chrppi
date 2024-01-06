#include <syslog.h>
#include <filesystem>
#include <vector>
#include <fstream>
#include <regex>
#include <exception>
#include <cstdio>

#include "Index.hh"

namespace fs = std::filesystem;

void Index::asyncHandleHttpRequest(const drogon::HttpRequestPtr & req, std::function<void(const drogon::HttpResponsePtr &)> && callback)
{
	drogon::MultiPartParser req_multi_part;
    req_multi_part.parse(req);
    const std::map<std::string,std::string> & req_parameter(req_multi_part.getParameters());
	
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
				{ append_error("Unable to load example (" + exception.what() + ")", data, json_response);}
			}

			else
				append_error("Unable to load example", data, json_response);
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
					{ append_error("Unable to compile CHR code (" + exception.what() + ")", data, json_response); }
				}

				else
					append_error("Unable to compile CHR code", data, json_response);

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
		}

		// Add a constraint
		if (req_parameter.find(config::html::add_constraint) != req_parameter.end())
		{
			if (req_parameter.find(config::html::add_constraint_value) != req_parameter.end())
			{
				if (req_parameter.find(config::html::add_constraint_value) != req_parameter.end())
				{
					if (interpreter.has_session())
					{
						try { interpreter.add_constraint(req_parameter.find(config::html::add_constraint_value)->second); }
						catch (const Interpreter::Exception & exception)
						{ append_error("Unable to add constraint (" + exception.what() + ")", data, json_response); }
					}
					
					// Interpreter must have a session
					else
						append_error("You must commpile a CHR space first", data, json_response);
				}
				else
					append_error("Constraint is empty ", data, json_response);				
			}
			else
				append_error("Unable to add constraint Ajax query not correctly form", data, json_response);
		}

		// Remove a constraint
		if (req_parameter.find(config::html::remove_constraint) != req_parameter.end())
		{
			try { interpreter.remove_constraint(req_parameter.find(config::html::remove_constraint)->second); }
			catch (const Interpreter::Exception & exception)
			{ append_error("Unable to remove constraint (" + exception.what() + ")", data, json_response); }
		}

		// Clear constraint store
		if (req_parameter.find(config::html::clear_constraint_store) != req_parameter.end())
		{
			try { interpreter.clear_store(); }
			catch (const Interpreter::Exception & exception)
			{ append_error("Unable to clear constraint store (" + exception.what() + ")", data, json_response); }
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
					&&	req_parameter.find(config::html::variable_mutable) != req_parameter.end()
				)
				{
					// Get variable value (could be null)
					const std::optional<std::string> variable_value
					(
							req_parameter.find(config::html::variable_value) != req_parameter.end() 
						?
							std::optional<std::string> {req_parameter.find(config::html::variable_value)->second}
						:
							std::nullopt
					);

					// Only mutable variable can be defined with a value
					if (variable_value && req_parameter.find(config::html::variable_mutable)->second == "false")
						append_error("Unable to add variable (only mutable variables can be defined with a value)", data, json_response);

					else
					{
						try
						{
							interpreter.add_variable
							(
								req_parameter.find(config::html::variable_type)->second, 
								req_parameter.find(config::html::variable_name)->second, 
								req_parameter.find(config::html::variable_mutable)->second == "true",
								variable_value
							);
						}
						catch (const Interpreter::Exception & exception)
						{ append_error("Unable to add variable (" + exception.what() + ")", data, json_response); }
					}
				}

				// Variable parameter must have a value
				else
					append_error("A variable must have a type and a name", data, json_response);
			}

			// Interpreter must have a session
			else
				append_error("You must commpile a CHR space first", data, json_response);
		}

		// Remove a variable
		if (req_parameter.find(config::html::remove_variable) != req_parameter.end())
		{
			try { interpreter.remove_variable(req_parameter.find(config::html::remove_variable)->second); }
			catch (const Interpreter::Exception & exception)
			{ append_error("Unable to remove variable (" + exception.what() + ")", data, json_response); }
		}

		// Clear variables
		if (req_parameter.find(config::html::clear_variables) != req_parameter.end())
		{
			try { interpreter.clear_variables(); }
			catch (const Interpreter::Exception & exception)
			{ append_error("Unable to clear variables (" + exception.what() + ")", data, json_response); }
		}
	}

	// Upload a session
	else if (req->getPath() == config::url::upload_session)
	{
		// Invalid file upload
		drogon::MultiPartParser file_upload;
		if (file_upload.parse(req) != 0 || file_upload.getFiles().size() == 0)
			append_error("Invalid file upload", data, json_response);

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
				{ append_error("Cannot upload session (" + exception.what() + ")", data, json_response); }
			}
 
			else
				append_error("Uploaded session could not be parsed", data, json_response);
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
			const std::vector<std::string> constraint_store(interpreter.constraint_store());
			data[config::html::constraint_store] = constraint_store;
			for (const std::string & constraint: constraint_store)
				json_response[config::html::constraint_store].append(constraint);
		}
		catch (const Interpreter::Exception & exception)
		{ append_error("Cannot get constraint store (" + exception.what() + ")", data, json_response); }

	// Insert variables
	try 
	{
		const std::vector<Interpreter::Variable_definition> variables_definition(interpreter.variables_definition());
		data[config::html::variables] = variables_definition;
		Json::Value aux;
		for (const Interpreter::Variable_definition & variable_definition: variables_definition)
		{
			aux.clear();
			aux.append(variable_definition.declaration.type);
			aux.append(variable_definition.declaration.name);
			aux.append(variable_definition.value);
			
			json_response[config::html::variables].append(aux);
		}
	}
	catch (const Interpreter::Exception & exception)
	{ append_error("Cannot get variables (" + exception.what() + ")", data, json_response); }

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

void Index::append_error(const std::string & message, drogon::HttpViewData & data, Json::Value & json_response)
{
	// Append error to data
	std::vector<std::string> errors = data.get<std::vector<std::string>>(config::html::error);
	errors.push_back(message);
	data[config::html::error] = errors;

	// Append error to json response
	json_response[config::html::error].append(message);
}