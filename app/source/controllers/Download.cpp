#include"Download.hh"

void Download::asyncHandleHttpRequest
	(
        const drogon::HttpRequestPtr &req,
        std::function<void(const drogon::HttpResponsePtr &)> &&callback
	)
{
    drogon::MultiPartParser fileUpload;
            if (fileUpload.parse(req) != 0 || fileUpload.getFiles().size() != 1)
            {
                auto resp = drogon::HttpResponse::newHttpResponse();
                resp->setBody("Must only be one file");
                resp->setStatusCode(drogon::k403Forbidden);
                callback(resp);
                return;
            }

            drogon::HttpFile file = fileUpload.getFiles()[0];
            auto md5 = file.getMd5();
            auto resp = drogon::HttpResponse::newHttpResponse();
            resp->setBody(
                "The server has calculated the file's MD5 hash to be " + md5);
            file.setFileName(req->session()->sessionId());
            file.save();

            LOG_INFO << "The uploaded file has been saved to the ./uploads "
                        "directory";
            callback(resp);
}