package co.ninuc.ninucco.api.dto.request;

import co.ninuc.ninucco.db.entity.type.BetSide;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class BettingCreateReq {
    Long battleId;
    String memberId;
    BetSide betSide;
    Long betMoney;
}