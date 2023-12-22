#include<syslog.h>
#include<filesystem>
#include <vector>
#include <fstream>

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
		// Add a constraint
		if (!req->getParameter(config::html::add_constraint).empty())
		{
			_interpreter.add_constraint(req->getParameter(config::html::add_constraint_value));
		}

		// Clear constraint store
		if (!req->getParameter(config::html::clear_constraint_store).empty())
		{
		//	_interpreter.clear_store();
		}

		// Load an example
		if (!req->getParameter(config::html::select_example).empty())
		{
			std::ifstream file(config::path::chr_examples + "/" + req->getParameter(config::html::select_example));
			if (file.is_open())
			{
				std::stringstream file_stream;
				file_stream << file.rdbuf();

				// Update HTML
				req->session()->erase(config::html::chr_code);
				req->session()->insert(config::html::chr_code, file_stream.str());

				// Define space
				try { _interpreter.define_space(config::path::chr_examples + "/" + req->getParameter(config::html::select_example)); }
				catch (const Interpreter::Exception & exception)
				{
					add_error(data, "Cannot load example (" + exception.what() + ")");
				}
			}

			else
				add_error(data, "Cannot load example");
		}

		// Track a variable
		if (!req->getParameter(config::html::track_variable).empty())
		{
			if (_interpreter.has_session())
			{
				if (!req->getParameter(config::html::track_variable_name).empty() && !req->getParameter(config::html::track_variable_type).empty())
				{
					try
					{
						_interpreter.add_variable
						(
							req->getParameter(config::html::track_variable_type), 
							req->getParameter(config::html::track_variable_name), 
							req->getParameter(config::html::track_variable_mutable) == "on"
						);
					}
					catch (const Interpreter::Exception & exception)
					{
						add_error(data, "Cannot track variable (" + exception.what() + ")");
					}
				}

				// Track variable parameter must have a value
				else
					add_error(data, "A tracked variable but  have a type and a name");
			}

			// Interpreter must have a session
			else
				add_error(data, "You must commpile a CHR space first");
		}

		// Clear tracked variables
		if (!req->getParameter(config::html::clear_tracked_variables).empty())
		{

		}

		// Download a session
		if (!req->getParameter(config::html::download_session).empty())
		{
			// Set the content type and body of the response
			Json::StreamWriterBuilder json_stream_writer;
			resp = drogon::HttpResponse::newHttpResponse(drogon::HttpStatusCode::k200OK, drogon::ContentType::CT_APPLICATION_JSON);
			resp->setBody(Json::writeString(json_stream_writer, _interpreter.json_session()));

			// Set the content disposition header to trigger a file download
			resp->addHeader("Content-Disposition", "attachment; filename=session.json");
		}

		// Download a session
		if (!req->getParameter(config::html::download_session).empty())
		{
			// Set the content type and body of the response
			Json::StreamWriterBuilder json_stream_writer;
			resp = drogon::HttpResponse::newHttpResponse(drogon::HttpStatusCode::k200OK, drogon::ContentType::CT_APPLICATION_JSON);
			resp->setBody(Json::writeString(json_stream_writer, _interpreter.json_session()));

			// Set the content disposition header to trigger a file download
			resp->addHeader("Content-Disposition", "attachment; filename=session.json");
		}
	}

	// Upload a session
	else if (req->getPath() == "/upload_session")
	{
		drogon::MultiPartParser file_upload;

		// Invalid file upload
		if (file_upload.parse(req) != 0 || file_upload.getFiles().size() == 0)
			throw std::runtime_error("Invalid file upload");

		// Parse and update session
		Json::CharReaderBuilder json_char_reader;
		std::istringstream json_session_stream(std::string {file_upload.getFiles()[0].fileContent()});
		Json::Value json_session;
		if (Json::parseFromStream(json_char_reader, json_session_stream, &json_session, nullptr))
		{
			// Start a new session based on given json
			_interpreter.new_session(json_session);

			// Update CHR editor
			req->session()->erase(config::html::chr_code);
			req->session()->insert(config::html::chr_code, _interpreter.space());
		}

		else
			add_error(data, "Uploaded session could not be parsed");

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
		data[config::html::constraint_store] = _interpreter.constraint_store();

	// Insert tracked variables
	data[config::html::tracked_variables] = _interpreter.variables_values();

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