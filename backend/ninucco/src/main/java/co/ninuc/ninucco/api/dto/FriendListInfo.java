package co.ninuc.ninucco.api.dto;

import co.ninuc.ninucco.db.entity.type.MemberFriendStatus;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@AllArgsConstructor
@Builder
public class FriendListInfo {
    String profileImage;
    String nickname;
    MemberFriendStatus status;
}
