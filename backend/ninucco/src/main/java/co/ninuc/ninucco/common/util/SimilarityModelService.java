package co.ninuc.ninucco.common.util;

import co.ninuc.ninucco.api.dto.Similarity;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.http.*;
import org.springframework.http.client.MultipartBodyBuilder;
import org.springframework.stereotype.Component;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.client.WebClient;
import java.util.List;

@Component
@Slf4j
public class SimilarityModelService{
    private final WebClient webClient;
    public SimilarityModelService(@Value("${ai.model.url}") String modelUrl) {
        this.webClient = WebClient.builder()
                .baseUrl(modelUrl)
                .defaultHeader(HttpHeaders.CONTENT_TYPE, MediaType.MULTIPART_FORM_DATA_VALUE)
                .defaultHeader(HttpHeaders.ACCEPT, MediaType.APPLICATION_JSON_VALUE)
                .build();
    }

    public List<Similarity> getList(Resource img, String modelType){
        MultipartBodyBuilder builder = new MultipartBodyBuilder();
        builder.part("img", img);
        builder.part("modelName", modelType);

        return webClient.post()
                .body(BodyInserters.fromMultipartData(builder.build()))
                .retrieve()
                .toEntityList(Similarity.class)
                //todo: exception handling추가
                .block().getBody();
    }
}