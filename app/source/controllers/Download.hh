#pragma once
#include <drogon/HttpSimpleController.h>
#include <drogon/HttpResponse.h>

class Download: 
	public drogon::HttpSimpleController<Download>
{
  public:

    PATH_LIST_BEGIN
    PATH_ADD("/download_file",drogon::Post);
    PATH_LIST_END

  void asyncHandleHttpRequest
	(
        const drogon::HttpRequestPtr &req,
        std::function<void(const drogon::HttpResponsePtr &)> &&callback
	) override;

  private:
};