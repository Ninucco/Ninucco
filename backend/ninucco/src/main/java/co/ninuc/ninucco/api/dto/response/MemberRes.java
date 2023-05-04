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
    Boolean isExist;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    String id;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    String nickname;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    String url;

    int winCount;

    int loseCount;

    long point;

    int elo;
}
