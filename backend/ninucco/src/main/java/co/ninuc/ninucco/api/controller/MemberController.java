package co.ninuc.ninucco.api.controller;

import co.ninuc.ninucco.api.dto.ApiResult;
import co.ninuc.ninucco.api.dto.Res;
import co.ninuc.ninucco.api.dto.request.*;
import co.ninuc.ninucco.api.service.MemberFriendService;
import co.ninuc.ninucco.api.service.MemberService;
import co.ninuc.ninucco.db.repository.MemberRepository;
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
    private final MemberRepository memberRepository;

    @ApiOperation(value = "로그인",notes="파이버베이스 키(PK)를 주면 해당 유저의 정보를 반환합니다.")
    @PostMapping("/login")
    public ResponseEntity<ApiResult<Res>> login(@RequestBody LoginReq loginReq){
        return ResponseEntity.ok().body(
                new ApiResult<>(SUCCESS, memberService.login(loginReq))
        );
    }


    @ApiOperation(value = "회원 가입", notes="유저를 등록합니다.")
    @PostMapping("/regist")
    public ResponseEntity<ApiResult<Res>> insertMember(@RequestBody MemberCreateReq memberCreateReq){
        return ResponseEntity.ok().body(
                new ApiResult<>(SUCCESS, memberService.insertMember(memberCreateReq))
        );
    }

    @ApiOperation(value = "키워드로 멤버 찾기", notes="멤버 닉네임에 키워드가 포함되어 있으면 검색해 줍니다.")
    @GetMapping("/search/{keyword}")
    public ResponseEntity<ApiResult<?>> searchMember(@PathVariable String keyword){
        return ResponseEntity.ok().body(
                new ApiResult<>(SUCCESS, memberService.findByNicknameKeyword(keyword))
        );
    }
    
    @ApiOperation(value = "멤버 사진 업데이트", notes="멤버 사진주소를 업데이트 합니다.")
    @PatchMapping("/photo")
    public ResponseEntity<ApiResult<Res>> updateMemberPhoto(@RequestBody MemberUpdatePhotoReq memberUpdatePhotoReq){
        return ResponseEntity.ok().body(
                new ApiResult<>(SUCCESS, memberService.updateMemberUrl(memberUpdatePhotoReq))
        );
    }


    @ApiOperation(value = "멤버 닉네임 업데이트", notes="멤버 닉네임을 업데이트 합니다.")
    @PatchMapping("/nickname")
    public ResponseEntity<ApiResult<Res>> updateMemberNickname(@RequestBody MemberUpdateNicknameReq memberUpdateNicknameReq){
        return ResponseEntity.ok().body(
                new ApiResult<>(SUCCESS, memberService.updateMemberNickname(memberUpdateNicknameReq))
        );
    }

    @ApiOperation(value = "프로필 조회", notes="유저 아이디로 유저 정보를 불러옵니다.")
    @GetMapping("/{memberId}")
    public ResponseEntity<ApiResult<Res>> updateMemberNickname(@PathVariable String memberId){
        return ResponseEntity.ok().body(
                new ApiResult<>(SUCCESS, memberService.selectOneMember(memberId))
        );
    }

    @ApiOperation(value = "친구 맺기", notes = "친구 신청을 수락합니다.")
    @PostMapping("/friend")
    public ResponseEntity<ApiResult<Res>> insertMemberFriend(@RequestBody MemberFriendCreateReq memberFriendCreateReq) {

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
}
