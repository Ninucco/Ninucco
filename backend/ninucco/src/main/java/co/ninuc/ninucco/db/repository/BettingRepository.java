package co.ninuc.ninucco.db.repository;

import co.ninuc.ninucco.db.entity.Betting;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BettingRepository extends JpaRepository<Betting, Long> {
}
