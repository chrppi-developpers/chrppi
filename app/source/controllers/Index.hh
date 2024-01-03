#pragma once

#include <map>

#include <drogon/HttpSimpleController.h>
#include <drogon/HttpResponse.h>

#include "../config.hh"
#include "../interpreter/interpreter.hh"

class Index: 
	public drogon::HttpSimpleController<Index>
{
	public:

		PATH_LIST_BEGIN
			PATH_ADD(config::url::root, drogon::Get, drogon::Post);
			PATH_ADD(config::url::upload_session, drogon::Get, drogon::Post);
		PATH_LIST_END

		void asyncHandleHttpRequest(const drogon::HttpRequestPtr & req, std::function<void(const drogon::HttpResponsePtr &)> && callback) override;

	private:

		void add_error(drogon::HttpViewData & data, const std::string & error);

		std::map<std::thread::id, Interpreter> _interpreter_pool;
};