package co.ninuc.ninucco.db.entity;

import co.ninuc.ninucco.api.dto.Similarity;
import lombok.Getter;
import lombok.Setter;

import java.util.List;
@Getter
@Setter
public class SimilarityResult {
        String userId;
        String modelType;
        String imgUrl;
        String resultTitle;
        String resultDescription;
        List<Similarity> resultList;
}
