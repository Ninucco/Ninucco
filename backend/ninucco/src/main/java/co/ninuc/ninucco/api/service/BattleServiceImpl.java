package co.ninuc.ninucco.api.service;

import co.ninuc.ninucco.api.dto.ErrorRes;
import co.ninuc.ninucco.api.dto.request.BattleCreateReq;
import co.ninuc.ninucco.api.dto.request.BettingCreateReq;
import co.ninuc.ninucco.api.dto.response.BattleRes;
import co.ninuc.ninucco.api.dto.response.BattleResultRes;
import co.ninuc.ninucco.common.exception.CustomException;
import co.ninuc.ninucco.db.entity.Battle;
import co.ninuc.ninucco.db.entity.Betting;
import co.ninuc.ninucco.db.entity.Member;
import co.ninuc.ninucco.db.repository.BattleRepository;
import co.ninuc.ninucco.db.repository.BettingRepository;
import co.ninuc.ninucco.db.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.ZoneId;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class BattleServiceImpl implements BattleService{
    private final BattleRepository battleRepository;
    private final MemberRepository memberRepository;
    private final BettingRepository bettingRepository;

    @Transactional
    @Override
    public Long insertBattle(BattleCreateReq battleCreateReq){
        return battleRepository.save(toEntity(battleCreateReq)).getId();
    }

    @Override
    public List<BattleRes> selectAllBattle(String option) {
        return battleRepository.findAll().stream()
                .map(this::toRes).collect(Collectors.toList());
    }

    @Override
    public BattleRes selectOneBattle(Long battleId){
        return toRes(battleRepository.findById(battleId)
                .orElseThrow(()->new CustomException(ErrorRes.NOT_FOUND_BATTLE)));
    }

    @Transactional
    @Override
    public Long insertBetting(BettingCreateReq bettingCreateReq){
        return bettingRepository.save(toEntity(bettingCreateReq)).getId();
    }

    //TODO: 배틀 결과 조회 필요?
    @Override
    public BattleResultRes selectOneBattleResult(Long battleId){
        return null;
    }
    //TODO: 시간마다 배틀 끝났는지 체크
    //TODO: 시간 끝났으면 배틀 끝내고 플러터로 알림 보내기

    // toEntity, toRes
    Battle toEntity(BattleCreateReq battleCreateReq){
        Member applicant = memberRepository.findById(battleCreateReq.getApplicantId())
                .orElseThrow(()->new CustomException(ErrorRes.NOT_FOUND_MEMBER));
        Member opponent = memberRepository.findById(battleCreateReq.getOpponentId())
                .orElseThrow(()->new CustomException(ErrorRes.NOT_FOUND_MEMBER));

        return Battle.builder()
                .title(battleCreateReq.getTitle())
                .applicant(applicant)
                .opponent(opponent)
                .applicantNickname(applicant.getNickname())
                .opponentNickname(opponent.getNickname())
                .applicantUrl(battleCreateReq.getApplicantUrl())
                .opponentUrl(battleCreateReq.getOpponentUrl())
                .applicantOdds(1.0)
                .opponentOdds(1.0)
                .finishAt(LocalDateTime.of(LocalDate.now(ZoneId.of("Asia/Seoul")), LocalTime.MIDNIGHT).plusDays(1))
                .build();
    }
    Betting toEntity(BettingCreateReq bettingCreateReq){
        return Betting.builder()
                .battle(battleRepository.findById(bettingCreateReq.getBattleId())
                        .orElseThrow(()->new CustomException(ErrorRes.NOT_FOUND_MEMBER)))
                .member(memberRepository.findById(bettingCreateReq.getMemberId())
                        .orElseThrow(()->new CustomException(ErrorRes.NOT_FOUND_MEMBER)))
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
}