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
    Boolean validate;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    String memberNickname;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    String friendNickname;
}
