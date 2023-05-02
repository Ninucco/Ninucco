package co.ninuc.ninucco.api.service;

import co.ninuc.ninucco.api.dto.response.BooleanRes;
import co.ninuc.ninucco.api.dto.response.MemberFriendListRes;
import co.ninuc.ninucco.api.dto.response.MemberFriendRes;

public interface MemberFriendService {

    MemberFriendRes insertMemberFriend(String memberId, String friendId);

    BooleanRes selectOneMemberFriend(String memberId, String friendId);

    MemberFriendListRes selectAllMemberFriend(String memberId);

    BooleanRes deleteMemberFriend(String memberId, String friendId);
}
