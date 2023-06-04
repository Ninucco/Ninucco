package co.ninuc.ninucco.api.dto.request;

import co.ninuc.ninucco.api.dto.Res;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

@Getter
@AllArgsConstructor
@Builder
public class MemberUpdatePhotoReq{
    String id;
    MultipartFile img;
}
