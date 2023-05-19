package co.ninuc.ninucco.db.repository;

import co.ninuc.ninucco.db.entity.Member;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface MemberRepository extends JpaRepository<Member, String> {
    Boolean existsByNickname(String nickname);
    Optional<Member> findMemberByNickname(String nickname);
    List<Member> findMembersByNicknameContaining(String keyword);
    long count();
    List<Member> findTop100ByOrderByWinCountDesc();
    List<Member> findTop100ByOrderByEloDesc();
    List<Member> findTop100ByOrderByPointDesc();
}
