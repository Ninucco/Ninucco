package co.ninuc.ninucco.api.dto.response;


import co.ninuc.ninucco.api.dto.Res;
import co.ninuc.ninucco.db.entity.type.MemberFriendStatus;
import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@AllArgsConstructor
@Builder
public class MemberFriendRes implements Res {
    @JsonInclude(JsonInclude.Include.NON_DEFAULT)
    String memberId;
    @JsonInclude(JsonInclude.Include.NON_DEFAULT)
    String memberNickname;
    @JsonInclude(JsonInclude.Include.NON_DEFAULT)
    String friendId;
    @JsonInclude(JsonInclude.Include.NON_DEFAULT)
    String friendNickname;
    MemberFriendStatus status;
}
