#pragma once

#include <map>

#include <drogon/HttpSimpleController.h>
#include <drogon/HttpResponse.h>

#include "../config.hh"
#include "../interpreter/interpreter.hh"

// Only controller for chrppi that serve a single view
// First the client gets the HTML and then it gets a JSON responses that update the page with AJAX
class Index:
	public drogon::HttpSimpleController<Index>
{
	public:

		PATH_LIST_BEGIN
			PATH_ADD(config::url::root, drogon::Get, drogon::Post);
			PATH_ADD(config::url::upload_session, drogon::Post);
		PATH_LIST_END

		void asyncHandleHttpRequest(const drogon::HttpRequestPtr & req, std::function<void(const drogon::HttpResponsePtr &)> && callback) override;

	private:

		std::map<std::thread::id, Interpreter> _interpreter_pool;
};
