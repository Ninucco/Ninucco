package co.ninuc.ninucco.api.dto.request;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class MemberFriendCreateReq {
    String myId;

    String friendId;
}
