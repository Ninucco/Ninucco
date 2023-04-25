package co.ninuc.ninucco.api.service;

import co.ninuc.ninucco.api.dto.ErrorRes;
import co.ninuc.ninucco.api.dto.request.BattleCreateReq;
import co.ninuc.ninucco.api.dto.request.BettingCreateReq;
import co.ninuc.ninucco.api.dto.response.BattleRes;
import co.ninuc.ninucco.api.dto.response.BattleResultRes;
import co.ninuc.ninucco.common.exception.CustomException;
import co.ninuc.ninucco.db.entity.Battle;
import co.ninuc.ninucco.db.entity.Betting;
import co.ninuc.ninucco.db.repository.BattleRepository;
import co.ninuc.ninucco.db.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class BattleServiceImpl implements BattleService{
    private final BattleRepository battleRepository;
    private final MemberRepository memberRepository;

    @Transactional
    @Override
    public Long insertBattle(BattleCreateReq battleCreateReq) throws CustomException {
        return null;
    }

    @Override
    public List<BattleRes> selectAllBattle(String option) {
        return null;
    }

    @Override
    public BattleRes selectOneBattle(Long battleId) throws CustomException {
        return null;
    }

    @Transactional
    @Override
    public Long insertBetting(BettingCreateReq battleCreateReq) throws CustomException {
        return null;
    }

    @Override
    public BattleResultRes selectOneBattleResult(Long battleId) throws CustomException {
        return null;
    }
    //시간마다 배틀 끝났는지 체크
    //시간 끝났으면 배틀 끝내고 플러터로 알림 보내기



    // toEntity, toRes
    Battle toEntity(BattleCreateReq battleCreateReq){
        return Battle.builder()
                .title(battleCreateReq.getTitle())
                .applicant(memberRepository.findById(battleCreateReq.getApplicantId())
                        .orElseThrow(()->new CustomException(ErrorRes.NOT_FOUND_A)))
                .opponent(memberRepository.findById(battleCreateReq.getOpponentId())
                        .orElseThrow(()->new CustomException(ErrorRes.NOT_FOUND_A)))
                .applicantUrl(battleCreateReq.getApplicantUrl())
                .opponentUrl(battleCreateReq.getOpponentUrl())
                .applicantOdds(1.0)
                .opponentOdds(1.0).build();
    }
    Betting toEntity(BettingCreateReq bettingCreateReq){
        return null;
    }
}
