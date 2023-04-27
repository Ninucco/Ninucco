package co.ninuc.ninucco.api.service;

import co.ninuc.ninucco.api.dto.response.BooleanRes;
import co.ninuc.ninucco.api.dto.response.MemberFriendListRes;
import co.ninuc.ninucco.api.dto.response.MemberFriendRes;

import java.util.List;

public interface MemberFriendService {

    MemberFriendRes insertMemberFriend(String memberId, String friendId);

    BooleanRes selectOneMemberFriend(String memberId, String friendNickname);

    List<MemberFriendListRes> selectAllMemberFriend(String memberId);
}
