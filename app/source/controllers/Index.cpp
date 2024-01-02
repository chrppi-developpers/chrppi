#include <syslog.h>
#include <filesystem>
#include <vector>
#include <fstream>
#include <regex>

#include "Index.hh"
#include "../config.hh"

namespace fs = std::filesystem;

void Index::asyncHandleHttpRequest(const drogon::HttpRequestPtr & req, std::function<void(const drogon::HttpResponsePtr &)> && callback)
{
	drogon::HttpViewData data;
	drogon::HttpResponsePtr resp(nullptr);

	// Index
	if (req->getPath() == "/")
	{
		// Load an example
		if (!req->getParameter(config::html::select_example).empty())
		{
			std::ifstream chr_file(config::path::chr_examples + "/" + req->getParameter(config::html::select_example));
			if (chr_file.is_open())
			{
				// Update HTML
				std::stringstream file_stream;
				file_stream << chr_file.rdbuf();
				req->session()->erase(config::html::chr_code);
				req->session()->insert(config::html::chr_code, file_stream.str());

				// Define space
				try { _interpreter.define_space(config::path::chr_examples + "/" + req->getParameter(config::html::select_example)); }
				catch (const Interpreter::Exception & exception)
				{ add_error(data, "Unable to load example (" + exception.what() + ")"); }
			}

			else
				add_error(data, "Unable to load example");
		}

		// Compile
		if (!req->getParameter(config::html::compile).empty())
		{
			if (!req->getParameter(config::html::chr_code).empty())
			{
				const std::string chr_path(config::path::chr_spaces + "/space.txt");
				std::ofstream chr_file(chr_path, std::ios::binary);
				if (chr_file.is_open())
				{
					// Get CHR code without cariage return characters added by textarea
					std::string chr_code(std::regex_replace(req->getParameter(config::html::chr_code), std::regex {"\r\n"}, "\n"));

					// Update HTML
					req->session()->erase(config::html::chr_code);
					req->session()->insert(config::html::chr_code, chr_code);

					// Write and close CHR file
					chr_file << chr_code;
					chr_file.close();

					// Define space
					try { _interpreter.define_space(chr_path); }
					catch (const Interpreter::Exception & exception)
					{ add_error(data, "Unable to compile CHR code (" + exception.what() + ")"); }
				}

				else
					add_error(data, "Unable to compile CHR code");
			}
		}

		// Download a session
		else if (!req->getParameter(config::html::download_session).empty())
		{
			// Set the content type and body of the response
			Json::StreamWriterBuilder json_stream_writer;
			resp = drogon::HttpResponse::newHttpResponse(drogon::HttpStatusCode::k200OK, drogon::ContentType::CT_APPLICATION_JSON);
			resp->setBody(Json::writeString(json_stream_writer, _interpreter.json_session()));

			// Set the content disposition header to trigger a file download
			resp->addHeader("Content-Disposition", "attachment; filename=session.json");
		}

		// Add a constraint
		else if (!req->getParameter(config::html::add_constraint).empty())
		{
			try { _interpreter.add_constraint(req->getParameter(config::html::add_constraint_value)); }
			catch (const Interpreter::Exception & exception)
			{ add_error(data, "Unable to add constraint (" + exception.what() + ")"); }
		}

		// Remove a constraint
		else if (!req->getParameter(config::html::remove_constraint).empty())
		{
			try { _interpreter.remove_constraint(req->getParameter(config::html::remove_constraint)); }
			catch (const Interpreter::Exception & exception)
			{ add_error(data, "Unable to remove constraint (" + exception.what() + ")"); }
		}

		// Clear constraint store
		else if (!req->getParameter(config::html::clear_constraint_store).empty())
		{
			try { _interpreter.clear_store(); }
			catch (const Interpreter::Exception & exception)
			{ add_error(data, "Unable to clear constraint store (" + exception.what() + ")"); }
		}

		// Add a variable
		else if (!req->getParameter(config::html::add_variable).empty())
		{
			if (_interpreter.has_session())
			{
				if (!req->getParameter(config::html::variable_name).empty() && !req->getParameter(config::html::variable_type).empty())
				{
					try
					{
						_interpreter.add_variable
						(
							req->getParameter(config::html::variable_type), 
							req->getParameter(config::html::variable_name), 
							req->getParameter(config::html::variable_mutable) == "on"
						);
					}
					catch (const Interpreter::Exception & exception)
					{ add_error(data, "Unable to add variable (" + exception.what() + ")"); }
				}

				// Variable parameter must have a value
				else
					add_error(data, "A variable must have a type and a name");
			}

			// Interpreter must have a session
			else
				add_error(data, "You must commpile a CHR space first");
		}

		// Remove a variable
		else if (!req->getParameter(config::html::remove_variable).empty())
		{
			try { _interpreter.remove_variable(req->getParameter(config::html::remove_variable)); }
			catch (const Interpreter::Exception & exception)
			{ add_error(data, "Unable to remove variable (" + exception.what() + ")"); }
		}

		// Clear variables
		else if (!req->getParameter(config::html::clear_variables).empty())
		{
			try { _interpreter.clear_variables(); }
			catch (const Interpreter::Exception & exception)
			{ add_error(data, "Unable to clear variables (" + exception.what() + ")"); }
		}
	}

	// Upload a session
	else if (req->getPath() == "/upload_session")
	{
		drogon::MultiPartParser file_upload;

		// Invalid file upload
		if (file_upload.parse(req) != 0 || file_upload.getFiles().size() == 0)
			add_error(data, "Invalid file upload");

		else
		{
			// Parse and update session
			Json::CharReaderBuilder json_char_reader;
			std::istringstream json_session_stream(std::string {file_upload.getFiles()[0].fileContent()});
			Json::Value json_session;
			if (Json::parseFromStream(json_char_reader, json_session_stream, &json_session, nullptr))
			{
				// Start a new session based on given json
				try { _interpreter.new_session(json_session); }
				catch (const Interpreter::Exception & exception)
				{ add_error(data, "Cannot upload session (" + exception.what() + ")"); }

				// Update CHR editor
				req->session()->erase(config::html::chr_code);
				req->session()->insert(config::html::chr_code, _interpreter.space());
			}
 
			else
				add_error(data, "Uploaded session could not be parsed");
		}

		// Redirect to index
		callback(drogon::HttpResponse::newRedirectionResponse("/"));
	}
	
	// Insert examples
	fs::path path;
	std::string file_name;
	std::vector<std::string> chr_examples;
	for (fs::directory_entry directory: fs::directory_iterator(config::path::chr_examples))
	{
		path = directory.path();
		chr_examples.push_back(path.filename());
	}
	data[config::html::chr_examples] = chr_examples;

	// Insert constraint store if session is started
	if (_interpreter.has_session())
		try { data[config::html::constraint_store] = _interpreter.constraint_store(); }
		catch (const Interpreter::Exception & exception)
		{ add_error(data, "Cannot get constraint store (" + exception.what() + ")"); }

	// Insert variables
	try { data[config::html::variables] = _interpreter.variables_values(); }
	catch (const Interpreter::Exception & exception)
	{ add_error(data, "Cannot get variables (" + exception.what() + ")"); }

	// Send CHR code from session
	data[config::html::chr_code] = req->session()->get<std::string>(config::html::chr_code);

	// Default behavior is to return the view with data
	if (resp == nullptr)
		resp = drogon::HttpResponse::newHttpViewResponse("index_view", data);

	callback(resp);
}

void Index::add_error(drogon::HttpViewData & data, const std::string & error)
{
	std::vector<std::string> errors = data.get<std::vector<std::string>>(config::html::error_id);
	errors.push_back(error);
	data[config::html::error_id] = errors;
}