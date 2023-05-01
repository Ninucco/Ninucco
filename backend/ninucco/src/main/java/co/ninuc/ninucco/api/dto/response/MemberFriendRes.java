package co.ninuc.ninucco.api.dto.response;


import co.ninuc.ninucco.api.dto.Res;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@AllArgsConstructor
@Builder
public class MemberFriendRes implements Res {
    String memberNickname;
    String friendNickname;
}
