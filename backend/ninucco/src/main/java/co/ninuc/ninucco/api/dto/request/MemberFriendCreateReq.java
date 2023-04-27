package co.ninuc.ninucco.api.dto.request;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@AllArgsConstructor
@Builder
public class MemberFriendCreateReq {

    String friendId;
}
