package co.ninuc.ninucco.db.repository;

import co.ninuc.ninucco.db.entity.MemberFriend;
import co.ninuc.ninucco.db.entity.type.MemberFriendStatus;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface MemberFriendRepository extends JpaRepository<MemberFriend, Long> {

    Optional<MemberFriend> findByMemberIdAndFriendId(String memberId, String friendId);

    List<MemberFriend> findAllByMemberIdAndStatus(String memberId, MemberFriendStatus status);
    Boolean existsByMemberIdAndFriendId(String memberId, String friendId);

    void deleteMemberFriendByMember_IdAndFriend_Id(String memberId, String friendId);

}
