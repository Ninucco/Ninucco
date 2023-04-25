package co.ninuc.ninucco.api.service;

import co.ninuc.ninucco.api.dto.request.CommentCreateReq;
import co.ninuc.ninucco.api.dto.response.CommentRes;
import co.ninuc.ninucco.common.exception.NotFoundException;
import co.ninuc.ninucco.db.entity.Comment;

import java.util.List;

public interface CommentService {
    Long insertComment(CommentCreateReq commentCreateReq) throws NotFoundException;

    List<CommentRes> selectAllComment(Long battleId) throws NotFoundException;
}
