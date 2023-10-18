#include <drogon/HttpSimpleController.h>
#include <drogon/HttpResponse.h>

class Index: 
	public drogon::HttpSimpleController<Index>
{
  public:

    PATH_LIST_BEGIN
    PATH_ADD("/", drogon::Get);
    PATH_LIST_END

    void asyncHandleHttpRequest
	(
        const drogon::HttpRequestPtr &req,
        std::function<void(const drogon::HttpResponsePtr &)> &&callback
	) override
    {
        drogon::HttpViewData data;
        data["name"] = req->getParameter("name");
        auto resp = drogon::HttpResponse::newHttpViewResponse("index_view", data);

        callback(resp);
    }
};