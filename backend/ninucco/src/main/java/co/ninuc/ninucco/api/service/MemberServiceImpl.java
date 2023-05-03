package co.ninuc.ninucco.api.service;

import co.ninuc.ninucco.api.dto.ErrorRes;
import co.ninuc.ninucco.api.dto.request.LoginReq;
import co.ninuc.ninucco.api.dto.request.MemberCreateReq;
import co.ninuc.ninucco.api.dto.request.MemberUpdateNicknameReq;
import co.ninuc.ninucco.api.dto.request.MemberUpdatePhotoReq;
import co.ninuc.ninucco.api.dto.response.*;
import co.ninuc.ninucco.common.exception.CustomException;
import co.ninuc.ninucco.db.entity.Member;
import co.ninuc.ninucco.db.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService{

    private final MemberRepository memberRepository;

    @Transactional
    @Override
    public MemberIdRes insertMember(MemberCreateReq memberCreateReq) {
        //닉네임 중복검사가 되어 있다고 가정(프론트에서 닉네임 중복검사 후 막기)
        if(memberRepository.existsById(memberCreateReq.getId()))
            throw new CustomException(ErrorRes.CONFLICT_MEMBER);
        return new MemberIdRes(memberRepository.save(toEntity(memberCreateReq)).getId());
    }

    public BooleanRes checkMemberNickname(String nickName){
        return memberRepository.existsByNickname(nickName) ? new BooleanRes(false) : new BooleanRes(true);
    }

    @Transactional
    @Override
    public BooleanRes updateMemberUrl(MemberUpdatePhotoReq memberUpdatePhotoReq) {

        Member member=memberRepository.findById(memberUpdatePhotoReq.getId())
                .orElseThrow(() -> new CustomException(ErrorRes.NOT_FOUND_MEMBER));

        member.updateUrl(memberUpdatePhotoReq.getUrl());

        return new BooleanRes(true);
    }

    @Transactional
    @Override
    public BooleanRes updateMemberNickname(MemberUpdateNicknameReq memberUpdateNicknameReq) {
        Member member=memberRepository.findById(memberUpdateNicknameReq.getId())
                .orElseThrow(() -> new CustomException(ErrorRes.NOT_FOUND_MEMBER));

        if(checkMemberNickname(memberUpdateNicknameReq.getNickname()).isSuccess()){
            member.updateNickname(memberUpdateNicknameReq.getNickname());
            return new BooleanRes(true);
        }

        return new BooleanRes(false);

    }

    @Override
    public MemberRes selectOneMember(String memberId) {
        Member member=memberRepository.findById(memberId)
                .orElseThrow(() -> new CustomException(ErrorRes.NOT_FOUND_MEMBER));

        return toDto(member);
    }

    @Override
    public MemberRes login(LoginReq loginReq) {
        Member member=memberRepository.findById(loginReq.getId())
                .orElseThrow(() -> new CustomException(ErrorRes.NOT_FOUND_MEMBER));

        return toDto(member);
    }

    @Override
    public MemberListRes findByNicknameKeyword(String keyword){
        ArrayList<MemberRes> nicknames=new ArrayList<>();
        List<Member> members=memberRepository.findMembersByNicknameContaining(keyword);
        for(Member member:members){
            nicknames.add(toDto(member));
        }

        MemberListRes memberListRes=new MemberListRes(nicknames);

        return memberListRes;
    }


    @Override
    public List<ItemRes> selectAllItemsByMemberId(String memberId) {
        return null;
    }

    @Transactional
    @Override
    public Long insertMemberFriend(String friendId) {
        return null;
    }

    @Override
    public List<MemberRes> selectAllFriendsByMemberId(String memberId) {
        return null;
    }

    @Override
    public Object selectOneFriend(String friendNickName) {
        return null;
    }



    Member toEntity(MemberCreateReq memberCreateReq){
        return Member.builder()
                .id(memberCreateReq.getId())
                .nickname(memberCreateReq.getNickname())
                .url(memberCreateReq.getUrl())
                .build();
    }

    MemberRes toDto(Member member){
        return MemberRes.builder()
                .url(member.getId())
                .id(member.getId())
                .nickname(member.getNickname())
                .winCount(member.getWinCount())
                .loseCount(member.getLoseCount())
                .point(member.getPoint())
                .elo(member.getElo())
                .build();
    }


}
