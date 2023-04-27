package co.ninuc.ninucco.api.dto.response;

import lombok.Builder;
import lombok.Getter;

@Getter
public class MemberFriendListRes {

    String profileImage;

    String nickname;

    @Builder
    public MemberFriendListRes(String profileImage, String nickname) {
        this.profileImage = profileImage;
        this.nickname = nickname;
    }
}
