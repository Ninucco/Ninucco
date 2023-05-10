package co.ninuc.ninucco.api.dto.response;

import co.ninuc.ninucco.api.dto.Res;
import lombok.Builder;
import lombok.Getter;

@Getter
public class MemberCheckRes implements Res {
    Boolean check;

    @Builder
    public MemberCheckRes(Boolean check){
        this.check=check;
    }
}
