package co.ninuc.ninucco.common.util;

import co.ninuc.ninucco.api.dto.ErrorRes;
import co.ninuc.ninucco.api.dto.interservice.PromptToImgReq;
import co.ninuc.ninucco.common.exception.CustomException;
import com.fasterxml.jackson.core.JsonProcessingException;
import lombok.extern.slf4j.Slf4j;
import org.json.JSONObject;

import java.io.IOException;
import java.util.Optional;
import java.util.Scanner;

@Slf4j
public class StabilityAIService extends InterServiceCommunicationProvider{
    public JSONObject getJsonObject(String prompt) throws IOException {
        Optional<JSONObject> res = postRequestToUrlGetJsonObject("https://api.stability.ai/v1/generation/stable-diffusion-v1-5/text-to-image",
                new PromptToImgReq(prompt));
        if(res.isEmpty()) throw new CustomException(ErrorRes.INTERNAL_SERVER_ERROR);
        else return res.get();
    }
    public String getString(String prompt) throws IOException {
        JSONObject res = this.getJsonObject(prompt);
        return res.getMapType().toString();
    }

    public static void main(String[] args){
        StabilityAIService sac = new StabilityAIService();
        log.info("start: ");
        Scanner sc = new Scanner(System.in);
        try {
            log.info(sac.getString(sc.nextLine()));
        }catch(JsonProcessingException e){
            e.printStackTrace();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
