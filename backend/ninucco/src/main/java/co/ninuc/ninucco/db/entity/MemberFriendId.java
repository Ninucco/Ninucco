package co.ninuc.ninucco.db.entity;

import java.io.Serializable;

public class MemberFriendId implements Serializable {
    String member;
    String friend;
    @Override
    public boolean equals(Object o){
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        MemberFriendId that = (MemberFriendId) o;

        if (!member.equals(that.member)) return false;
        return friend.equals(that.friend);
    }
    @Override
    public int hashCode() {
        int result = member.hashCode();
        result = 31 * result + friend.hashCode();
        return result;
    }
}
