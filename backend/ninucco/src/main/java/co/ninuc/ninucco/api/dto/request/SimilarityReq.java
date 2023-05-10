package co.ninuc.ninucco.api.dto.request;

import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

@Getter
@NoArgsConstructor
public class SimilarityReq {
    String modelType;
    MultipartFile img;
}
