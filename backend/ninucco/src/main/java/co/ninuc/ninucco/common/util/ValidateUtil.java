package co.ninuc.ninucco.common.util;

import co.ninuc.ninucco.api.dto.ErrorRes;
import co.ninuc.ninucco.common.exception.CustomException;
import co.ninuc.ninucco.db.entity.Battle;
import co.ninuc.ninucco.db.entity.Member;
import co.ninuc.ninucco.db.repository.BattleRepository;
import co.ninuc.ninucco.db.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

@Slf4j
@RequiredArgsConstructor
@Component
public class ValidateUtil {

    private final MemberRepository memberRepository;
    private final BattleRepository battleRepository;

    public Member memberValidateById(String memberId) {
        log.info("memberValidateById : {}", memberId);
        return memberRepository.findById(memberId).orElseThrow(() -> new CustomException(ErrorRes.NOT_FOUND_MEMBER));
    }

    public Battle battleValidateById(Long battleId) {
        log.info("battleValidateById : {}", battleId);
        return battleRepository.findById(battleId).orElseThrow(() -> new CustomException(ErrorRes.NOT_FOUND_BATTLE));
    }
}
