package co.ninuc.ninucco.api.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

import java.time.LocalDateTime;
@Getter
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
