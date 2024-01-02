#pragma once

#include <drogon/HttpSimpleController.h>
#include <drogon/HttpResponse.h>

#include "../interpreter/interpreter.hh"

class Index: 
	public drogon::HttpSimpleController<Index>
{
	public:

		PATH_LIST_BEGIN
			PATH_ADD("/", drogon::Get, drogon::Post);
			PATH_ADD("/upload_session", drogon::Get, drogon::Post);
		PATH_LIST_END

		void asyncHandleHttpRequest(const drogon::HttpRequestPtr & req, std::function<void(const drogon::HttpResponsePtr &)> && callback) override;

	private:

		void add_error(drogon::HttpViewData & data, const std::string & error);

		Interpreter _interpreter;
};