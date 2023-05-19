package co.ninuc.ninucco.common.util;

import co.ninuc.ninucco.api.dto.ErrorRes;
import co.ninuc.ninucco.common.exception.CustomException;
import co.ninuc.ninucco.db.entity.Battle;
import co.ninuc.ninucco.db.entity.Member;
import co.ninuc.ninucco.db.repository.BattleRepository;
import co.ninuc.ninucco.db.repository.MemberFriendRepository;
import co.ninuc.ninucco.db.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

@RequiredArgsConstructor
@Component
public class ValidateUtil {

    private final MemberRepository memberRepository;
    private final BattleRepository battleRepository;
    private final MemberFriendRepository memberFriendRepository;

    public Member memberValidateById(String memberId) {
        return memberRepository.findById(memberId).orElseThrow(() -> new CustomException(ErrorRes.NOT_FOUND_MEMBER));
    }

    public void memberConflictCheckById(String memberId) {
        if(memberRepository.existsById(memberId))
            throw new CustomException(ErrorRes.CONFLICT_MEMBER);
    }

    public boolean memberExistByNickname(String nickname) {
        return memberRepository.existsByNickname(nickname);
    }

    public void memberFriendConflictCheckById(String memberId, String friendId) {
        if(memberFriendRepository.existsByMemberIdAndFriendId(memberId, friendId))
            throw new CustomException(ErrorRes.CONFLICT_FRIEND);
    }

    public Battle battleValidateById(Long battleId) {
        return battleRepository.findById(battleId).orElseThrow(() -> new CustomException(ErrorRes.NOT_FOUND_BATTLE));
    }
}
