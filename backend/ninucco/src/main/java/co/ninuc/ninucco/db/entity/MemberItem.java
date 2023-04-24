package co.ninuc.ninucco.db.entity;

import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Getter
@NoArgsConstructor
@Table(name="member_item")
public class MemberItem extends BaseEntity {
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(referencedColumnName = "id", name = "member_id")
    Member member;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(referencedColumnName = "id", name = "item_id")
    Item item;
    @Column(name="amount", nullable = false)
    Long amount;

    public MemberItem(Member member, Item item, Long amount){
        this.member=member;
        this.item=item;
        this.amount=amount;
    }
}
