package co.ninuc.ninucco.db.entity;

import co.ninuc.ninucco.db.entity.type.MemberFriendStatus;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;

@Entity
@Table(name="member_friend")
@Getter
@NoArgsConstructor
@EntityListeners(AuditingEntityListener.class)
public class MemberFriend extends BaseEntity {
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(referencedColumnName = "id", name = "member_id")
    Member member;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(referencedColumnName = "id", name = "friend_id")
    Member friend;
    @Column(name="status", nullable = false)
    MemberFriendStatus status;

    public void updateStatus(MemberFriendStatus status) {
        this.status = status;
    }
    @Builder
    public MemberFriend(Member member, Member friend, MemberFriendStatus status){
        this.member=member;
        this.friend=friend;
        this.status=status;
    }
}
