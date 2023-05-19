package co.ninuc.ninucco.db.repository;

import co.ninuc.ninucco.db.entity.SimilarityResult;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;

public interface SimilarityResultRepository extends MongoRepository<SimilarityResult, String> {
    List<SimilarityResult> findAllByMemberId(String memberId);
}
