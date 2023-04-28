package co.ninuc.ninucco.api.dto.request;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class BattleCreateReq {
    String title;
    String applicantId;
    String opponentId;
    String applicantUrl;
    String opponentUrl;
}
