package co.ninuc.ninucco.api.dto.response;


import lombok.AllArgsConstructor;
import lombok.Getter;
import java.util.List;

@Getter
@AllArgsConstructor
public class ItemListRes {
    List<ItemRes> itemRes;
}
