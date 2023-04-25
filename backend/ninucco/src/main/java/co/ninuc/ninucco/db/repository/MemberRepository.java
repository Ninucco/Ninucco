package co.ninuc.ninucco.db.repository;

import co.ninuc.ninucco.db.entity.Member;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MemberRepository extends JpaRepository<Member, String> {

}
