package co.ninuc.ninucco.db.entity;

import co.ninuc.ninucco.db.entity.type.BattleResult;
import co.ninuc.ninucco.db.entity.type.BattleStatus;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "battle")
@Getter
@NoArgsConstructor
@EntityListeners(AuditingEntityListener.class)
public class Battle extends BaseEntity {
    @Column(name = "title", nullable = false, length = 20)
    String title;
    @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    @JoinColumn(referencedColumnName = "id", name="applicant_id")
    Member applicant;
    @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    @JoinColumn(referencedColumnName = "id", name="opponent_id")
    Member opponent;

    @Column(name="applicant_nickname", nullable = false)
    String applicantNickname;
    @Column(name="opponent_nickname", nullable = false)
    String opponentNickname;

    @Column(name="applicant_url", nullable = false)
    String applicantUrl;
    @Column(name="opponent_url", nullable = false)
    String opponentUrl;
    @Column(name="applicant_odds", nullable = false)
    Double applicantOdds;
    @Column(name="opponent_odds", nullable = false)
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
        this.status=BattleStatus.PROCEEDING;
        this.result=BattleResult.PROCEEDING;
    }
}