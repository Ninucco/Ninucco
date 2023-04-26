package co.ninuc.ninucco.db.entity;

import co.ninuc.ninucco.db.entity.type.BattleResult;
import co.ninuc.ninucco.db.entity.type.BattleStatus;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
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
    @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(referencedColumnName = "id", name="applicant_id")
    Member applicant;
    @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(referencedColumnName = "id", name="opponent_id")
    Member opponent;
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
    @LastModifiedDate
    LocalDateTime updatedAt;

    @Builder
    public Battle(String title, Member applicant, Member opponent, String applicantUrl, String opponentUrl, Double applicantOdds, Double opponentOdds){
        this.title=title;
        this.applicant=applicant;
        this.opponent=opponent;
        this.applicantUrl=applicantUrl;
        this.opponentUrl=opponentUrl;
        this.applicantOdds=applicantOdds;
        this.opponentOdds=opponentOdds;
        this.status=BattleStatus.PROCEEDING;
        this.result=BattleResult.PROCEEDING;
    }
}