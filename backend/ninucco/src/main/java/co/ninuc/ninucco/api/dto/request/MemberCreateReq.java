package co.ninuc.ninucco.api.dto.request;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class MemberCreateReq {
    String id;

    String nickname;

    String url;
}
