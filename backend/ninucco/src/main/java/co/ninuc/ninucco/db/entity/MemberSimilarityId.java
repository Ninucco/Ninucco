package co.ninuc.ninucco.db.entity;

import java.io.Serializable;

public class MemberSimilarityId implements Serializable {
    String member;
    Long similarity;
    @Override
    public boolean equals(Object o){
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        MemberSimilarityId that = (MemberSimilarityId) o;

        if (!member.equals(that.member)) return false;
        return similarity.equals(that.similarity);
    }
    @Override
    public int hashCode() {
        int result = member.hashCode();
        result = 31 * result + similarity.hashCode();
        return result;
    }
}
