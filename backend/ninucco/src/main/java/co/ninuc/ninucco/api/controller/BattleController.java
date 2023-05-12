package co.ninuc.ninucco.api.controller;

import co.ninuc.ninucco.api.dto.ApiResult;
import co.ninuc.ninucco.api.dto.Res;
import co.ninuc.ninucco.api.dto.request.BattleCreateReq;
import co.ninuc.ninucco.api.dto.request.BattleUpdateReq;
import co.ninuc.ninucco.api.dto.request.BettingCreateReq;
import co.ninuc.ninucco.api.dto.request.CommentCreateReq;
import co.ninuc.ninucco.api.service.BattleService;
import co.ninuc.ninucco.api.service.CommentService;
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
    @RequestMapping(value="", method = RequestMethod.POST,consumes = {"multipart/form-data"})
    public ResponseEntity<ApiResult<Res>> insertBattle(@ModelAttribute BattleCreateReq battleCreateReq) {
        return ResponseEntity.ok().body(
                new ApiResult<>(SUCCESS, battleService.insertBattle(battleCreateReq))
        );
    }

    //배틀 리스트 조회
    @ApiOperation(value = "배틀 리스트 조회", notes="배틀 리스트를 조회합니다. option: latest(최신순), votes(투표수 높은 순)")
    @GetMapping("/list")
    public ResponseEntity<ApiResult<Res>> selectAllBattle(@RequestParam String option){
        return ResponseEntity.ok().body(
                new ApiResult<>(SUCCESS, battleService.selectAllBattle(option))
        );
    }

    //************************************************************** 노필요
    // 내 배틀 리스트 조회
    @ApiOperation(value = "나의 배틀 리스트 조회", notes = "로그인한 사용자의 배틀 리스트를 조회합니다. status: TERMINATED(종료된), PROCEEDING(진행중)")
    @GetMapping("/my-list")
    public ResponseEntity<ApiResult<Res>> selectAllMyBattle(@RequestParam String memberId,@RequestParam String status) {
        return ResponseEntity.ok().body(
                new ApiResult<>(SUCCESS, battleService.selectAllMemberBattle(memberId, status))
        );
    }
    
    //**************************************************************
    // 타사용자 배틀 리스트 조회
    @ApiOperation(value = "타사용자의 배틀 리스트 조회", notes = "다른 사용자의 배틀 리스트를 조회합니다. status: TERMINATED(종료된), PROCEEDING(진행중)")
    @GetMapping("/other-list")
    public ResponseEntity<ApiResult<Res>> selectAllOtherBattle(@RequestParam String memberId, @RequestParam String status) {
        return ResponseEntity.ok().body(
                new ApiResult<>(SUCCESS, battleService.selectAllMemberBattle(memberId, status))
        );
    }
    //**************************************************************
    // 신청받은 배틀 리스트 조회
    @ApiOperation(value = "신청받은 배틀 리스트 조회", notes = "신청받은 배틀 리스트를 조회합니다.")
    @GetMapping("/received-list")
    public ResponseEntity<ApiResult<Res>> selectAllReceivedBattle(@RequestParam String memberId) {
        return ResponseEntity.ok().body(
                new ApiResult<>(SUCCESS, battleService.selectAllReceivedBattle(memberId)));
    }

    //배틀 상세정보 조회
    @ApiOperation(value = "배틀 상세정보 조회", notes = "배틀 진행중의 상세정보를 조회합니다.")
    @GetMapping("/{battleId}")
    public ResponseEntity<ApiResult<Res>> selectOneBattle(@PathVariable Long battleId) {
        return ResponseEntity.ok().body(
                new ApiResult<>(SUCCESS, battleService.selectOneBattle(battleId))
        );
    }

    // 배틀 수락 시 수정
    @ApiOperation(value = "배틀 수락", notes = "배틀을 수락하면 해당 배틀 데이터를 수정합니다.")
    @RequestMapping(value="", method = RequestMethod.PATCH,consumes = {"multipart/form-data"})
    public ResponseEntity<ApiResult<Res>> updateBattle(@ModelAttribute BattleUpdateReq battleUpdateReq) {
        return ResponseEntity.ok().body(new ApiResult<>(SUCCESS, battleService.updateBattle(battleUpdateReq)));
    }

    //배틀 신청 거절
    @ApiOperation(value = "배틀 신청 거절", notes = "배틀 신청 거절 시, 배틀 테이블에서 삭제합니다.")
    @DeleteMapping("/{battleId}")
    public ResponseEntity<ApiResult<Res>> deleteBattle (@PathVariable Long battleId) {
        return ResponseEntity.ok().body(
                new ApiResult<>(SUCCESS, battleService.deleteBattle(battleId))
        );
    }

    //댓글 작성
    @ApiOperation(value="댓글 작성", notes = "댓글 작성")
    @PostMapping("/comment")
    public ResponseEntity<ApiResult<Res>> insertComment(@RequestParam String memberId,@RequestBody CommentCreateReq commentCreateReq) {
        return ResponseEntity.ok().body(
                new ApiResult<>(SUCCESS, commentService.insertComment(memberId, commentCreateReq))
        );
    }
    //댓글 리스트 조회
    @ApiOperation(value="댓글 리스트 조회", notes = "배틀의 댓글 리스트를 조회합니다.")
    @GetMapping("/{battleId}/comment")
    public ResponseEntity<ApiResult<Res>> selectAllComment(@PathVariable Long battleId) {
        return ResponseEntity.ok().body(
          new ApiResult<>(SUCCESS, commentService.selectAllComment(battleId))
        );
    }
    //배팅하기
    @ApiOperation(value="베팅하기", notes = "베팅 신청")
    @PostMapping("/bet")
    public ResponseEntity<ApiResult<Res>> insertBetting(@RequestBody BettingCreateReq bettingCreateReq) {
        return ResponseEntity.ok().body(
          new ApiResult<>(SUCCESS, battleService.insertBetting(bettingCreateReq))
        );
    }

    @ApiOperation(value = "배팅 여부 조회", notes = "본인이 해당 배틀에 배팅을 했는지")
    @GetMapping("/{battleId}/bet")
    public ResponseEntity<ApiResult<Res>> selectOneBetting(@RequestParam String memberId,@PathVariable Long battleId) {
        return ResponseEntity.ok().body(new ApiResult<>(SUCCESS, battleService.selectOneBetting(memberId, battleId)));
    }

    //배틀 결과 조회: 끝난 배틀 조회
    @ApiOperation(value="배틀 결과 조회", notes = "끝난 배틀")
    @GetMapping("/battle/{battleId}/result")
    public ResponseEntity<?> selectOneBattleResult(@PathVariable Long battleId) {
        return ResponseEntity.ok().body(
                new ApiResult<>(SUCCESS, battleService.selectOneBattleResult(battleId))
        );
    }

}