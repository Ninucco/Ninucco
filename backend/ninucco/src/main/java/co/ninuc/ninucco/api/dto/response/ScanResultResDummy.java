package co.ninuc.ninucco.api.dto.response;

import co.ninuc.ninucco.api.dto.Similarity;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

import java.util.List;

@Getter
@AllArgsConstructor
@Builder
public class ScanResultResDummy {
    String imgUrl;
    String resultTitle;
    String resultDescription;
    List<Similarity> resultPercentages;
}