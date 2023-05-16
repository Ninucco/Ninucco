package co.ninuc.ninucco.api.service;

import co.ninuc.ninucco.api.dto.request.BattleCreateReq;
import co.ninuc.ninucco.api.dto.request.BattleUpdateReq;
import co.ninuc.ninucco.api.dto.request.BettingCreateReq;
import co.ninuc.ninucco.api.dto.response.BattleListRes;
import co.ninuc.ninucco.api.dto.response.BattleRes;
import co.ninuc.ninucco.api.dto.response.BattleResultRes;
import co.ninuc.ninucco.api.dto.response.BettingRes;
import co.ninuc.ninucco.db.entity.type.BattleStatus;

public interface BattleService {
    BattleRes insertBattle(BattleCreateReq battleCreateReq);

    BattleListRes selectAllBattle(String option, BattleStatus status);
    BattleListRes selectAllMemberBattle(String memberId, BattleStatus status);
    BattleListRes selectAllReceivedBattle(String memberId);

    BattleRes selectOneBattle(Long battleId);

    BattleRes updateBattle(BattleUpdateReq battleUpdateReq);

    BattleRes deleteBattle(Long battleId);

    BettingRes insertBetting(BettingCreateReq battleCreateReq);

    BettingRes selectOneBetting(String memberId, Long battleId);

    BattleResultRes selectOneBattleResult(Long battleId);
    void setAllTerminatedBattleProceeding();
}
