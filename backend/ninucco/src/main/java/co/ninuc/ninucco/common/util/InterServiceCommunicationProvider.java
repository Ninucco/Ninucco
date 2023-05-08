package co.ninuc.ninucco.common.util;

import lombok.extern.slf4j.Slf4j;
import okhttp3.*;
import org.json.JSONObject;

import java.io.IOException;
import java.util.Optional;
import java.util.concurrent.TimeUnit;

@Slf4j
public class InterServiceCommunicationProvider {
    private OkHttpClient client;
    public InterServiceCommunicationProvider(){
        client = new OkHttpClient.Builder()
                .connectTimeout(Integer.MAX_VALUE, TimeUnit.MILLISECONDS)
                .build();
    }
    public Optional<String> getRequestToUrlGetString(String url){
        Request request = new Request.Builder()
                .url(url)
                .build();
        try(Response response = client.newCall(request).execute()){
            if(response.isSuccessful()){
                String respBody = response.body().string();
                //log.info(respBody);
                return Optional.of(respBody);
            }
            else{
                log.error("InterServiceCommunicationProvider returned "+response.code()+" by "+url);
                return Optional.empty();
            }
        }catch (IOException ex){
            throw new RuntimeException(ex);
        }
    }
    public Optional<JSONObject> getRequestToUrlGetJsonObject(String url){
        Optional<String> respBody = getRequestToUrlGetString(url);
        return respBody.map(JSONObject::new);
    }
    //request body->string
    public Optional<String> postRequestSendRequestbodyGetString(String url, Headers headers, RequestBody requestBody){
        Request request = new Request.Builder()
                .url(url)
                .headers(headers)
                .post(requestBody)
                .build();
        try(Response response = client.newCall(request).execute()){
            if(response.isSuccessful()){
                String respBody = response.body().string();
                //log.info(respBody);
                return Optional.of(respBody);
            }
            else{
                log.error("InterServiceCommunicationProvider returned "+response.code()+" by "+url);
                log.error(response.body().string());
                return Optional.empty();
            }
        }catch (IOException ex){
            throw new RuntimeException(ex);
        }
    }
    //request body->json
    public Optional<JSONObject> postRequestSendRequestbodyGetJsonObject(String url, Headers headers, RequestBody requestBody){
        Optional<String> respBody = postRequestSendRequestbodyGetString(url, headers, requestBody);
        return respBody.map(JSONObject::new);
    }
    //json->string
    public Optional<String> postRequestSendJsonGetString(String url, Headers headers, Object o){
        RequestBody body = RequestBody.create(new JSONObject(o).toString().getBytes());
        return postRequestSendRequestbodyGetString(url, headers,body);
    }
    public Optional<JSONObject> postRequestSendJsonGetJsonObject(String url, Headers headers, Object o){
        Optional<String> respBody = postRequestSendJsonGetString(url, headers, o);
        return respBody.map(JSONObject::new);
    }
}
