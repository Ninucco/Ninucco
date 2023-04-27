package co.ninuc.ninucco.common.util;

import co.ninuc.ninucco.api.dto.ErrorRes;
import co.ninuc.ninucco.api.dto.SimilarityResult;
import co.ninuc.ninucco.common.exception.CustomException;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Component
public class LambdaService extends InterServiceCommunicationProvider{
    public JSONObject getJsonObject(){
        Optional<JSONObject> jsonObj =  getRequestToUrlGetJsonObject("https://od7d3usr4vpot4dvlthnjwz2640iboek.lambda-url.ap-northeast-2.on.aws");
        if(jsonObj.isEmpty()) throw new CustomException(ErrorRes.INTERNAL_SERVER_ERROR);
        else return jsonObj.get();
    }
    public List<SimilarityResult> getList(){
        JSONArray jsonArray = (JSONArray) this.getJsonObject().get("resultList");

        List<SimilarityResult> resultList = new ArrayList<>();
        for(Object o: jsonArray){
            JSONObject jsonObj = (JSONObject) o;
            resultList.add(SimilarityResult.builder()
                    .keyword((String)jsonObj.get("keyword"))
                    .value(Double.parseDouble(jsonObj.get("value").toString()))
                    .build());
        }
        return resultList;
    }
}
