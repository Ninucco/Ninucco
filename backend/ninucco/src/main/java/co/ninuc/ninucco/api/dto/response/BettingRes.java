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

    Boolean validate;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    BetSide betSide;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    Long betMoney;
}
