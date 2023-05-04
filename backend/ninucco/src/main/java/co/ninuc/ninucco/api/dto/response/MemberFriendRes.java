package co.ninuc.ninucco.api.dto.response;


import co.ninuc.ninucco.api.dto.Res;
import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@AllArgsConstructor
@Builder
public class MemberFriendRes implements Res {
    Boolean isExist;
    @JsonInclude(JsonInclude.Include.NON_DEFAULT)
    String memberNickname;
    @JsonInclude(JsonInclude.Include.NON_DEFAULT)
    String friendNickname;
}
