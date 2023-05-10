package co.ninuc.ninucco.db.repository;

import co.ninuc.ninucco.db.entity.Battle;
import co.ninuc.ninucco.db.entity.type.BattleStatus;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface BattleRepository extends JpaRepository<Battle, Long> {
    List<Battle> findAllByStatusOrderByUpdatedAtDesc(BattleStatus status);
}
