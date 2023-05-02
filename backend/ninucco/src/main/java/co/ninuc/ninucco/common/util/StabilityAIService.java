package co.ninuc.ninucco.common.util;

import co.ninuc.ninucco.api.dto.ErrorRes;
import co.ninuc.ninucco.api.dto.interservice.ImgToImgReq;
import co.ninuc.ninucco.api.dto.interservice.PromptToImgReq;
import co.ninuc.ninucco.common.exception.CustomException;
import lombok.extern.slf4j.Slf4j;
import okhttp3.Headers;
import org.apache.commons.codec.binary.Base64;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import java.util.Optional;

@Component
@Slf4j
public class StabilityAIService extends InterServiceCommunicationProvider{
    private final Headers promptToImgHeaders;
    private final Headers imgToImgHeaders;
    public StabilityAIService(@Value("${ai.stability.key}") String stabilityAIKey) {
        this.promptToImgHeaders = Headers.of(
                "Content-Type","application/json",
                "Accept","application/json",
                "Authorization", stabilityAIKey
        );
        this.imgToImgHeaders = Headers.of(
                "Content-Type","application/json",
                "Accept","application/json",
                "Authorization", stabilityAIKey
        );
    }

    private JSONObject getJsonObjectPromptToImg(String prompt){
        Optional<JSONObject> res = postRequestToUrlGetJsonObject("https://api.stability.ai/v1/generation/stable-diffusion-v1-5/text-to-image",
                promptToImgHeaders,
                new PromptToImgReq(prompt));
        if(res.isEmpty()) throw new CustomException(ErrorRes.INTERNAL_SERVER_ERROR_FROM_STABILITY_AI);
        else return res.get();
    }
    public byte[] getByteArrayPromptToImg(String prompt){
        JSONArray picArray = (JSONArray) this.getJsonObjectPromptToImg(prompt).get("artifacts");
        JSONObject fstPic = (JSONObject)picArray.get(0);
        String fstPicBase64 = (String)fstPic.get("base64");
        return Base64.decodeBase64(fstPicBase64);
    }
    private JSONObject getJsonObjectImgToImg(String picBase64, String prompt){
        Optional<JSONObject> res = postRequestToUrlGetJsonObject("https://api.stability.ai/v1/generation/stable-diffusion-v1-5/img-to-image",
                promptToImgHeaders,
                new ImgToImgReq(picBase64, prompt));
        if(res.isEmpty()) throw new CustomException(ErrorRes.INTERNAL_SERVER_ERROR_FROM_STABILITY_AI);
        else return res.get();
    }
    public byte[] getByteArrayImgToImg(String picBase64, String prompt){
        JSONArray picArray = (JSONArray) this.getJsonObjectImgToImg(picBase64,prompt).get("artifacts");
        JSONObject fstPic = (JSONObject)picArray.get(0);
        String fstPicBase64 = (String)fstPic.get("base64");
        return Base64.decodeBase64(fstPicBase64);
    }
}
