package co.ninuc.ninucco.api.dto.request;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class CommentCreateReq {
    Long battleId;
    String content;
}
