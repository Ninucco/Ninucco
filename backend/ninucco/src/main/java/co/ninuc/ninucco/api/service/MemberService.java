package co.ninuc.ninucco.api.service;

import co.ninuc.ninucco.api.dto.request.LoginReq;
import co.ninuc.ninucco.api.dto.request.MemberCreateReq;
import co.ninuc.ninucco.api.dto.request.MemberUpdateNicknameReq;
import co.ninuc.ninucco.api.dto.request.MemberUpdatePhotoReq;
import co.ninuc.ninucco.api.dto.response.*;

import java.util.List;

public interface MemberService {
    MemberRes insertMember(MemberCreateReq memberCreateReq);
    MemberRes checkMemberNickname(String nickname);

    MemberRes updateMemberUrl(MemberUpdatePhotoReq memberUpdatePhotoReq);
    MemberRes updateMemberNickname(MemberUpdateNicknameReq memberUpdateNicknameReq);
    MemberRes selectOneMember(String memberId);
    List<ItemRes> selectAllItemsByMemberId(String memberId);
    Long insertMemberFriend(String friendId);
    List<MemberRes> selectAllFriendsByMemberId(String memberId);
    Object selectOneFriend(String friendNickName);
    MemberListRes findByNicknameKeyword(String keyword);

    MemberRes login(LoginReq loginReq);

    ItemListRes findItemByMember(String memberId);
}
