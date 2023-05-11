package co.ninuc.ninucco.api.dto.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.web.multipart.MultipartFile;

@Getter
@AllArgsConstructor
public class SimilarityReq {
    String memberId;
    String modelType;
    MultipartFile img;
}
