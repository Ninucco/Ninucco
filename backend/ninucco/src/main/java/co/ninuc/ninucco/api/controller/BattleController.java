package co.ninuc.ninucco.api.controller;

import co.ninuc.ninucco.api.dto.ApiResult;
import co.ninuc.ninucco.api.dto.request.BettingCreateReq;
import co.ninuc.ninucco.api.dto.request.BattleCreateReq;
import co.ninuc.ninucco.api.dto.request.CommentCreateReq;
import co.ninuc.ninucco.api.service.BattleService;
import co.ninuc.ninucco.api.service.CommentService;
import co.ninuc.ninucco.common.exception.NotFoundException;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/battle")
@RequiredArgsConstructor
public class BattleController {
    private final BattleService battleService;
    private final CommentService commentService;
    private final boolean SUCCESS = true;

    //배틀 등록
    @ApiOperation(value = "배틀 등록", notes = "배틀을 등록합니다.")
    @PostMapping("/")
    public ResponseEntity<?> insertBattle(BattleCreateReq battleCreateReq) throws NotFoundException{
        return ResponseEntity.ok().body(
                new ApiResult<>(SUCCESS, battleService.insertBattle(battleCreateReq))
        );
    }
    //배틀 리스트 조회
    @ApiOperation(value = "배틀 리스트 조회", notes="배틀 리스트를 조회합니다. option: latest(최신순), votes(투표수 높은 순)")
    @GetMapping("/list")
    public ResponseEntity<?> selectAllBattle(@RequestParam String option){
        return ResponseEntity.ok().body(
                new ApiResult<>(SUCCESS, battleService.selectAllBattle(option))
        );
    }
    //배틀 상세정보 조회
    @ApiOperation(value = "배틀 상세정보 조회", notes = "배틀 진행중의 상세정보를 조회합니다.")
    @GetMapping("/{battleId}")
    public ResponseEntity<?> selectOneBattle(@PathVariable Long battleId) throws NotFoundException{
        return ResponseEntity.ok().body(
                new ApiResult<>(SUCCESS, battleService.selectOneBattle(battleId))
        );
    }
    //댓글 작성
    @ApiOperation(value="댓글 작성", notes = "댓글 작성")
    @PostMapping("/comment")
    public ResponseEntity<?> insertComment(CommentCreateReq commentCreateReq) throws NotFoundException{
        return ResponseEntity.ok().body(
                new ApiResult<>(SUCCESS, commentService.insertComment(commentCreateReq))
        );
    }
    //댓글 리스트 조회
    @ApiOperation(value="댓글 리스트 조회", notes = "배틀의 댓글 리스트를 조회합니다.")
    @GetMapping("/{battleId}/comment")
    public ResponseEntity<?> selectAllComment(@PathVariable Long battleId) throws NotFoundException{
        return ResponseEntity.ok().body(
          new ApiResult<>(SUCCESS, commentService.selectAllComment(battleId))
        );
    }
    //배팅하기
    @ApiOperation(value="배팅하기", notes = "배팅 신청")
    @PostMapping("/bet")
    public ResponseEntity<?> insertBetting(@RequestBody BettingCreateReq bettingCreateReq) throws NotFoundException {
        return ResponseEntity.ok().body(
          new ApiResult<>(SUCCESS, battleService.insertBetting(bettingCreateReq))
        );
    }
    //배틀 결과 조회: 끝난 배틀 조회
    @ApiOperation(value="배틀 결과 조회", notes = "끝난 배틀")
    @GetMapping("/battle/{battleId}/result")
    public ResponseEntity<?> selectOneBattleResult(@PathVariable Long battleId) throws NotFoundException{
        return ResponseEntity.ok().body(
                new ApiResult<>(SUCCESS, battleService.selectOneBattleResult(battleId))
        );
    }

}
