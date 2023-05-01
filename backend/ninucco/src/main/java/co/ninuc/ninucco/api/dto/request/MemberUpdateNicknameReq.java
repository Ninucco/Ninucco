package co.ninuc.ninucco.api.dto.request;

import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Getter
public class MemberUpdateNicknameReq{
    String id;
    String nickname;
}
