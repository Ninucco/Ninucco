package co.ninuc.ninucco.api.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@AllArgsConstructor
@Builder
public class SimilarityRankingRes {
    String memberId;
    String profileImage;
    String nickname;
    String similarity;
    Double rate;
}
