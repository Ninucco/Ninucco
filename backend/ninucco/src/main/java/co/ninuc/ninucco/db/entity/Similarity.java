package co.ninuc.ninucco.db.entity;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@NoArgsConstructor
@Table(name = "similarity")
@Getter
@EntityListeners(AuditingEntityListener.class)
public class Similarity extends BaseEntity {
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(referencedColumnName = "id", name="member_id")
    Member member;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(referencedColumnName = "id", name="similarity_id1")
    Similarity similarity1;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(referencedColumnName = "id", name="similarity_id2")
    Similarity similarity2;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(referencedColumnName = "id", name="similarity_id3")
    Similarity similarity3;
    @Column(name = "similarity_rate1", nullable = false)
    Double similarityRate1;
    @Column(name = "similarity_rate2", nullable = false)
    Double similarityRate2;
    @Column(name = "similarity_rate3", nullable = false)
    Double similarityRate3;
    @CreatedDate
    LocalDateTime createdAt;

    @Builder
    public Similarity(Member member, Similarity similarity1, Similarity similarity2, Similarity similarity3, Double similarityRate1, Double similarityRate2, Double similarityRate3) {
        this.member = member;
        this.similarity1 = similarity1;
        this.similarity2 = similarity2;
        this.similarity3 = similarity3;
        this.similarityRate1 = similarityRate1;
        this.similarityRate2 = similarityRate2;
        this.similarityRate3 = similarityRate3;
    }
}
