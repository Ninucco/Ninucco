package co.ninuc.ninucco.api.service;

import co.ninuc.ninucco.api.dto.ErrorRes;
import co.ninuc.ninucco.api.dto.request.MemberCreateReq;
import co.ninuc.ninucco.api.dto.response.ItemRes;
import co.ninuc.ninucco.api.dto.response.MemberRes;
import co.ninuc.ninucco.common.exception.CustomException;
import co.ninuc.ninucco.db.entity.Member;
import co.ninuc.ninucco.db.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService{

    private final MemberRepository memberRepository;

    @Transactional
    @Override
    public String insertMember(MemberCreateReq memberCreateReq) {
        //닉네임 중복검사가 되어 있다고 가정(프론트에서 닉네임 중복검사 후 막기)
        if(memberRepository.existsById(memberCreateReq.getId()))
            throw new CustomException(ErrorRes.CONFLICT_MEMBER);
        return memberRepository.save(toEntity(memberCreateReq)).getId();
    }

    public Boolean checkMemberNickname(String nickName){
        if(memberRepository.existsByNickname(nickName))
            throw new CustomException(ErrorRes.CONFLICT_NICKNAME);
        return true;
    }

    @Override
    public Boolean checkMemberEmail(String email) {
        return null;
    }

    @Transactional
    @Override
    public Long updateMemberUrl(String url) {
        return null;
    }

    @Transactional
    @Override
    public Long updateMemberNickname(String nickName) {
        return null;
    }

    @Override
    public MemberRes selectOneMember(String memberId) {
        return null;
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
                .rate(member.getRate())
                .build();
    }


}
