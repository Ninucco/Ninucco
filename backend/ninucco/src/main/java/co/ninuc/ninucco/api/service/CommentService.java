package co.ninuc.ninucco.api.service;

import co.ninuc.ninucco.api.dto.request.CommentCreateReq;
import co.ninuc.ninucco.api.dto.response.CommentListRes;
import co.ninuc.ninucco.api.dto.response.CommentRes;

public interface CommentService {
    CommentRes insertComment(String memberId, CommentCreateReq commentCreateReq);

    CommentListRes selectAllComment(Long battleId);
}
