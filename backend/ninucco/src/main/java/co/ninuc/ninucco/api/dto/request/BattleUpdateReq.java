package co.ninuc.ninucco.api.dto.request;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class BattleUpdateReq {
    Long battleId;
    String opponentUrl;
}
