package co.ninuc.ninucco.db.entity;

import lombok.Builder;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@NoArgsConstructor
@Table(name = "member_similarity")
public class MemberSimilarity extends BaseEntity {
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(referencedColumnName = "id", name = "member_id")
    Member member;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(referencedColumnName = "id", name = "similarity_id")
    Similarity similarity;

    @Builder
    public MemberSimilarity(Member member, Similarity similarity) {
        this.member = member;
        this.similarity = similarity;
    }
}
