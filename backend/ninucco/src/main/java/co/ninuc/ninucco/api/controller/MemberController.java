package co.ninuc.ninucco.api.controller;

import co.ninuc.ninucco.api.dto.ApiResult;
import co.ninuc.ninucco.api.dto.Res;
import co.ninuc.ninucco.api.dto.request.MemberCreateReq;
import co.ninuc.ninucco.api.dto.request.MemberFriendCreateReq;
import co.ninuc.ninucco.api.service.MemberFriendService;
import co.ninuc.ninucco.api.service.MemberService;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/member")
@RequiredArgsConstructor
public class MemberController {
    private final MemberService memberService;
    private final MemberFriendService memberFriendService;
    private final boolean SUCCESS = true;

    @ApiOperation(value = "회원 가입", notes="유저를 등록합니다.")
    @PostMapping("/regist")
    public ResponseEntity<ApiResult<Res>> insertMember(MemberCreateReq memberCreateReq){
        return ResponseEntity.ok().body(
                new ApiResult<>(SUCCESS, memberService.insertMember(memberCreateReq))
        );
    }

    @ApiOperation(value = "친구 맺기", notes = "친구 신청을 수락합니다.")
    @PostMapping("/friend")
    public ResponseEntity<ApiResult<Res>> insertMemberFriend(MemberFriendCreateReq memberFriendCreateReq) {

        //TODO memberId를 헤더에 있는 토큰을 이용해 가져온다.
        return ResponseEntity.ok().body(
                new ApiResult<>(SUCCESS, memberFriendService.insertMemberFriend("testId1", memberFriendCreateReq.getFriendId())));
    }

    @ApiOperation(value = "닉네임 중복검사", notes="닉네임 중복검사")
    @GetMapping("/regist/nickname")
    public ResponseEntity<ApiResult<Res>> checkMemberNickname(@RequestParam String nickname){
        return ResponseEntity.ok().body(
                new ApiResult<>(SUCCESS, memberService.checkMemberNickname(nickname))
        );
    }

    @ApiOperation(value = "친구 관계 조회", notes = "본인과 친구인지 확인합니다.")
    @GetMapping("/friend/{friendId}")
    public ResponseEntity<ApiResult<Res>> selectOneMemberFriend(@PathVariable String friendId) {

        //TODO memberId를 헤더에 있는 토큰을 이용해 가져온다.
        return ResponseEntity.ok().body(
                new ApiResult<>(SUCCESS, memberFriendService.selectOneMemberFriend("testId1", friendId)));
    }

    @ApiOperation(value = "친구 목록 조회", notes = "본인의 친구 목록을 조회합니다.")
    @GetMapping("/friend-list")
    public ResponseEntity<ApiResult<Res>> selectAllMemberFriend() {

        //TODO memberId를 헤더에 있는 토큰을 이용해 가져온다.
        return ResponseEntity.ok().body(
                new ApiResult<>(SUCCESS, memberFriendService.selectAllMemberFriend("testId1")));
    }

    @ApiOperation(value = "친구 삭제", notes = "친구를 삭제합니다.")
    @DeleteMapping("/friend/{friendId}")
    public ResponseEntity<ApiResult<Res>> deleteMemberFriend(@PathVariable String friendId) {

        //TODO memberId를 헤더에 있는 토큰을 이용해 가져온다.
        String memberId = "testId1";

        return ResponseEntity.ok().body(new ApiResult<>(SUCCESS, memberFriendService.deleteMemberFriend(memberId, friendId)));
    }
}
