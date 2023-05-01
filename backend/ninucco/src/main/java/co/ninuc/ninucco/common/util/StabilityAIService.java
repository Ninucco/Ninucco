package co.ninuc.ninucco.common.util;

import co.ninuc.ninucco.api.dto.ErrorRes;
import co.ninuc.ninucco.api.dto.interservice.PromptToImgReq;
import co.ninuc.ninucco.common.exception.CustomException;
import lombok.extern.slf4j.Slf4j;
import okhttp3.Headers;
import org.apache.tomcat.util.codec.binary.Base64;
import org.json.JSONArray;
import org.json.JSONObject;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Optional;

@Slf4j
public class StabilityAIService extends InterServiceCommunicationProvider{

    private static String stabilityAIKey;
    private Headers headers= Headers.of(
            "Content-Type","application/json",
            "Accept","application/json",
            "Authorization",stabilityAIKey
    );

    public JSONObject getJsonObject(String prompt){
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
        byte[] fstPicByteArray = Base64.decodeBase64(fstPicBase64);
        try(OutputStream stream = new FileOutputStream("C:\\SSAFY\\out\\"+seed+".png")){
            stream.write(fstPicByteArray);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    public static void main(String[] args){
        StabilityAIService sac = new StabilityAIService();
        sac.getResult("Cute small cat sitting in a office typing code,unreal engine, cozy indoor lighting, artstation, detailed, digital painting,cinematic,character design by mark ryden and pixar and hayao miyazaki, unreal 5, daz, hyperrealistic, octane render");

    }
}
