package co.ninuc.ninucco.db.repository;

import co.ninuc.ninucco.db.entity.Member;
import co.ninuc.ninucco.db.entity.MemberItem;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface MemberItemRepository extends JpaRepository<MemberItem, Long> {
    List<MemberItem> findMemberItemByMember(Member member);
}
