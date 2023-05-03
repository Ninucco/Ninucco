package co.ninuc.ninucco.api.service;

import co.ninuc.ninucco.api.dto.request.LoginReq;
import co.ninuc.ninucco.api.dto.request.MemberCreateReq;
import co.ninuc.ninucco.api.dto.request.MemberUpdateNicknameReq;
import co.ninuc.ninucco.api.dto.request.MemberUpdatePhotoReq;
import co.ninuc.ninucco.api.dto.response.BooleanRes;
import co.ninuc.ninucco.api.dto.response.ItemRes;
import co.ninuc.ninucco.api.dto.response.MemberIdRes;
import co.ninuc.ninucco.api.dto.response.MemberRes;

import java.util.List;

public interface MemberService {
    MemberIdRes insertMember(MemberCreateReq memberCreateReq);
    BooleanRes checkMemberNickname(String nickName);

    BooleanRes updateMemberUrl(MemberUpdatePhotoReq memberUpdatePhotoReq);
    BooleanRes updateMemberNickname(MemberUpdateNicknameReq memberUpdateNicknameReq);
    MemberRes selectOneMember(String memberId);
    List<ItemRes> selectAllItemsByMemberId(String memberId);
    Long insertMemberFriend(String friendId);
    List<MemberRes> selectAllFriendsByMemberId(String memberId);
    Object selectOneFriend(String friendNickName);
    List<MemberRes> findByNicknameKeyword(String keyword);

    MemberRes login(LoginReq loginReq);
}
