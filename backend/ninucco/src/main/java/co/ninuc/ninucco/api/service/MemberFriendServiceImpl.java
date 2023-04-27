package co.ninuc.ninucco.api.service;

import co.ninuc.ninucco.api.dto.ErrorRes;
import co.ninuc.ninucco.api.dto.response.BooleanRes;
import co.ninuc.ninucco.api.dto.response.MemberFriendListRes;
import co.ninuc.ninucco.api.dto.response.MemberFriendRes;
import co.ninuc.ninucco.common.exception.CustomException;
import co.ninuc.ninucco.db.entity.Member;
import co.ninuc.ninucco.db.entity.MemberFriend;
import co.ninuc.ninucco.db.repository.MemberFriendRepository;
import co.ninuc.ninucco.db.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class MemberFriendServiceImpl implements MemberFriendService{

    private final MemberRepository memberRepository;
    private final MemberFriendRepository memberFriendRepository;

    @Transactional
    @Override
    public MemberFriendRes insertMemberFriend(String memberId, String friendId) {
        log.info("memberId : {}, friendId : {}", memberId, friendId);

        //TODO 중복등록 방지
        Member member = memberFriendAuthorization(memberId);
        Member friend = memberFriendAuthorization(friendId);

        MemberFriend memberFriend = toEntity(member, friend);
        MemberFriend friendMember = toEntity(friend, member);

        memberFriendRepository.save(memberFriend);
        memberFriendRepository.save(friendMember);

        return toMemberFriendRes(memberFriend);
    }

    @Override
    public BooleanRes selectOneMemberFriend(String memberId, String friendId) {
        memberFriendAuthorization(memberId);
        memberFriendAuthorization(friendId);

        return toBooleanRes(memberFriendRepository.findMemberFriendByMember_IdAndFriend_Id(memberId, friendId).isPresent());
    }

    @Override
    public List<MemberFriendListRes> selectAllMemberFriend(String memberId) {
        memberFriendAuthorization(memberId);

        return memberFriendRepository.findAllByMember_Id(memberId).stream().map(this::toMemberFriendListRes).collect(Collectors.toList());
    }

    public Member memberFriendAuthorization(String memberId) {
        log.info("memberFriendAuthorization : {}", memberId);
        return memberRepository.findById(memberId).orElseThrow(() -> new CustomException(ErrorRes.NOT_FOUND_MEMBER));
    }

    MemberFriend toEntity(Member member, Member friend) {
        return MemberFriend.builder()
                .member(member)
                .friend(friend)
                .build();
    }

    MemberFriendRes toMemberFriendRes(MemberFriend memberFriend) {
        return MemberFriendRes.builder()
                .memberNickname(memberFriend.getMember().getNickname())
                .friendNickname(memberFriend.getFriend().getNickname())
                .build();
    }

    MemberFriendListRes toMemberFriendListRes(MemberFriend memberFriend) {
        Member friend = memberRepository.findById(memberFriend.getFriend().getId()).orElseThrow(() -> new CustomException(ErrorRes.NOT_FOUND_MEMBER));
        return MemberFriendListRes.builder()
                .profileImage(friend.getUrl())
                .nickname(friend.getNickname())
                .build();
    }

    BooleanRes toBooleanRes(boolean success) {
        return BooleanRes.builder()
                .success(success)
                .build();
    }
}
