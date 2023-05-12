package co.ninuc.ninucco.api.dto.response;

import co.ninuc.ninucco.api.dto.Res;
import co.ninuc.ninucco.db.entity.SimilarityResult;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

import java.util.List;

@Builder
@Getter
@AllArgsConstructor
public class MemberAllRes implements Res {
    MemberRes user;
    List<MemberRes> friendList;
    List<SimilarityResult> scanResults;
    List<Object> items;
    List<BattleRes> curBattles;
    List<BattleRes> prevBattles;
    List<BattleRes> receivedBattles;
}
