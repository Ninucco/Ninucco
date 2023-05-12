package co.ninuc.ninucco.api.dto.response;

import co.ninuc.ninucco.api.dto.Res;
import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

import java.time.LocalDateTime;
@Getter
@AllArgsConstructor
@Builder
public class BattleRes implements Res {
    //validate 안쓸거니까 지우기
    @JsonInclude(JsonInclude.Include.NON_DEFAULT)
    Long battleId;
    @JsonInclude(JsonInclude.Include.NON_DEFAULT)
    String applicantId;
    @JsonInclude(JsonInclude.Include.NON_DEFAULT)
    String opponentId;
    @JsonInclude(JsonInclude.Include.NON_DEFAULT)
    String applicantName;
    @JsonInclude(JsonInclude.Include.NON_DEFAULT)
    String opponentName;
    @JsonInclude(JsonInclude.Include.NON_DEFAULT)
    String title;
    @JsonInclude(JsonInclude.Include.NON_DEFAULT)
    String applicantUrl;
    @JsonInclude(JsonInclude.Include.NON_DEFAULT)
    String opponentUrl;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    Double applicantOdds;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    Double opponentOdds;
    @JsonInclude(JsonInclude.Include.NON_DEFAULT)
    LocalDateTime finishTime;
}
