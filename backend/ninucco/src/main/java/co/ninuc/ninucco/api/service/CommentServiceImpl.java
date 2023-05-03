package co.ninuc.ninucco.api.service;

import co.ninuc.ninucco.api.dto.ErrorRes;
import co.ninuc.ninucco.api.dto.request.CommentCreateReq;
import co.ninuc.ninucco.api.dto.response.CommentListRes;
import co.ninuc.ninucco.api.dto.response.CommentRes;
import co.ninuc.ninucco.common.exception.CustomException;
import co.ninuc.ninucco.db.entity.Battle;
import co.ninuc.ninucco.db.entity.Comment;
import co.ninuc.ninucco.db.entity.Member;
import co.ninuc.ninucco.db.repository.BattleRepository;
import co.ninuc.ninucco.db.repository.CommentRepository;
import co.ninuc.ninucco.db.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class CommentServiceImpl implements CommentService{

    private final CommentRepository commentRepository;
    private final MemberRepository memberRepository;
    private final BattleRepository battleRepository;

    @Transactional
    @Override
    public CommentRes insertComment(String memberId, CommentCreateReq commentCreateReq) {

        Member member = memberRepository.findById(memberId).orElseThrow(() -> new CustomException(ErrorRes.NOT_FOUND_MEMBER));
        Battle battle = battleRepository.findById(commentCreateReq.getBattleId()).orElseThrow(() -> new CustomException(ErrorRes.NOT_FOUND_BATTLE));

        Comment comment = toEntity(member, battle, commentCreateReq.getContent());
        commentRepository.save(comment);

        return toCommentRes(comment);
    }

    @Override
    public CommentListRes selectAllComment(Long battleId) {
        return new CommentListRes(commentRepository.findAllByBattle_Id(battleId).stream().map(this::toCommentRes).collect(Collectors.toList()));
    }

    Comment toEntity(Member member, Battle battle, String content) {
        return Comment.builder()
                .member(member)
                .battle(battle)
                .content(content)
                .build();
    }

    CommentRes toCommentRes(Comment comment) {
        Member member = memberRepository.findById(comment.getMember().getId()).orElseThrow(() -> new CustomException(ErrorRes.NOT_FOUND_MEMBER));
        return CommentRes.builder()
                .commentId(comment.getId())
                .profileImage(member.getUrl())
                .content(comment.getContent())
                .createdAt(comment.getCreatedAt())
                .build();
    }

}
