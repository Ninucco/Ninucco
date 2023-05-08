package co.ninuc.ninucco.api.dto.response;

import co.ninuc.ninucco.api.dto.Res;
import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@Builder
public class MemberRes implements Res {
    Boolean validate;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    String id;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    String nickname;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    String url;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    Integer winCount;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    Integer loseCount;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    Long point;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    Integer elo;
}
