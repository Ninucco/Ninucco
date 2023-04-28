package co.ninuc.ninucco.api.dto.request;

import co.ninuc.ninucco.db.entity.type.Category;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class KeywordCreateReq {
    Category category;
    String name;
}
