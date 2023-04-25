package co.ninuc.ninucco.db.entity;

import javax.persistence.*;

import lombok.Builder;
import org.hibernate.annotations.ColumnDefault;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.time.LocalDateTime;

@Entity
@Table(name = "member")
@Getter
@NoArgsConstructor
@EntityListeners(AuditingEntityListener.class)
public class Member {
    @Id
    @Column(name="id", length = 40)
    String id;

    @Column(name="nickname", unique = true, nullable = false)
    String nickname;

    @Column(name="win_count", nullable = false)
    @ColumnDefault("0")
    Long winCount;

    @Column(name="lose_count", nullable = false)
    @ColumnDefault("0")
    Long loseCount;

    @Column(name="point", nullable = false)
    @ColumnDefault("0")
    Long point;

    @Column(name="rate", nullable = false)
    @ColumnDefault("0")
    Long rate;

    @CreatedDate
    LocalDateTime createdAt;

    @LastModifiedDate
    LocalDateTime updatedAt;

    @Builder
    public Member(String id, String nickname, Long winCount, Long loseCount, Long point, Long rate){
        this.id=id;
        this.nickname=nickname;
        this.winCount=winCount;
        this.loseCount=loseCount;
        this.point=point;
        this.rate=rate;
    }
}
