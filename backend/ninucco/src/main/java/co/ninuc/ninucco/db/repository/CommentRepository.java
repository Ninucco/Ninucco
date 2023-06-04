package co.ninuc.ninucco.db.repository;

import co.ninuc.ninucco.db.entity.Comment;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CommentRepository extends JpaRepository<Comment, Long> {

    List<Comment> findAllByBattleIdOrderByCreatedAtDesc(Long battleId);
}
