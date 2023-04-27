package co.ninuc.ninucco.db.entity;

import lombok.Builder;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@NoArgsConstructor
@Table(name = "member_similarity")
public class MemberResult extends BaseEntity {
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(referencedColumnName = "id", name = "member_id")
    Member member;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(referencedColumnName = "id", name = "similarity_id")
    Result result;

    @Builder
    public MemberResult(Member member, Result result) {
        this.member = member;
        this.result = result;
    }
}
