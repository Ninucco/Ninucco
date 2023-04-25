package co.ninuc.ninucco.api.service;

import co.ninuc.ninucco.api.dto.request.BattleCreateReq;
import co.ninuc.ninucco.api.dto.request.BettingCreateReq;
import co.ninuc.ninucco.api.dto.response.BattleRes;
import co.ninuc.ninucco.api.dto.response.BattleResultRes;
import co.ninuc.ninucco.common.exception.NotFoundException;

import java.util.List;

public interface BattleService {
    Long insertBattle(BattleCreateReq battleCreateReq) throws NotFoundException;
    List<BattleRes> selectAllBattle(String option);
    BattleRes selectOneBattle(Long battleId) throws NotFoundException;
    Long insertBetting(BettingCreateReq battleCreateReq) throws NotFoundException;
    BattleResultRes selectOneBattleResult(Long battleId) throws NotFoundException;
}
