package co.ninuc.ninucco.api.service;

import co.ninuc.ninucco.api.dto.request.MemberCreateReq;
import co.ninuc.ninucco.api.dto.response.ItemRes;
import co.ninuc.ninucco.api.dto.response.MemberRes;

import java.util.List;

public interface MemberService {
    String insertMember(MemberCreateReq memberCreateReq);
    Boolean checkMemberNickname(String nickName);
    Boolean checkMemberEmail(String email);

    Long updateMemberUrl(String url);
    Long updateMemberNickname(String nickName);
    MemberRes selectOneMember(String memberId);
    List<ItemRes> selectAllItemsByMemberId(String memberId);
    Long insertMemberFriend(String friendId);
    List<MemberRes> selectAllFriendsByMemberId(String memberId);
    Object selectOneFriend(String friendNickName);
}
