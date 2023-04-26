package co.ninuc.ninucco.api.dto.request;

//import lombok.Builder;
//import lombok.Setter;
import lombok.Getter;

@Getter
//@Setter
public class MemberCreateReq {
    String id;

    String nickname;

    String url;

//    @Builder
//    public MemberCreateReq(String id, String nickname, String url){
//        this.id=id;
//        this.nickname=nickname;
//        this.url=url;
//    }
}
