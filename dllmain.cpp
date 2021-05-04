// dllmain.cpp : This dll send Webhooks to discord

#include "pch.h"

BOOL APIENTRY DllMain( HMODULE hModule,
                       DWORD  ul_reason_for_call,
                       LPVOID lpReserved
                     )
{
    switch (ul_reason_for_call)
    {
    case DLL_PROCESS_ATTACH:
    case DLL_THREAD_ATTACH:
    case DLL_THREAD_DETACH:
    case DLL_PROCESS_DETACH:
        break;
    }
    return TRUE;
}

#if __cplusplus
#define CURL_STATICLIB
#include <curl/curl.h>
#include <sstream>

using namespace std;

extern "C" {

    int string_size_1(const char *str)
    {
        int Size = 0;
        while (str[Size] != '\0') Size++;
        return Size;
    }

    __declspec(dllexport) int sendMessage(const char *url, const char *username, const char *message)
    {
        CURL* curl = curl_easy_init();
        if (curl)
        {
            struct curl_slist* headers = NULL;
            headers = curl_slist_append(headers, "Content-Type: application/x-www-form-urlencoded");

            curl_easy_setopt(curl, CURLOPT_HTTPHEADER, headers);
            curl_easy_setopt(curl, CURLOPT_URL, url);
            curl_easy_setopt(curl, CURLOPT_POST, 1L);

            ostringstream oss;

            oss << "content=";
            char* encoded = curl_easy_escape(curl, message, string_size_1(message));
            if (encoded)
            {
                oss << encoded;
                curl_free(encoded);
            }

            oss << "&username=";
            encoded = curl_easy_escape(curl, username, string_size_1(username));
            if (encoded)
            {
                oss << encoded;
                curl_free(encoded);
            }

            oss << "&avatar_url=";
            encoded = curl_easy_escape(curl, "", 0);
            if (encoded)
            {
                oss << encoded;
                curl_free(encoded);
            }

            string postdata = oss.str();
            curl_easy_setopt(curl, CURLOPT_POSTFIELDS, postdata.c_str());

            CURLcode res = curl_easy_perform(curl);

            curl_easy_cleanup(curl);
            return 1;
        }
        curl_easy_cleanup(curl);
        return 0;
    }

    __declspec(dllexport) int commandUsage(const char* url, const char* admin, const char* command, const char* objetive, const char* reason, const char* port)
    {
        CURL* curl = curl_easy_init();
        if (curl)
        {
            struct curl_slist* headers = NULL;
            headers = curl_slist_append(headers, "Content-Type: application/json");

            curl_easy_setopt(curl, CURLOPT_HTTPHEADER, headers);
            curl_easy_setopt(curl, CURLOPT_URL, url);
            curl_easy_setopt(curl, CURLOPT_POST, 1L);

            string adminS = admin;
            string cmdS = command;
            string objS = objetive;
            string reasonS = reason;
            string portS = port;
            
            string str = R"({ "username": "Logger", "content": "", "embeds": [{ "author": { "name": "Use by: )" + adminS + R"(", "url": "", "icon_url": "" }, "title": "Command Usage", "fields": [{ "name": "Command", "value": ")" + cmdS + R"(", "inline": false }, { "name": "Objetive", "value": ")" + objS + R"(", "inline": false }, { "name": "Reason", "value": ")" + reasonS + R"(", "inline": false }, { "name": "Port", "value": ")" + portS + R"(", "inline": false } ] }] })";

            curl_easy_setopt(curl, CURLOPT_POSTFIELDS, str.c_str());

            CURLcode res = curl_easy_perform(curl);

            curl_easy_cleanup(curl);
            return 1;
        }
        curl_easy_cleanup(curl);
        return 0;
    }

    __declspec(dllexport) int commandReport(const char* url, const char* user, const char* message, const char* port)
    {
        CURL* curl = curl_easy_init();
        if (curl)
        {
            struct curl_slist* headers = NULL;
            headers = curl_slist_append(headers, "Content-Type: application/json");

            curl_easy_setopt(curl, CURLOPT_HTTPHEADER, headers);
            curl_easy_setopt(curl, CURLOPT_URL, url);
            curl_easy_setopt(curl, CURLOPT_POST, 1L);

            string userS = user;
            string messageS = message;
            string portS = port;

            string str = R"({ "username": "Report", "content": "", "embeds": [{ "author": { "name": "Report by: )" + userS + R"(" }, "title": "Report", "fields": [{ "name": "Message", "value": ")" + messageS + R"(", "inline": false }, { "name": "Port", "value": ")" + portS + R"(", "inline": false } ] }] })";

            curl_easy_setopt(curl, CURLOPT_POSTFIELDS, str.c_str());

            CURLcode res = curl_easy_perform(curl);

            curl_easy_cleanup(curl);
            return 1;
        }
        curl_easy_cleanup(curl);
        return 0;
    }
}
#endif