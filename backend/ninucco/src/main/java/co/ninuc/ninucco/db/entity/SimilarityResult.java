package co.ninuc.ninucco.db.entity;

import co.ninuc.ninucco.api.dto.Similarity;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

import java.util.List;
@Getter
@AllArgsConstructor
@Builder
public class SimilarityResult {
        String memberId;
        String modelType;
        String imgUrl;
        String resultTitle;
        String resultDescription;
        List<Similarity> resultList;
}
