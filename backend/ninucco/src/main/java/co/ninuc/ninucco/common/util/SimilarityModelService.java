package co.ninuc.ninucco.common.util;

import co.ninuc.ninucco.api.dto.Similarity;
import lombok.extern.slf4j.Slf4j;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.core.io.Resource;
import org.springframework.http.*;
import org.springframework.stereotype.Component;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
import java.util.List;

@Component
@Slf4j
public class SimilarityModelService{
    private final String url;
    private final RestTemplate restTemplate;
    public SimilarityModelService(@Value("${ai.model.url}") String modelUrl, RestTemplateBuilder restTemplateBuilder) {
        this.restTemplate = restTemplateBuilder
                .defaultHeader("Content-Type", MediaType.MULTIPART_FORM_DATA_VALUE)
                .defaultHeader("Accept", MediaType.APPLICATION_JSON_VALUE)
                .build();
        this.url = modelUrl;
    }

    public JSONObject getJsonObject(Resource img, String modelType){
        MultiValueMap<String, Object> reqParams = new LinkedMultiValueMap<>();
        reqParams.add("img", img);
        reqParams.add("modelName", modelType);
        HttpEntity<MultiValueMap<String, Object>> requestEntity = new HttpEntity<>(reqParams);

        String response =  restTemplate.postForObject(url, requestEntity, String.class);
        return new JSONObject(response);
    }
    public List<Similarity> getList(Resource img, String modelType){
        JSONArray jsonArray = (JSONArray) this.getJsonObject(img, modelType).get("result_list");
        List<Similarity> resultList = new ArrayList<>();
        for(Object o: jsonArray){
            JSONObject jsonObj = (JSONObject) o;
            resultList.add(Similarity.builder()
                    .keyword((String)jsonObj.get("key"))
                    .value(Double.parseDouble(jsonObj.get("value").toString()))
                    .build());
        }
        return resultList;
    }
}