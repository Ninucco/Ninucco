package co.ninuc.ninucco.api.dto.response;

import co.ninuc.ninucco.api.dto.Res;
import co.ninuc.ninucco.api.dto.SimilarityResult;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

import java.util.List;

@Getter
@AllArgsConstructor
@Builder
public class SimilarityResultRes implements Res {
    String imgUrl;
    String resultTitle;
    String resultDescription;
    List<SimilarityResult> resultPercentages;
}
