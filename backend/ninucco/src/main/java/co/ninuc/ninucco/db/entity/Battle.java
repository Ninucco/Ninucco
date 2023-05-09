package co.ninuc.ninucco.db.entity;

import co.ninuc.ninucco.db.entity.type.BattleResult;
import co.ninuc.ninucco.db.entity.type.BattleStatus;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.ZoneId;

@Entity
@Table(name = "battle")
@Getter
@NoArgsConstructor
@EntityListeners(AuditingEntityListener.class)
public class Battle extends BaseEntity {
    @Column(name = "title", nullable = false, length = 20)
    String title;
    @ManyToOne(fetch = FetchType.EAGER)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(referencedColumnName = "id", name="applicant_id")
    Member applicant;
    @ManyToOne(fetch = FetchType.EAGER)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(referencedColumnName = "id", name="opponent_id")
    Member opponent;

    @Column(name="applicant_nickname", nullable = false)
    String applicantNickname;
    @Column(name="opponent_nickname", nullable = false)
    String opponentNickname;

    @Column(name="applicant_url", nullable = false)
    String applicantUrl;
    @Column(name="opponent_url")
    String opponentUrl;
    @Column(name="applicant_odds")
    Double applicantOdds;
    @Column(name="opponent_odds")
    Double opponentOdds;
    @Column(name="status", nullable = false)
    BattleStatus status;
    @Column(name="result", nullable = false)
    BattleResult result;
    @CreatedDate
    LocalDateTime createdAt;
    LocalDateTime finishAt;

    public void updateResult(BattleResult result){
        this.result=result;
    }
    public void updateStatusTerminated(){
        this.status=BattleStatus.TERMINATED;
    }
    public void updateBattle(String opponentUrl, Double applicantOdds, Double opponentOdds) {
        this.opponentUrl = opponentUrl;
        this.applicantOdds = applicantOdds;
        this.opponentOdds = opponentOdds;
        this.status = BattleStatus.PROCEEDING;
        this.result = BattleResult.PROCEEDING;
        this.finishAt = LocalDateTime.of(LocalDate.now(ZoneId.of("Asia/Seoul")), LocalTime.MIDNIGHT).plusDays(1);
    }
    @Builder
    public Battle(String title, Member applicant, Member opponent, String applicantNickname, String opponentNickname, String applicantUrl, String opponentUrl, Double applicantOdds, LocalDateTime finishAt, Double opponentOdds){
        this.title=title;
        this.applicant=applicant;
        this.opponent=opponent;
        this.applicantNickname=applicantNickname;
        this.opponentNickname=opponentNickname;
        this.applicantUrl=applicantUrl;
        this.opponentUrl=opponentUrl;
        this.applicantOdds=applicantOdds;
        this.opponentOdds=opponentOdds;
        this.finishAt=finishAt;
        this.status=BattleStatus.WAITING;
        this.result=BattleResult.WAITING;
    }
}