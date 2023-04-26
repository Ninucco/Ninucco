package co.ninuc.ninucco.api.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;

import java.time.LocalDateTime;

@AllArgsConstructor
@Builder
public class BattleRes {
    Long battleId;
    String applicantName;
    String opponentName;
    String title;
    String applicantUrl;
    String opponentUrl;
    Long currentVotes;
    Double applicantOdds;
    Double opponentOdds;
    LocalDateTime finishTime;
}
