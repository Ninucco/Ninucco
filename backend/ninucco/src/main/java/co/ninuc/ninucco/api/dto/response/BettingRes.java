package co.ninuc.ninucco.api.dto.response;

import co.ninuc.ninucco.api.dto.Res;
import co.ninuc.ninucco.db.entity.type.BetSide;
import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@AllArgsConstructor
@Builder
public class BettingRes implements Res {

    Boolean isExist;
    @JsonInclude(JsonInclude.Include.NON_DEFAULT)
    BetSide betSide;
    @JsonInclude(JsonInclude.Include.NON_DEFAULT)
    Long betMoney;
}
