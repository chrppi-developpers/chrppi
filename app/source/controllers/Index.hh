#pragma once
#include <drogon/HttpSimpleController.h>
#include <drogon/HttpResponse.h>

class Index: 
	public drogon::HttpSimpleController<Index>
{
  public:

    PATH_LIST_BEGIN
    PATH_ADD("/", drogon::Get,drogon::Post);
    PATH_LIST_END

  void asyncHandleHttpRequest
	(
        const drogon::HttpRequestPtr &req,
        std::function<void(const drogon::HttpResponsePtr &)> &&callback
	) override;

  private:
  void traitement_Get_Post(drogon::HttpViewData &data
                          ,const drogon::HttpRequestPtr &req
                          ,drogon::HttpResponsePtr & resp);
  void detection_exemples(const drogon::HttpRequestPtr &req);
  void chargement_exemples(const drogon::HttpRequestPtr &req,std::string  const&filename);
  void Session_to_data(const drogon::HttpRequestPtr &req,drogon::HttpViewData &data);
  void ajoute_une_erreur(drogon::HttpViewData &data,std::string error);
};