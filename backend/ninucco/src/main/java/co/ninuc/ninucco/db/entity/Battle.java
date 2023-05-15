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
import java.time.LocalDateTime;
import java.time.ZoneId;
@Entity
@Table(name = "battle")
@Getter
@NoArgsConstructor
@EntityListeners(AuditingEntityListener.class)
public class Battle extends BaseEntity {
    @Column(name = "title", nullable = false)
    String title;
    @ManyToOne(fetch = FetchType.EAGER)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(referencedColumnName = "id", name="applicant_id")
    Member applicant;
    @ManyToOne(fetch = FetchType.EAGER)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(referencedColumnName = "id", name="opponent_id")
    Member opponent;

    @Column(name="applicant_url", nullable = false)
    String applicantUrl;
    @Column(name="opponent_url")
    String opponentUrl;
    @Column(name="applicant_odds")
    Double applicantOdds;
    @Column(name="opponent_odds")
    Double opponentOdds;
    @Column(name="status", nullable = false)
    @Enumerated(EnumType.STRING)
    BattleStatus status;
    @Column(name="result", nullable = false)
    @Enumerated(EnumType.STRING)
    BattleResult result;
    @Column
    @CreatedDate
    LocalDateTime createdAt;
    @Column
    LocalDateTime updatedAt;
    @Column
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
        this.updatedAt = LocalDateTime.now(ZoneId.of("Asia/Seoul"));
        //this.finishAt = LocalDateTime.of(LocalDate.now(ZoneId.of("Asia/Seoul")), LocalTime.MIDNIGHT).plusDays(2); //예: 5월 15일에 등록했으면, 5월 17일 00:00에 종료
        this.finishAt = LocalDateTime.now().plusMinutes(1); //1분 뒤 종료
    }
    @Builder
    public Battle(String title, Member applicant, Member opponent, String applicantUrl, String opponentUrl, Double applicantOdds, LocalDateTime updatedAt, LocalDateTime finishAt, Double opponentOdds){
        this.title=title;
        this.applicant=applicant;
        this.opponent=opponent;
        this.applicantUrl=applicantUrl;
        this.opponentUrl=opponentUrl;
        this.applicantOdds=applicantOdds;
        this.opponentOdds=opponentOdds;
        this.updatedAt=updatedAt;
        this.finishAt=finishAt;
        this.status=BattleStatus.WAITING;
        this.result=BattleResult.WAITING;
    }
}