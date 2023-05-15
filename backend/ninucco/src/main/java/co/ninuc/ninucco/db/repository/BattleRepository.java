package co.ninuc.ninucco.db.repository;

import co.ninuc.ninucco.db.entity.Battle;
import co.ninuc.ninucco.db.entity.type.BattleStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDateTime;
import java.util.List;

public interface BattleRepository extends JpaRepository<Battle, Long> {
    List<Battle> findAllByStatus(@Param("status") BattleStatus status);
    List<Battle> findAllByStatusOrderByUpdatedAtDesc(BattleStatus status);

    List<Battle> findAllByStatusAndOpponentIdOrderByUpdatedAtDesc(BattleStatus status, String opponentId);

    @Query("select b from Battle b where (b.applicant.id = :memberId or b.opponent.id = :memberId)" +
            "and b.status = :battleStatus " +
            "order by b.updatedAt desc")
    List<Battle> findAllByMemberIdAndStatus(String memberId, BattleStatus battleStatus);
    List<Battle> findByFinishAtLessThanAndStatus(LocalDateTime now, BattleStatus status);
}
