package co.ninuc.ninucco.api.service;

import co.ninuc.ninucco.api.dto.response.MemberFriendListRes;
import co.ninuc.ninucco.api.dto.response.MemberFriendRes;
import co.ninuc.ninucco.db.entity.type.MemberFriendStatus;

public interface MemberFriendService {

    MemberFriendRes insertMemberFriend(String memberId, String friendId);

    MemberFriendListRes selectAllMemberFriend(String memberId, MemberFriendStatus status);
    MemberFriendListRes selectAllReceivedFriend(String memberId);

    MemberFriendRes selectOneMemberFriend(String memberId, String friendId);

    MemberFriendRes deleteMemberFriend(String memberId, String friendId);
}
