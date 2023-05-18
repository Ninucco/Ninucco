package co.ninuc.ninucco.db.entity;

import co.ninuc.ninucco.db.entity.type.BetSide;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "betting")
@Getter
@NoArgsConstructor
@EntityListeners(AuditingEntityListener.class)
public class Betting extends BaseEntity {
    @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(referencedColumnName = "id", name = "battle_id")
    private Battle battle;
    @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(referencedColumnName = "id", name="member_id")
    private Member member;
    @Column(name="bet_side", nullable = false)
    @Enumerated(EnumType.STRING)
    BetSide betSide;
    @Column(name="bet_money", nullable = false)
    Long betMoney;
    @CreatedDate
    LocalDateTime createdAt;

    @Builder
    public Betting(Battle battle, Member member, BetSide betSide, Long betMoney){
        this.battle=battle;
        this.member=member;
        this.betSide=betSide;
        this.betMoney=betMoney;
    }
}
