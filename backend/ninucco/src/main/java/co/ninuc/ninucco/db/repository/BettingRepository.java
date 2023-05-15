package co.ninuc.ninucco.db.repository;

import co.ninuc.ninucco.db.entity.Betting;
import co.ninuc.ninucco.db.entity.type.BetSide;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface BettingRepository extends JpaRepository<Betting, Long> {
    Long countByBattleId(Long battleId);
    Optional<Betting> findByMemberIdAndBattleId(String memberId, Long battleId);
    int countByBattleIdAndBetSide(Long battleId, BetSide betSide);
}
