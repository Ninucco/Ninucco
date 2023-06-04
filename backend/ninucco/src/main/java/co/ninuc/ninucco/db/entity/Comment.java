package co.ninuc.ninucco.db.entity;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "comment")
@Getter
@EntityListeners(AuditingEntityListener.class)
@NoArgsConstructor
public class Comment extends BaseEntity {
    @ManyToOne(fetch = FetchType.LAZY)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(referencedColumnName = "id", name = "member_id", nullable = false)
    Member member;

    @ManyToOne(fetch = FetchType.LAZY)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(referencedColumnName = "id", name = "battle_id", nullable = false)
    Battle battle;

    @Column(name="content", nullable = false, length = 200)
    String content;

    @CreatedDate
    LocalDateTime createdAt;

    @Builder
    public Comment(Member member, Battle battle, String content){
        this.member=member;
        this.battle=battle;
        this.content=content;
    }

}
