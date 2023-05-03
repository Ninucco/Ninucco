package co.ninuc.ninucco.api.dto.response;

import co.ninuc.ninucco.api.dto.Res;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

import java.time.LocalDateTime;

@Getter
@AllArgsConstructor
@Builder
public class CommentRes implements Res {
    Long commentId;
    String profileImage;
    String nickname;
    String content;
    LocalDateTime createdAt;
}
