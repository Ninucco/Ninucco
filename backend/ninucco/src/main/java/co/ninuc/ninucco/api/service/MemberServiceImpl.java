package co.ninuc.ninucco.api.service;

import co.ninuc.ninucco.api.dto.ErrorRes;
import co.ninuc.ninucco.api.dto.request.LoginReq;
import co.ninuc.ninucco.api.dto.request.MemberCreateReq;
import co.ninuc.ninucco.api.dto.request.MemberUpdateNicknameReq;
import co.ninuc.ninucco.api.dto.request.MemberUpdatePhotoReq;
import co.ninuc.ninucco.api.dto.response.*;
import co.ninuc.ninucco.common.exception.CustomException;
import co.ninuc.ninucco.common.util.ValidateUtil;
import co.ninuc.ninucco.db.entity.Item;
import co.ninuc.ninucco.db.entity.Member;
import co.ninuc.ninucco.db.entity.MemberItem;
import co.ninuc.ninucco.db.repository.MemberItemRepository;
import co.ninuc.ninucco.db.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService{

    private final MemberRepository memberRepository;
    private final MemberItemRepository memberItemRepository;
    private final ValidateUtil validateUtil;

    @Transactional
    @Override
    public MemberRes insertMember(MemberCreateReq memberCreateReq) {
        //닉네임 중복검사가 되어 있다고 가정(프론트에서 닉네임 중복검사 후 막기)
        validateUtil.memberConflictCheckById(memberCreateReq.getId());

        return toMemberRes(memberRepository.save(toEntity(memberCreateReq)));
    }

    @Override
    public MemberRes checkMemberNickname(String nickname){

        return validateUtil.memberExistByNickname(nickname) ? toMemberNullRes(false) : toMemberNullRes(true);
    }

    @Transactional
    @Override
    public MemberRes updateMemberUrl(MemberUpdatePhotoReq memberUpdatePhotoReq) {

        Member member= validateUtil.memberValidateById(memberUpdatePhotoReq.getId());

        member.updateUrl(memberUpdatePhotoReq.getUrl());

        return toMemberRes(member);
    }

    @Transactional
    @Override
    public MemberRes updateMemberNickname(MemberUpdateNicknameReq memberUpdateNicknameReq) {
        Member member = validateUtil.memberValidateById(memberUpdateNicknameReq.getId());
        MemberRes memberRes;

        if(!validateUtil.memberExistByNickname(memberUpdateNicknameReq.getNickname())) {
            member.updateNickname(memberUpdateNicknameReq.getNickname());
            memberRes = toMemberRes(member);
        }
        else {
            memberRes = toMemberNullRes(false);
        }

        return memberRes;

    }

    @Override
    public MemberRes selectOneMember(String memberId) {

        return toMemberRes(validateUtil.memberValidateById(memberId));
    }

    @Override
    public MemberRes login(LoginReq loginReq) {

        return toMemberRes(validateUtil.memberValidateById(loginReq.getId()));
    }

    @Override
    public MemberListRes findByNicknameKeyword(String keyword){
        ArrayList<MemberRes> nicknames=new ArrayList<>();
        List<Member> members=memberRepository.findMembersByNicknameContaining(keyword);
        for(Member member:members){
            nicknames.add(toMemberRes(member));
        }

        //        memberListRes.setMemberList(nicknames);
        return new MemberListRes(nicknames);
    }

    @Override
    public ItemListRes findItemByMember(String memberId){
        Member member=memberRepository.findById(memberId)
                .orElseThrow(() -> new CustomException(ErrorRes.NOT_FOUND_MEMBER));

        ArrayList<ItemRes> itemResArrayList=new ArrayList<>();
        List<MemberItem> memberItems=memberItemRepository.findMemberItemByMember(member);
        for(MemberItem memberItem:memberItems){
            ItemRes itemRes=toItemRes(memberItem);
            itemResArrayList.add(itemRes);
        }

        return new ItemListRes(itemResArrayList);
    }


    @Override
    public List<ItemRes> selectAllItemsByMemberId(String memberId) {
        return null;
    }

    @Transactional
    @Override
    public Long insertMemberFriend(String friendId) {
        return null;
    }

    @Override
    public List<MemberRes> selectAllFriendsByMemberId(String memberId) {
        return null;
    }

    @Override
    public Object selectOneFriend(String friendNickName) {
        return null;
    }



    Member toEntity(MemberCreateReq memberCreateReq){
        return Member.builder()
                .id(memberCreateReq.getId())
                .nickname(memberCreateReq.getNickname())
                .url(memberCreateReq.getUrl())
                .build();
    }

    MemberRes toMemberRes(Member member){
        return MemberRes.builder()
                .validate(true)
                .url(member.getUrl())
                .id(member.getId())
                .nickname(member.getNickname())
                .winCount(member.getWinCount())
                .loseCount(member.getLoseCount())
                .point(member.getPoint())
                .elo(member.getElo())
                .build();
    }

    MemberRes toMemberNullRes(boolean validate){
        return MemberRes.builder()
                .validate(validate)
                .url(null)
                .id(null)
                .nickname(null)
                .winCount(null)
                .loseCount(null)
                .point(null)
                .elo(null)
                .build();
    }

    ItemRes toItemRes(MemberItem memberItem){
        Item item=memberItem.getItem();
        Member member=memberItem.getMember();
        return ItemRes.builder()
                .itemId(item.getId())
                .itemName(item.getName())
                .itemUrl(item.getUrl())
                .itemDescription(item.getDescription())
                .amount(memberItem.getAmount())
                .memberId(member.getId())
                .memberNickname(member.getNickname())
                .memberUrl(member.getUrl())
                .build();
    }


}
