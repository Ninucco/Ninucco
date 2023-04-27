package co.ninuc.ninucco.api.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@AllArgsConstructor
@Builder
public class SimilarityResult {
    String title;
    Double value;
}
