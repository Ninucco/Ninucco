package co.ninuc.ninucco.common.util;

import co.ninuc.ninucco.api.dto.ErrorRes;
import co.ninuc.ninucco.api.dto.interservice.PromptToImgReq;
import co.ninuc.ninucco.common.exception.CustomException;
import lombok.extern.slf4j.Slf4j;
import okhttp3.Headers;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.Optional;

@Component
@Slf4j
public class StabilityAIService extends InterServiceCommunicationProvider{
    private final Headers headers;

    public StabilityAIService(@Value("${ai.stability.key}") String stabilityAIKey) {
        log.info("===> stabilityAiKey : {}", stabilityAIKey);
        this.headers = Headers.of(
                "Content-Type","application/json",
                "Accept","application/json",
                "Authorization", stabilityAIKey
        );
    }

    public JSONObject getJsonObject(String prompt){
        log.info("===> stabilityAiKey : {}", headers.get("Authorization"));
        Optional<JSONObject> res = postRequestToUrlGetJsonObject("https://api.stability.ai/v1/generation/stable-diffusion-v1-5/text-to-image",
                headers,
                new PromptToImgReq(prompt));
        if(res.isEmpty()) throw new CustomException(ErrorRes.INTERNAL_SERVER_ERROR);
        else return res.get();
    }
    public void getResult(String prompt){
        //log.info(this.getJsonObject(prompt).toString());
        JSONArray picArray = (JSONArray) this.getJsonObject(prompt).get("artifacts");
        JSONObject fstPic = (JSONObject)picArray.get(0);
        String fstPicBase64 = (String)fstPic.get("base64");
        Long seed = (Long) fstPic.get("seed");
        try{
            FileConversionUtil.base64ToImg(seed.toString(), fstPicBase64);
        }catch (IOException e){
            throw new CustomException(ErrorRes.INTERNAL_SERVER_ERROR);
        }
    }

}
