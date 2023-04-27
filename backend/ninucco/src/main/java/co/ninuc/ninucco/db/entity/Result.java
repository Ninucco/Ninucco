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
public class Result extends BaseEntity {
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(referencedColumnName = "id", name="member_id")
    Member member;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(referencedColumnName = "id", name="similarity_id1")
    Result result1;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(referencedColumnName = "id", name="similarity_id2")
    Result result2;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(referencedColumnName = "id", name="similarity_id3")
    Result result3;
    @Column(name = "similarity_rate1", nullable = false)
    Double similarityRate1;
    @Column(name = "similarity_rate2", nullable = false)
    Double similarityRate2;
    @Column(name = "similarity_rate3", nullable = false)
    Double similarityRate3;
    @CreatedDate
    LocalDateTime createdAt;

    @Builder
    public Result(Member member, Result result1, Result result2, Result result3, Double similarityRate1, Double similarityRate2, Double similarityRate3) {
        this.member = member;
        this.result1 = result1;
        this.result2 = result2;
        this.result3 = result3;
        this.similarityRate1 = similarityRate1;
        this.similarityRate2 = similarityRate2;
        this.similarityRate3 = similarityRate3;
    }
}
