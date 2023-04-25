package co.ninuc.ninucco.db.repository;

import co.ninuc.ninucco.db.entity.Member;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface MemberRepository extends JpaRepository<Member, String> {
    Optional<Member> findMemberById(String Id);
    Optional<Member> findMemberByNickname(String nickname);
}
