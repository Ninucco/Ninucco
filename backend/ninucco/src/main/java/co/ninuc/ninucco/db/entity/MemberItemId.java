package co.ninuc.ninucco.db.entity;

import java.io.Serializable;
public class MemberItemId implements Serializable {
    String member;
    Long item;
    @Override
    public boolean equals(Object o){
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        MemberItemId that = (MemberItemId) o;

        if (!member.equals(that.member)) return false;
        return item.equals(that.item);
    }
    @Override
    public int hashCode() {
        int result = member.hashCode();
        result = 31 * result + item.hashCode();
        return result;
    }
}