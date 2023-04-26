package co.ninuc.ninucco.api.service;

import co.ninuc.ninucco.api.dto.request.BattleCreateReq;
import co.ninuc.ninucco.api.dto.request.BettingCreateReq;
import co.ninuc.ninucco.api.dto.response.BattleRes;
import co.ninuc.ninucco.api.dto.response.BattleResultRes;

import java.util.List;

public interface BattleService {
    Long insertBattle(BattleCreateReq battleCreateReq);

    List<BattleRes> selectAllBattle(String option);

    BattleRes selectOneBattle(Long battleId);

    Long insertBetting(BettingCreateReq battleCreateReq);

    BattleResultRes selectOneBattleResult(Long battleId);
}
