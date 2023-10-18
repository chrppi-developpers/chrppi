#include"Index.hh"

void Index::asyncHandleHttpRequest
(
    const drogon::HttpRequestPtr &req,
    std::function<void(const drogon::HttpResponsePtr &)> &&callback
) 
{
    drogon::HttpViewData data;
    data["name"] = req->getParameter("name");
    auto resp = drogon::HttpResponse::newHttpViewResponse("index_view", data);
    callback(resp);
}
