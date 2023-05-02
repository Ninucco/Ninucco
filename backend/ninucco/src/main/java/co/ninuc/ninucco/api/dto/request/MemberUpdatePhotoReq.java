package co.ninuc.ninucco.api.dto.request;

import co.ninuc.ninucco.api.dto.Res;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class MemberUpdatePhotoReq{
    String id;
    String url;
}
