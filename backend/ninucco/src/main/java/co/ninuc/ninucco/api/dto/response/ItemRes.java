package co.ninuc.ninucco.api.dto.response;

import lombok.Getter;
import lombok.Builder;

@Builder
@Getter
public class ItemRes {
    String memberId;
    String memberNickname;
    Long itemId;
    String itemName;
    Long amount;
    String itemUrl;
    String memberUrl;
    String itemDescription;

    @Builder
    public ItemRes(String memberId, String memberNickname, Long itemId, String itemName, Long amount, String itemUrl, String memberUrl, String itemDescription){
        this.memberId=memberId;
        this.memberNickname=memberNickname;
        this.itemId=itemId;
        this.itemName=itemName;
        this.amount=amount;
        this.itemUrl=itemUrl;
        this.memberUrl=memberUrl;
        this.itemDescription=itemDescription;
    }
}
