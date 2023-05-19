package co.ninuc.ninucco.api.dto.response;

import co.ninuc.ninucco.api.dto.Res;
import co.ninuc.ninucco.api.dto.Similarity;
import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

import java.util.List;

@Getter
@AllArgsConstructor
@Builder
@JsonInclude(JsonInclude.Include.NON_NULL)
public class SimilarityResultRes implements Res {
    String modelType;
    String imgUrl;
    String resultTitle;
    String resultDescription;
    List<Similarity> resultList;
}
