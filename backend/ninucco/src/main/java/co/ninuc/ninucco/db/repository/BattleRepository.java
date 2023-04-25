package co.ninuc.ninucco.db.repository;

import co.ninuc.ninucco.db.entity.Battle;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BattleRepository extends JpaRepository<Battle, Long> {
}
