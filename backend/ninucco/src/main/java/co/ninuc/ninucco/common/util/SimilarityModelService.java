package co.ninuc.ninucco.common.util;

import co.ninuc.ninucco.api.dto.ErrorRes;
import co.ninuc.ninucco.api.dto.SimilarityResult;
import co.ninuc.ninucco.common.exception.CustomException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import okhttp3.Headers;
import okhttp3.MediaType;
import okhttp3.MultipartBody;
import okhttp3.RequestBody;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Component
@RequiredArgsConstructor
@Slf4j
public class SimilarityModelService{
    private final InterServiceCommunicationProvider isp;
    private JSONObject getJsonObject(String modelType, byte[] imgByteArray){
        RequestBody requestBody = new MultipartBody.Builder()
                .addFormDataPart("modelName", modelType)
                .addFormDataPart("img", "tmp.png", RequestBody.create(imgByteArray, MediaType.parse("image/png")))
                .setType(MultipartBody.FORM)
                .build();
        Optional<JSONObject> res = isp.postRequestSendRequestbodyGetJsonObject("http://localhost:8000/predict",
                Headers.of(
                        "Content-Type","multipart/form-data",
                        "Accept","application/json"
                ),
                requestBody
                );
        if(res.isEmpty()) throw new CustomException(ErrorRes.INTERNAL_SERVER_ERROR_FROM_SIMILARITY_MODEL);
        else return res.get();
    }
    public List<SimilarityResult> getList(String modelType, byte[] imgByteArray){
        JSONArray jsonArray = (JSONArray) this.getJsonObject(modelType, imgByteArray).get("result_list");
        List<SimilarityResult> resultList = new ArrayList<>();
        for(Object o: jsonArray){
            JSONObject jsonObj = (JSONObject) o;
            resultList.add(SimilarityResult.builder()
                    .keyword((String)jsonObj.get("key"))
                    .value(Double.parseDouble(jsonObj.get("value").toString()))
                    .build());
        }
        return resultList;
    }
}
