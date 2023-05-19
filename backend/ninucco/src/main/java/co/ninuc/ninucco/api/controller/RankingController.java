package co.ninuc.ninucco.api.controller;

import co.ninuc.ninucco.api.dto.ApiResult;
import co.ninuc.ninucco.api.dto.Res;
import co.ninuc.ninucco.api.service.RankingService;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/rank")
@RequiredArgsConstructor
public class RankingController {

    private final boolean SUCCESS = true;
    private final RankingService rankingService;

    @ApiOperation(value = "배틀 이긴 횟수 랭킹 조회", notes = "배틀 이긴 횟수 TOP100 랭킹을 조회합니다.")
    @GetMapping("/battle")
    public ResponseEntity<ApiResult<Res>> selectBattleRanking(){
        return ResponseEntity.ok().body(new ApiResult<>(SUCCESS, rankingService.selectBattleRanking()));
    }

    @ApiOperation(value = "elo 랭킹 조회", notes = "elo TOP100 랭킹을 조회합니다.")
    @GetMapping("/elo")
    public ResponseEntity<ApiResult<Res>> selectEloRanking(){
        return ResponseEntity.ok().body(new ApiResult<>(SUCCESS, rankingService.selectEloRanking()));
    }

    @ApiOperation(value = "point 랭킹 조회", notes = "point TOP100 랭킹을 조회합니다.")
    @GetMapping("/point")
    public ResponseEntity<ApiResult<Res>> selectPointRanking(){
        return ResponseEntity.ok().body(new ApiResult<>(SUCCESS, rankingService.selectPointRanking()));
    }
}
