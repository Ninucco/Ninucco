package co.ninuc.ninucco.db.repository;

import co.ninuc.ninucco.db.entity.Battle;
import co.ninuc.ninucco.db.entity.type.BattleStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface BattleRepository extends JpaRepository<Battle, Long> {
    List<Battle> findAllByStatusOrderByUpdatedAtDesc(BattleStatus status);

    @Query("SELECT battle " +
            "FROM Battle battle " +
            "WHERE (battle.applicant.id = :applicantId or battle.opponent.id = :opponentId) and battle.status = :status " +
            "ORDER BY battle.updatedAt DESC")
    List<Battle> findAllByStatus(@Param("applicantId") String applicantId, @Param("opponentId") String opponentId, @Param("status") BattleStatus status);

    List<Battle> findAllByStatusAndOpponentIdOrderByUpdatedAtDesc(BattleStatus status, String opponentId);
}
