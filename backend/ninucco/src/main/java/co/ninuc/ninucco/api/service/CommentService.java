package co.ninuc.ninucco.api.service;

import co.ninuc.ninucco.api.dto.request.CommentCreateReq;
import co.ninuc.ninucco.api.dto.response.CommentRes;

import java.util.List;

public interface CommentService {
    Long insertComment(CommentCreateReq commentCreateReq);

    List<CommentRes> selectAllComment(Long battleId);
}
