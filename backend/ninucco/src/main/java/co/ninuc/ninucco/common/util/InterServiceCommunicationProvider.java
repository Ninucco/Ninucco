package co.ninuc.ninucco.common.util;

import lombok.extern.slf4j.Slf4j;
import okhttp3.*;
import org.json.JSONObject;

import java.io.IOException;
import java.util.Optional;

@Slf4j
public class InterServiceCommunicationProvider {
    private final OkHttpClient client = new OkHttpClient();
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

    public Optional<String> postRequestToUrlGetString(String url, Headers headers, Object o){
        RequestBody body = RequestBody.create(new JSONObject(o).toString().getBytes());
        Request request = new Request.Builder()
                .url(url)
                .headers(headers)
                .post(body)
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
    public Optional<JSONObject> postRequestToUrlGetJsonObject(String url, Headers headers, Object o){
        Optional<String> respBody = postRequestToUrlGetString(url, headers, o);
        return respBody.map(JSONObject::new);
    }
}
