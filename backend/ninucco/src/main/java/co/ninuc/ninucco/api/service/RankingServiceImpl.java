package co.ninuc.ninucco.api.service;

import co.ninuc.ninucco.api.dto.BattleRankingListInfo;
import co.ninuc.ninucco.api.dto.response.BattleRankingRes;
import co.ninuc.ninucco.api.dto.response.SimilarityRankingRes;
import co.ninuc.ninucco.db.entity.Member;
import co.ninuc.ninucco.db.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class RankingServiceImpl implements RankingService {

    private final MemberRepository memberRepository;

    @Override
    public BattleRankingRes selectBattleRanking() {
        return new BattleRankingRes(memberRepository.findTop10ByOrderByWinCountDesc().stream().map(this::toBattleRankingRes).collect(Collectors.toList()));
    }

    @Override
    public SimilarityRankingRes selectSimilarityRanking() {
        //TODO 닮은꼴 랭킹 조회 구현
        return null;
    }

    BattleRankingListInfo toBattleRankingRes(Member member) {
        return BattleRankingListInfo.builder()
                .memberId(member.getId())
                .profileImage(member.getUrl())
                .nickname(member.getNickname())
                .winCount(member.getWinCount())
                .build();
    }
}
