package co.ninuc.ninucco.api.service;

import co.ninuc.ninucco.api.dto.request.BattleCreateReq;
import co.ninuc.ninucco.api.dto.request.MemberCreateReq;
import co.ninuc.ninucco.api.dto.response.MemberRes;
import co.ninuc.ninucco.db.entity.Battle;
import co.ninuc.ninucco.db.entity.Member;
import co.ninuc.ninucco.db.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService{

    private final MemberRepository memberRepository;

    @Override
    public MemberRes insertUser(MemberCreateReq memberCreateReq) {

        Member member=toEntity(memberCreateReq,memberCreateReq.getId());

        memberRepository.save(member);

        MemberRes memberRes=toDto(member);

        return memberRes;
    }



    Member toEntity(MemberCreateReq memberCreateReq, String id){
        Member member=Member.builder()
                .id(id)
                .url(memberCreateReq.getUrl())
                .nickname(memberCreateReq.getNickname())
                .build();

        return member;
    }

    MemberRes toDto(Member member){
        MemberRes memberRes=MemberRes.builder()
                .url(member.getId())
                .id(member.getId())
                .nickname(member.getNickname())
                .winCount(member.getWinCount())
                .loseCount(member.getLoseCount())
                .point(member.getPoint())
                .rate(member.getRate())
                .build();

        return memberRes;
    }


}
