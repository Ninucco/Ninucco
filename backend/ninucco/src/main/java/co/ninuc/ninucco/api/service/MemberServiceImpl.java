package co.ninuc.ninucco.api.service;

import co.ninuc.ninucco.api.dto.ErrorRes;
import co.ninuc.ninucco.api.dto.request.LoginReq;
import co.ninuc.ninucco.api.dto.request.MemberCreateReq;
import co.ninuc.ninucco.api.dto.request.MemberUpdateNicknameReq;
import co.ninuc.ninucco.api.dto.request.MemberUpdatePhotoReq;
import co.ninuc.ninucco.api.dto.response.*;
import co.ninuc.ninucco.common.exception.CustomException;
import co.ninuc.ninucco.common.util.ValidateUtil;
import co.ninuc.ninucco.db.entity.Battle;
import co.ninuc.ninucco.db.entity.Item;
import co.ninuc.ninucco.db.entity.Member;
import co.ninuc.ninucco.db.entity.MemberItem;
import co.ninuc.ninucco.db.entity.type.BattleStatus;
import co.ninuc.ninucco.db.repository.BattleRepository;
import co.ninuc.ninucco.db.repository.MemberItemRepository;
import co.ninuc.ninucco.db.repository.MemberRepository;
import co.ninuc.ninucco.db.repository.SimilarityResultRepository;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.ObjectMetadata;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService{

    private final MemberRepository memberRepository;
    private final MemberItemRepository memberItemRepository;
    private final ValidateUtil validateUtil;
    private final AmazonS3Client amazonS3Client;
    private final SimilarityResultRepository similarityResultRepository;

    @Value("${cloud.aws.s3.bucket}")
    private String bucket;


    static String[] adverbs = {
            "가볍게", "각별히", "거칠게", "광폭하게", "그저",
            "그쳐", "극히", "급히", "꼼꼼히", "나쁘게",
            "난폭하게", "내쉬게", "내심술술", "너그럽게", "노골적으로",
            "놀랍게", "다급하게", "대충", "독단적으로", "동그랗게",
            "동적으로", "따로", "따스하게", "따질따질", "땀내나게",
            "똑바로", "뚜렷하게", "마구", "만반잘부하게", "만만하게",
            "매끄럽게", "멀리", "몽글몽글", "무심코", "바쁘게",
            "반갑게", "밝게", "번거롭게", "변덕스럽게", "변함없이",
            "부드럽게", "붉게", "불안하게", "비슷하게", "빠르게",
            "사나운 듯이", "살벌하게", "상세히", "생각보다", "설명적으로",
            "수그러들게", "슬그머니", "시끄럽게", "실망스럽게", "심술궂게",
            "아득히", "아끼지 않고", "안심하게", "앞뒤가 바뀌어", "언제나",
            "어느새", "어디서나", "어지럽게", "엉뚱하게", "여유롭게",
            "연속적으로", "열심히", "예민하게", "오래", "올곧게",
            "완전히", "외로이", "우렁차게", "의외로", "이상하게",
            "일부러", "잔잔하게", "잘", "재빠르게", "적극적으로",
            "저돌적으로", "전반적으로", "정성스럽게", "조용하게", "종종"
    };

    static String[] words = {
            "뛰어노는", "기억하는", "시도하는", "놀라는", "청소하는",
            "떠오르는", "달리는", "따라하는", "매달리는", "떠나는",
            "끓어오르는", "기대는", "보여주는", "걸어가는", "누려보는",
            "다가가는", "빠져나가는", "도와주는", "아쉬워하는", "드러내는",
            "마시는", "마주하는", "몰입하는", "미치는", "보유한",
            "부족한", "불러일으키는", "빛나는", "사라지는", "살아있는",
            "살펴보는", "새롭게 하는", "선사하는", "성장하는", "소리치는",
            "쏟아지는", "쓰이는", "알아가는", "알아보는", "언급하는",
            "열심히 하는", "오르는", "올려놓는", "요청하는", "외치는",
            "울리는", "움직이는", "이루어지는", "인기 있는", "자리잡은",
            "자세히 하는", "잡아당기는", "접하고 있는", "조언하는", "주체하는",
            "주변하는", "줄어드는", "진행하는", "참여하는", "채워지는",
            "초대하는", "추천하는", "치열한", "친숙한", "탐구하는",
            "탐색하는", "통제하는", "펼쳐지는", "표현하는", "하루하루 하는",
            "한층 높아지는", "해결하는", "확인하는"
    };

    static String[] animals = {
            "고양이", "강아지", "토끼", "다람쥐", "너구리",
            "팬더", "코알라", "해달이", "랫서팬더", "미어캣",
            "캥거루", "펭귄", "하이에나", "바다코끼리", "북극곰",
            "사막여우", "늑대", "호랑이", "코뿔소", "하마",
            "돌고래", "오랑우탄", "기린", "낙타", "카멜레온",
            "파랑새", "앵무새", "비둘기", "독수리", "부엉이",
            "벌새", "사자", "코끼리", "원숭이", "치타",
            "기러기", "비버", "비버랫서팬더", "물개", "바다표범",
            "갈매기", "오리", "말", "사슴", "수달",
            "해마", "오소리", "뱀", "악어", "거북이",
            "닭", "늑대거북", "도마뱀", "이구아나", "알파카",
            "쥐", "햄스터", "고슴도치", "바다거북", "바나나멧돼지",
            "바다토끼", "비버술렁", "바다코뿔소", "사막고양이", "코끼리쥐",
            "코알라쥐", "물수리", "산호", "돌고래돌고래", "아기돼지",
    };
    private final BattleRepository battleRepository;

    @Override
    public MemberCheckRes checkMember(LoginReq loginReq){
        MemberCheckRes memberCheckRes;
        Member member=memberRepository.findById(loginReq.getId()).orElse(null);
        if(member==null){
            return memberCheckRes=MemberCheckRes.builder().check(false).build();
        }
        else{
            return memberCheckRes=MemberCheckRes.builder().check(true).build();
        }

    }

    @Transactional
    @Override
    public MemberRes insertMember(MemberCreateReq memberCreateReq) {
        StringBuilder randomNickname=new StringBuilder();
        randomNickname.append(adverbs[(int)(Math.random()*70)]).append(' ')
                .append(words[(int)(Math.random()*70)]).append(' ')
                .append(animals[(int)(Math.random()*70)]).append(' ')
                .append(memberRepository.count());
        //랜덤 닉네임 생성 후 혹시 있을 중복 방지를 위해 memberRepository 자료 총 개수를 뒤에 붙임

        memberCreateReq.setNickname(randomNickname.toString());
        
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

        byte[] imgByteArray;
        try{
            imgByteArray = memberUpdatePhotoReq.getImg().getBytes();
        }catch(IOException e){
            throw new CustomException(ErrorRes.INTERNAL_SERVER_ERROR);
        }
        ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(imgByteArray);
        ObjectMetadata objectMetadata = new ObjectMetadata();
        objectMetadata.setContentLength(byteArrayInputStream.available());
        String fileName = UUID.nameUUIDFromBytes(imgByteArray)+".png";
        amazonS3Client.putObject(
                bucket,
                fileName,
                byteArrayInputStream,
                objectMetadata
        );

        Member member= validateUtil.memberValidateById(memberUpdatePhotoReq.getId());

        member.updateUrl(amazonS3Client.getResourceUrl(bucket,fileName));

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
    public MemberAllRes selectOneMember(String memberId) {

        MemberRes user=toMemberRes(validateUtil.memberValidateById(memberId));

        return MemberAllRes.builder()
                .user(user)
                .scanResults(similarityResultRepository.findAllByMemberId(memberId))
                .items(null)
                .curBattles(battleRepository.findAllByMemberIdAndStatus(memberId, BattleStatus.PROCEEDING).stream()
                        .map((this::toBattleRes)).collect(Collectors.toList()))
                .prevBattles(battleRepository.findAllByMemberIdAndStatus(memberId, BattleStatus.TERMINATED).stream()
                        .map((this::toBattleRes)).collect(Collectors.toList()))
                .build();
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

    // TODO: duplicate code
    BattleRes toBattleRes(Battle battle){
        Member applicant = validateUtil.memberValidateById(battle.getApplicant().getId());
        Member opponent = validateUtil.memberValidateById(battle.getOpponent().getId());
        return BattleRes.builder()
                .battleId(battle.getId())
                .applicantName(applicant.getNickname())
                .opponentName(opponent.getNickname())
                .title(battle.getTitle())
                .applicantUrl(battle.getApplicantUrl())
                .opponentUrl(battle.getOpponentUrl())
                .applicantOdds(battle.getApplicantOdds())
                .opponentOdds(battle.getOpponentOdds())
                .finishTime(battle.getFinishAt())
                .build();
    }
}
