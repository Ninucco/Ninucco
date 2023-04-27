package co.ninuc.ninucco.common.util;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import okhttp3.*;
import org.json.JSONObject;

import java.io.IOException;
import java.util.Optional;

@Slf4j
public class InterServiceCommunicationProvider {
    private final OkHttpClient client = new OkHttpClient();
    private final ObjectMapper mapper = new ObjectMapper();
    private final MediaType JSON = MediaType.get("application/json; charset=utf-8");
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

    public Optional<String> postRequestToUrlGetString(String url, Object o) throws JsonProcessingException {
        RequestBody body = RequestBody.create(
                mapper.writeValueAsString(o),
                JSON
        );
        Request request = new Request.Builder()
                .url(url)
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
                return Optional.empty();
            }
        }catch (IOException ex){
            throw new RuntimeException(ex);
        }
    }
}
