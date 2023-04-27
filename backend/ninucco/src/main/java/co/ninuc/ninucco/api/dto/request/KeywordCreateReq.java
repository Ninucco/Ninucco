package co.ninuc.ninucco.api.dto.request;

import co.ninuc.ninucco.db.entity.type.Category;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class KeywordCreateReq {
    Category category;
    String name;
}
