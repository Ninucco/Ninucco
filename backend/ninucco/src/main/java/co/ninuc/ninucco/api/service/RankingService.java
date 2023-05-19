package co.ninuc.ninucco.api.service;

import co.ninuc.ninucco.api.dto.response.BattleRankingRes;
import co.ninuc.ninucco.api.dto.response.EloRankingRes;
import co.ninuc.ninucco.api.dto.response.PointRankingRes;
import co.ninuc.ninucco.api.dto.response.SimilarityRankingRes;

import java.util.List;

public interface RankingService {
    BattleRankingRes selectBattleRanking();

    EloRankingRes selectEloRanking();

    PointRankingRes selectPointRanking();

    SimilarityRankingRes selectSimilarityRanking();
}
