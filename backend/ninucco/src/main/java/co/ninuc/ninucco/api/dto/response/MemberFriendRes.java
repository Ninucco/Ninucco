package co.ninuc.ninucco.api.dto.response;


import co.ninuc.ninucco.api.dto.Res;
import lombok.Builder;
import lombok.Getter;

@Getter
public class MemberFriendRes implements Res {

    String memberNickname;
    String friendNickname;

    @Builder
    public MemberFriendRes(String memberNickname, String friendNickname) {
        this.memberNickname = memberNickname;
        this.friendNickname = friendNickname;
    }
}
