package co.ninuc.ninucco.api.dto.request;

import co.ninuc.ninucco.db.entity.type.BetSide;
import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * A DTO for the {@link co.ninuc.ninucco.db.entity.Betting} entity
 */
@AllArgsConstructor
@Getter
public class BettingCreateReq {
    private final Long battleId;
    private final String memberId;
    private final BetSide betSide;
    private final Long betMoney;
}