package co.ninuc.ninucco.db.repository;

import co.ninuc.ninucco.db.entity.MemberFriend;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface MemberFriendRepository extends JpaRepository<MemberFriend, Long> {

    Optional<MemberFriend> findMemberFriendByMember_IdAndFriend_Id(String memberId, String friendId);

    List<MemberFriend> findAllByMember_Id(String memberId);
}
