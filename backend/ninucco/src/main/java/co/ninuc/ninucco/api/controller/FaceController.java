package co.ninuc.ninucco.api.controller;

import co.ninuc.ninucco.api.dto.ApiResult;
import co.ninuc.ninucco.api.dto.SimilarityResult;
import co.ninuc.ninucco.api.dto.response.SimilarityResultRes;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/face")
@RequiredArgsConstructor
public class FaceController {
    private final boolean SUCCESS = true;
    @ApiOperation(value = "얼굴인식 결과 조회", notes="배틀 리스트를 조회합니다.")
    @GetMapping("/dummy")
    public ResponseEntity<?> dummyResult() {
        return ResponseEntity.ok().body(
                new ApiResult<>(SUCCESS, SimilarityResultRes.builder()
                        .imgUrl("https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/1.png")
                        .resultTitle("1퍼센트의 오차도 허용하지 않는 깐깐한 고양이상")
                        .resultPercentages(new ArrayList<>(List.of(new SimilarityResult[]{
                                SimilarityResult.builder().title("고양이상").value(0.6).build(),
                                SimilarityResult.builder().title("강아지상").value(0.2).build()
                        }))).build())
        );
    }
}
