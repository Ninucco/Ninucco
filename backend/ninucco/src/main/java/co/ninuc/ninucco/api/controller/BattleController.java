package co.ninuc.ninucco.api.controller;

import co.ninuc.ninucco.api.dto.ApiResult;
import co.ninuc.ninucco.api.dto.request.BattleCreateReq;
import co.ninuc.ninucco.api.dto.request.CommentCreateReq;
import co.ninuc.ninucco.api.service.BattleService;
import co.ninuc.ninucco.common.exception.NotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/battle")
@RequiredArgsConstructor
public class BattleController {
    private final BattleService battleService;

    //배틀 등록
    @PostMapping("/")
    public ResponseEntity<?> insertBattle(BattleCreateReq battleCreateReq) throws NotFoundException{
        return ResponseEntity.ok().body(
                new ApiResult<>(true, battleService.insertBattle(battleCreateReq))
        );
    }
    //배틀 리스트 조회
    @GetMapping("/list")
    public ResponseEntity<?> selectAllBattle(@RequestParam String option){
        return ResponseEntity.ok().body(
                new ApiResult<>(true, battleService.selectAllBattle(option))
        );
    }
    //배틀 상세정보 조회
    @GetMapping("/{battleId}")
    public ResponseEntity<?> selectOneBattle(Long battleId) throws NotFoundException{
        return ResponseEntity.ok().body(
                new ApiResult<>(true, battleService.selectOneBattle(battleId))
        );
    }
    //댓글 작성
    @PostMapping("/comment")
    public ResponseEntity<?> insertComment(CommentCreateReq commentCreateReq) throws NotFoundException{
        return null;
    }



//    @Override
//    public void updateArticle(ArticleUpdate param) throws NotFoundException{
//        Article article = articleRepository.findById(param.getArticleId())
//                .orElseThrow(()->new NotFoundException("articleNo가 존재하지 않습니다"));
//        article.updateArticle(param.getContent());
//    }
//
//    @Override
//    public void deleteArticle(Long articleId) throws NotFoundException{
//        articleRepository.deleteById(articleId);
//    }

}
