package co.ninuc.ninucco.common.util;

import co.ninuc.ninucco.api.dto.ErrorRes;
import co.ninuc.ninucco.api.dto.interservice.PromptToImgReq;
import co.ninuc.ninucco.common.exception.CustomException;
import lombok.extern.slf4j.Slf4j;
import okhttp3.Headers;
import okhttp3.MediaType;
import okhttp3.MultipartBody;
import okhttp3.RequestBody;
import org.apache.commons.codec.binary.Base64;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import java.util.Optional;

@Component
@Slf4j
public class StabilityAIService{
    @Value("{ai.stability.url}")
    String url;
    private final InterServiceCommunicationProvider isp;
//    private final Headers promptToImgHeaders;
    private final Headers imgToImgHeaders;
    public StabilityAIService(@Value("${ai.stability.key}") String stabilityAIKey) {
        this.isp = new InterServiceCommunicationProvider();
//        this.promptToImgHeaders = Headers.of(
//                "Content-Type","application/json",
//                "Accept","application/json",
//                "Authorization", stabilityAIKey
//        );
        this.imgToImgHeaders = Headers.of(
                "Content-Type","multipart/form-data",
                "Accept","application/json",
                "Authorization", stabilityAIKey
        );
    }

//    private JSONObject getJsonObjectPromptToImg(String prompt){
//        Optional<JSONObject> res = isp.postRequestSendJsonGetJsonObject("https://api.stability.ai/v1/generation/stable-diffusion-xl-beta-v2-2-2/image-to-image",
//                promptToImgHeaders,
//                new PromptToImgReq(prompt));
//        if(res.isEmpty()) throw new CustomException(ErrorRes.INTERNAL_SERVER_ERROR_FROM_STABILITY_AI);
//        else return res.get();
//    }
//    public byte[] getByteArrayPromptToImg(String prompt){
//        JSONArray picArray = (JSONArray) this.getJsonObjectPromptToImg(prompt).get("artifacts");
//        JSONObject fstPic = (JSONObject)picArray.get(0);
//        String fstPicBase64 = (String)fstPic.get("base64");
//        return Base64.decodeBase64(fstPicBase64);
//    }
    private JSONObject getJsonObjectImgToImg(byte[] imgByteArray, String prompt){
        RequestBody requestBody = new MultipartBody.Builder()
                .addFormDataPart("init_image", "", RequestBody.create(imgByteArray, MediaType.parse("image/png")))
                .addFormDataPart("text_prompts[0][text]", prompt)
                .addFormDataPart("init_image_mode", "IMAGE_STRENGTH")
                .addFormDataPart("image_strength", "0.35")
                .addFormDataPart("style_preset", "low-poly")
//                .addFormDataPart("cfg_scale", "7")
                .addFormDataPart("clip_guidance_preset", "FAST_BLUE")
                .addFormDataPart("samples", "1")
                .addFormDataPart("steps", "30")
                .setType(MultipartBody.FORM)
            .build();
        log.info(requestBody.contentType().toString());

        Optional<JSONObject> res = isp.postRequestSendRequestbodyGetJsonObject(url,
                imgToImgHeaders,requestBody
                );
        if(res.isEmpty()) throw new CustomException(ErrorRes.INTERNAL_SERVER_ERROR_FROM_STABILITY_AI);
        else return res.get();
    }
    public byte[] getByteArrayImgToImg(byte[] imgByteArray, String prompt){
        JSONArray picArray = (JSONArray) this.getJsonObjectImgToImg(imgByteArray,prompt).get("artifacts");
        JSONObject fstPic = (JSONObject)picArray.get(0);
        String fstPicBase64 = (String)fstPic.get("base64");
        return Base64.decodeBase64(fstPicBase64);
    }

}
