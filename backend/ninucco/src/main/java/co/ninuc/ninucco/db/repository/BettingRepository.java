package co.ninuc.ninucco.db.repository;

import co.ninuc.ninucco.db.entity.Betting;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface BettingRepository extends JpaRepository<Betting, Long> {
    Long countByBattleId(Long battleId);

    Optional<Betting> findByMemberIdAndBattle_Id(String memberId, Long battleId);
}
