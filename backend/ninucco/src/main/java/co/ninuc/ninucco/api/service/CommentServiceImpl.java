package co.ninuc.ninucco.api.service;

import co.ninuc.ninucco.api.dto.request.CommentCreateReq;
import co.ninuc.ninucco.api.dto.response.CommentRes;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentServiceImpl implements CommentService{
    @Override
    public Long insertComment(CommentCreateReq commentCreateReq) {
        return null;
    }

    @Override
    public List<CommentRes> selectAllComment(Long battleId) {
        return null;
    }
}
