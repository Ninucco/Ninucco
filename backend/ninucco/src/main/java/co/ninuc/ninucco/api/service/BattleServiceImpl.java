package co.ninuc.ninucco.api.service;

import co.ninuc.ninucco.api.dto.ErrorRes;
import co.ninuc.ninucco.api.dto.request.BattleCreateReq;
import co.ninuc.ninucco.api.dto.request.BattleUpdateReq;
import co.ninuc.ninucco.api.dto.request.BettingCreateReq;
import co.ninuc.ninucco.api.dto.response.BattleListRes;
import co.ninuc.ninucco.api.dto.response.BattleRes;
import co.ninuc.ninucco.api.dto.response.BattleResultRes;
import co.ninuc.ninucco.api.dto.response.BettingRes;
import co.ninuc.ninucco.common.exception.CustomException;
import co.ninuc.ninucco.common.util.ValidateUtil;
import co.ninuc.ninucco.db.entity.Battle;
import co.ninuc.ninucco.db.entity.Betting;
import co.ninuc.ninucco.db.entity.Member;
import co.ninuc.ninucco.db.entity.type.BattleResult;
import co.ninuc.ninucco.db.repository.BattleRepository;
import co.ninuc.ninucco.db.repository.BettingRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class BattleServiceImpl implements BattleService{
    private final BattleRepository battleRepository;
    private final BettingRepository bettingRepository;
    private final ValidateUtil validateUtil;

    private static final int C = 20;
    @Transactional
    @Override
    public BattleRes insertBattle(BattleCreateReq battleCreateReq){
        Battle battle = toEntity(battleCreateReq);
        battleRepository.save(battle);
        return toRes(battle);
    }

    @Override
    public BattleRes updateBattle(BattleUpdateReq battleUpdateReq) {
        Battle battle = validateUtil.battleValidateById(battleUpdateReq.getBattleId());
        Member applicant = validateUtil.memberValidateById(battle.getApplicant().getId());
        Member opponent = validateUtil.memberValidateById(battle.getOpponent().getId());

        double[] odds = calcOddsByElos(applicant.getElo(), opponent.getElo());
        battle.updateBattle(battleUpdateReq.getOpponentUrl(), odds[0], odds[1]);

        return toRes(battle);
    }

    @Override
    public BattleListRes selectAllBattle(String option) {
        return new BattleListRes(battleRepository.findAll().stream()
                .map(this::toRes).collect(Collectors.toList()));
    }

    @Override
    public BattleRes selectOneBattle(Long battleId){
        return toRes(validateUtil.battleValidateById(battleId));
    }

    @Transactional
    @Override
    public BettingRes insertBetting(BettingCreateReq bettingCreateReq){
        return toBettingRes(bettingRepository.save(toEntity(bettingCreateReq)));
    }

    @Override
    public BettingRes selectOneBetting(String memberId, Long battleId) {
        validateUtil.memberValidateById(memberId);
        validateUtil.battleValidateById(battleId);

        Optional<Betting> optionalBetting = bettingRepository.findByMemberIdAndBattleId(memberId, battleId);
        BettingRes bettingRes;

        /* 본인이 해당 배틀에 베팅했었다면 validate를 true로 설정하고
           베팅 정보를 Response에 전달한다.
           베팅을 하지 않았다면 validate를 false로 설정하고,
           Response로 isExist만을 전달한다.
        */
        if(optionalBetting.isPresent()) {
            Betting betting = optionalBetting.get();
            bettingRes = toBettingRes(betting) ;
        }
        else {
            bettingRes = toBettingNullRes(false);
        }

        return bettingRes;
    }


    //TODO: 배틀 결과 조회 필요?
    @Override
    public BattleResultRes selectOneBattleResult(Long battleId){
        return null;
    }
    //TODO: 시간마다 배틀 끝났는지 체크

    //배틀이 끝나면 콜되는 함수
    private void finishBattle(Long battleId){
        Battle battle = validateUtil.battleValidateById(battleId);
        /*배틀 결과 구하기
        * ...
        * */
        BattleResult result = BattleResult.APPLICANT;
        //배틀 결과에 따라 battleResult, 멤버들 elo업데이트
        updateEloAndResultByResult(battle, result);

        //배틀 상태 TERMINATED로 변경
        battle.updateStatusTerminated();
        //배틀 끝남 FCM보내기

    }

    // toEntity, toRes
    Battle toEntity(BattleCreateReq battleCreateReq){
        Member applicant = validateUtil.memberValidateById(battleCreateReq.getApplicantId());
        Member opponent = validateUtil.memberValidateById(battleCreateReq.getOpponentId());

//        double[] odds = calcOddsByElos(applicant.getElo(), opponent.getElo());
        return Battle.builder()
                .title(battleCreateReq.getTitle())
                .applicant(applicant)
                .opponent(opponent)
                .applicantNickname(applicant.getNickname())
                .opponentNickname(opponent.getNickname())
                .applicantUrl(battleCreateReq.getApplicantUrl())
//                .applicantOdds(odds[0])
//                .opponentOdds(odds[1])
                .build();
    }
    Betting toEntity(BettingCreateReq bettingCreateReq){
        return Betting.builder()
                .battle(validateUtil.battleValidateById(bettingCreateReq.getBattleId()))
                .member(validateUtil.memberValidateById(bettingCreateReq.getMemberId()))
                .betSide(bettingCreateReq.getBetSide())
                .betMoney(bettingCreateReq.getBetMoney()).build();
    }
    BattleRes toRes(Battle battle){
        return BattleRes.builder()
                .battleId(battle.getId())
                .applicantName(battle.getApplicantNickname())
                .opponentName(battle.getOpponentNickname())
                .title(battle.getTitle())
                .applicantUrl(battle.getApplicantUrl())
                .opponentUrl(battle.getOpponentUrl())
                .currentVotes(bettingRepository.countByBattleId(battle.getId()))
                .applicantOdds(battle.getApplicantOdds())
                .opponentOdds(battle.getOpponentOdds())
                .finishTime(battle.getFinishAt()).build();
    }

    BettingRes toBettingRes(Betting betting) {
        return BettingRes.builder()
                .validate(true)
                .betSide(betting.getBetSide())
                .betMoney(betting.getBetMoney())
                .build();
    }

    BettingRes toBettingNullRes(boolean validate) {
        return BettingRes.builder()
                .validate(validate)
                .betSide(null)
                .betMoney(null)
                .build();
    }
        public void updateEloAndResultByResult(Battle battle, BattleResult winner){
        if(winner==BattleResult.PROCEEDING)
            throw new CustomException(ErrorRes.INTERNAL_SERVER_ERROR);
        Member mWin, mLose;
        if(winner==BattleResult.APPLICANT) {
            mWin = battle.getApplicant();
            mLose = battle.getOpponent();
        } else{ //BattleResult.OPPONENT
            mWin = battle.getOpponent();
            mLose = battle.getApplicant();
        }
        int rLose = mLose.getElo();
        int rSum = mWin.getElo()+rLose;
        int d = (int)((double)C*2*rLose/rSum);
        if(d==0) d=1;
        mWin.updateElo(mWin.getElo()+d);
        mLose.updateElo(rLose-d);
        battle.updateResult(winner);
    }
    private static double[] calcOddsByElos(int elo1, int elo2){
        int eloSum = elo1+elo2;
        double odd1 = 1+(double)2*elo2/eloSum;
        double odd2 = 1+(double)2*elo1/eloSum;
        return new double[] {odd1,odd2};
    }
}