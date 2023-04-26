package co.ninuc.ninucco.api.dto.request;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class BattleCreateReq {
    String title;
    String applicantId;
    String opponentId;
    String applicantUrl;
    String opponentUrl;
}
