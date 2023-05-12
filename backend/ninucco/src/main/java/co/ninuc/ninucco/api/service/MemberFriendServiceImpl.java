package co.ninuc.ninucco.api.service;

import co.ninuc.ninucco.api.dto.ErrorRes;
import co.ninuc.ninucco.api.dto.FriendListInfo;
import co.ninuc.ninucco.api.dto.response.MemberFriendListRes;
import co.ninuc.ninucco.api.dto.response.MemberFriendRes;
import co.ninuc.ninucco.common.exception.CustomException;
import co.ninuc.ninucco.common.util.ValidateUtil;
import co.ninuc.ninucco.db.entity.Member;
import co.ninuc.ninucco.db.entity.MemberFriend;
import co.ninuc.ninucco.db.entity.type.MemberFriendStatus;
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
        validateUtil.memberFriendConflictCheckById(memberId, friendId);
        
        Member member = validateUtil.memberValidateById(memberId);
        Member friend = validateUtil.memberValidateById(friendId);
        MemberFriendStatus status = MemberFriendStatus.WAITING;

        if(memberFriendRepository.existsByMemberIdAndFriendId(friendId, memberId)) {
            status = MemberFriendStatus.FRIEND;
            memberFriendRepository.findByMemberIdAndFriendId(friendId, memberId).get().updateStatus(status);
        }

        MemberFriend memberFriend = toEntity(member, friend, status);

        memberFriendRepository.save(memberFriend);

        return toMemberFriendRes(member, friend, status);
    }

    @Override
    public MemberFriendRes selectOneMemberFriend(String memberId, String friendId) {
        Member member = validateUtil.memberValidateById(memberId);
        Member friend = validateUtil.memberValidateById(friendId);

        MemberFriendStatus status;
        Optional<MemberFriend> memberFriend = memberFriendRepository.findByMemberIdAndFriendId(memberId, friendId);
        if(memberFriend.isPresent()) {
            status = memberFriend.get().getStatus();
        }
        else {
            status = MemberFriendStatus.NONE;
        }

        return toMemberFriendRes(member, friend, status);
    }

    @Override
    public MemberFriendListRes selectAllMemberFriend(String memberId, String status) {
        validateUtil.memberValidateById(memberId);
        MemberFriendStatus memberFriendStatus;

        if(status.equals("WAITING")) {
            memberFriendStatus = MemberFriendStatus.WAITING;
        }
        else if(status.equals("FRIEND")) {
            memberFriendStatus = MemberFriendStatus.FRIEND;
        }
        else {
            throw new CustomException(ErrorRes.BAD_REQUEST);
        }

        return new MemberFriendListRes(memberFriendRepository.findAllByMemberIdAndStatus(memberId, memberFriendStatus).stream().map(this::toMemberFriendListRes).collect(Collectors.toList()));
    }

    @Transactional
    @Override
    public MemberFriendRes deleteMemberFriend(String memberId, String friendId) {
        Member member = validateUtil.memberValidateById(memberId);
        Member friend = validateUtil.memberValidateById(friendId);

        if(memberFriendRepository.existsByMemberIdAndFriendId(memberId, friendId))
            memberFriendRepository.deleteMemberFriendByMember_IdAndFriend_Id(memberId, friendId);

        if(memberFriendRepository.existsByMemberIdAndFriendId(friendId, memberId))
            memberFriendRepository.deleteMemberFriendByMember_IdAndFriend_Id(friendId, memberId);


        return toMemberFriendRes(member, friend, MemberFriendStatus.NONE);
    }

    MemberFriend toEntity(Member member, Member friend, MemberFriendStatus status) {
        return MemberFriend.builder()
                .member(member)
                .friend(friend)
                .status(status)
                .build();
    }

    MemberFriendRes toMemberFriendRes(Member member, Member friend, MemberFriendStatus status) {

        return MemberFriendRes.builder()
                .memberId(member.getId())
                .memberNickname(member.getNickname())
                .friendId(friend.getId())
                .friendNickname(friend.getNickname())
                .status(status)
                .build();
    }

    FriendListInfo toMemberFriendListRes(MemberFriend memberFriend) {
        Member friend = validateUtil.memberValidateById(memberFriend.getFriend().getId());

        return FriendListInfo.builder()
                .friendId(friend.getId())
                .profileImage(friend.getUrl())
                .nickname(friend.getNickname())
                .status(memberFriend.getStatus())
                .build();
    }
}
