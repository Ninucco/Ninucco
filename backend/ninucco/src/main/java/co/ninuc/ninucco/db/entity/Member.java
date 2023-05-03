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

    @Column(name="url")
    String url;

    @Column(name="win_count", nullable = false)
    @ColumnDefault("0")
    int winCount;

    @Column(name="lose_count", nullable = false)
    @ColumnDefault("0")
    int loseCount;

    @Column(name="point", nullable = false)
    @ColumnDefault("0")
    long point;

    @Column(name="rate", nullable = false)
    @ColumnDefault("1000")
    int rate;

    @CreatedDate
    LocalDateTime createdAt;

    @LastModifiedDate
    LocalDateTime updatedAt;

    @Builder
    public Member(String id, String nickname,String url){
        this.id=id;
        this.nickname=nickname;
        this.url=url;
        this.winCount=0;
        this.loseCount=0;
        this.point=0;
        this.rate=1000;
    }

    public void updateUrl(String url){
        this.url=url;
    }
    public void updateNickname(String nickname){
        this.nickname=nickname;
    }
    public void updateRate(int rate){
        this.rate=rate;
    }
}
