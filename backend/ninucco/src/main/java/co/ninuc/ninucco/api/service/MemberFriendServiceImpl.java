package co.ninuc.ninucco.api.service;

import co.ninuc.ninucco.api.dto.ErrorRes;
import co.ninuc.ninucco.api.dto.FriendListInfo;
import co.ninuc.ninucco.api.dto.response.MemberFriendListRes;
import co.ninuc.ninucco.api.dto.response.MemberFriendRes;
import co.ninuc.ninucco.common.exception.CustomException;
import co.ninuc.ninucco.common.util.ValidateUtil;
import co.ninuc.ninucco.db.entity.Member;
import co.ninuc.ninucco.db.entity.MemberFriend;
import co.ninuc.ninucco.db.repository.MemberFriendRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.Optional;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class MemberFriendServiceImpl implements MemberFriendService{
    private final MemberFriendRepository memberFriendRepository;
    private final ValidateUtil validateUtil;

    @Transactional
    @Override
    public MemberFriendRes insertMemberFriend(String memberId, String friendId) {
        log.info("memberId : {}, friendId : {}", memberId, friendId);
        
        Member member = validateUtil.memberValidateById(memberId);
        Member friend = validateUtil.memberValidateById(friendId);

        if(memberFriendRepository.existsMemberFriendByMember_IdAndFriend_Id(memberId, friendId)) {
            throw new CustomException(ErrorRes.CONFLICT_FRIEND);
        }

        MemberFriend memberFriend = toEntity(member, friend);
        MemberFriend friendMember = toEntity(friend, member);

        memberFriendRepository.save(memberFriend);
        memberFriendRepository.save(friendMember);

        return toMemberFriendRes(true, memberFriend);
    }

    @Override
    public MemberFriendRes selectOneMemberFriend(String memberId, String friendId) {
        validateUtil.memberValidateById(memberId);
        validateUtil.memberValidateById(friendId);

        MemberFriendRes memberFriendRes;
        Optional<MemberFriend> memberFriend = memberFriendRepository.findMemberFriendByMember_IdAndFriend_Id(memberId, friendId);
        if(memberFriend.isPresent()) {
            memberFriendRes = toMemberFriendRes(true, memberFriend.get());
        }
        else {
            memberFriendRes = toMemberFriendRes(false, new MemberFriend());
        }

        return memberFriendRes;
    }

    @Override
    public MemberFriendListRes selectAllMemberFriend(String memberId) {
        validateUtil.memberValidateById(memberId);

        return new MemberFriendListRes(memberFriendRepository.findAllByMember_Id(memberId).stream().map(this::toMemberFriendListRes).collect(Collectors.toList()));
    }

    @Transactional
    @Override
    public MemberFriendRes deleteMemberFriend(String memberId, String friendId) {
        validateUtil.memberValidateById(memberId);
        validateUtil.memberValidateById(friendId);

        if(memberFriendRepository.existsMemberFriendByMember_IdAndFriend_Id(memberId, friendId)
                && memberFriendRepository.existsMemberFriendByMember_IdAndFriend_Id(friendId, memberId)) {
            memberFriendRepository.deleteMemberFriendByMember_IdAndFriend_Id(memberId, friendId);
            memberFriendRepository.deleteMemberFriendByMember_IdAndFriend_Id(friendId, memberId);
        }
        else {
            throw new CustomException(ErrorRes.NOT_FOUND_MEMBER_FRIEND);
        }

        return toMemberFriendRes(true, new MemberFriend());
    }

    MemberFriend toEntity(Member member, Member friend) {
        return MemberFriend.builder()
                .member(member)
                .friend(friend)
                .build();
    }

    MemberFriendRes toMemberFriendRes(boolean isExist, MemberFriend memberFriend) {
        return MemberFriendRes.builder()
                .isExist(isExist)
                .memberNickname(memberFriend.getMember().getNickname())
                .friendNickname(memberFriend.getFriend().getNickname())
                .build();
    }

    FriendListInfo toMemberFriendListRes(MemberFriend memberFriend) {
        Member friend = validateUtil.memberValidateById(memberFriend.getFriend().getId());

        return FriendListInfo.builder()
                .profileImage(friend.getUrl())
                .nickname(friend.getNickname())
                .build();
    }
}
