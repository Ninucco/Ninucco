package co.ninuc.ninucco.api.service;

import co.ninuc.ninucco.api.dto.request.CommentCreateReq;
import co.ninuc.ninucco.api.dto.response.CommentListRes;
import co.ninuc.ninucco.api.dto.response.CommentRes;
import co.ninuc.ninucco.common.util.ValidateUtil;
import co.ninuc.ninucco.db.entity.Battle;
import co.ninuc.ninucco.db.entity.Comment;
import co.ninuc.ninucco.db.entity.Member;
import co.ninuc.ninucco.db.repository.CommentRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class CommentServiceImpl implements CommentService{

    private final CommentRepository commentRepository;
    private final ValidateUtil validateUtil;

    @Transactional
    @Override
    public CommentRes insertComment(String memberId, CommentCreateReq commentCreateReq) {

        Member member = validateUtil.memberValidateById(memberId);
        Battle battle = validateUtil.battleValidateById(commentCreateReq.getBattleId());

        Comment comment = toEntity(member, battle, commentCreateReq.getContent());
        commentRepository.save(comment);

        return toCommentRes(comment);
    }

    @Override
    public CommentListRes selectAllComment(Long battleId) {
        return new CommentListRes(commentRepository.findAllByBattleIdOrderByCreatedAtDesc(battleId).stream().map(this::toCommentRes).collect(Collectors.toList()));
    }

    Comment toEntity(Member member, Battle battle, String content) {
        return Comment.builder()
                .member(member)
                .battle(battle)
                .content(content)
                .build();
    }

    CommentRes toCommentRes(Comment comment) {
        Member member = validateUtil.memberValidateById(comment.getMember().getId());
        return CommentRes.builder()
                .commentId(comment.getId())
                .profileImage(member.getUrl())
                .memberId(member.getId())
                .nickname(member.getNickname())
                .content(comment.getContent())
                .createdAt(comment.getCreatedAt())
                .build();
    }

}
