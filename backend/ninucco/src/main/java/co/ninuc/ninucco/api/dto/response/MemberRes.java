package co.ninuc.ninucco.api.dto.response;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MemberRes {
    String id;

    String nickname;

    String url;

    Long winCount;

    Long loseCount;

    Long point;

    Long rate;

    @Builder
    public MemberRes(String id, String nickname,String url, Long winCount, Long loseCount, Long point, Long rate){
        this.id=id;
        this.nickname=nickname;
        this.url=url;
        this.winCount=winCount;
        this.loseCount=loseCount;
        this.point=point;
        this.rate=rate;
    }
}
