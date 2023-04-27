package co.ninuc.ninucco.api.controller;

import co.ninuc.ninucco.api.dto.ApiResult;
import co.ninuc.ninucco.api.dto.request.MemberCreateReq;
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
    private final boolean SUCCESS = true;

    @ApiOperation(value = "회원 가입", notes="유저를 등록합니다.")
    @PostMapping("/regist")
    public ResponseEntity<?> insertMember(MemberCreateReq memberCreateReq){
        return ResponseEntity.ok().body(
                new ApiResult<>(SUCCESS, memberService.insertMember(memberCreateReq))
        );
    }
    @ApiOperation(value = "닉네임 중복검사", notes="닉네임 중복검사")
    @GetMapping("/regist/nickname")
    public ResponseEntity<?> checkMemberNickname(@RequestParam String nickname){
        return ResponseEntity.ok().body(
                new ApiResult<>(SUCCESS, memberService.checkMemberNickname(nickname))
        );
    }
}
