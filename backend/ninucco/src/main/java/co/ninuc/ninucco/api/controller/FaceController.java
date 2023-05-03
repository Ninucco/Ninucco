package co.ninuc.ninucco.api.controller;

import co.ninuc.ninucco.api.dto.ApiResult;
import co.ninuc.ninucco.api.dto.SimilarityResult;
import co.ninuc.ninucco.api.dto.request.KeywordCreateReq;
import co.ninuc.ninucco.api.dto.request.SimilarityReq;
import co.ninuc.ninucco.api.dto.response.SimilarityResultRes;
import co.ninuc.ninucco.api.service.FaceServiceImpl;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/face")
@RequiredArgsConstructor
public class FaceController {
    private final FaceServiceImpl faceService;
    private final boolean SUCCESS = true;

    @ApiOperation(value = "얼굴인식 결과 조회", notes="배틀 리스트를 조회합니다.")
    @PostMapping("/dummy")
    public ResponseEntity<?> dummyResult(@RequestBody SimilarityReq similarityReq) {
        return ResponseEntity.ok().body(
                new ApiResult<>(SUCCESS, SimilarityResultRes.builder()
                        .imgUrl("https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/1.png")
                        .resultTitle("1퍼센트의 오차도 허용하지 않는 깐깐한 고양이상")
                        .resultDescription("장인은 대담하면서도 현실적인 성격으로, 모든 종류의 도구를 자유자재로 다루는 성격 유형입니다. \n" +
                                "\n" +
                                "내향형의 사람들은 소수의 사람들과 깊고 의미 있는 관계를 맺는 일을 선호하며, 차분한 환경을 원할 때가 많습니다.\n" +
                                "\n" +
                                "관찰형의 사람들은 실용적이고 현실적인 성격을 지니고 있습니다. 이들은 현재 발생하고 있거나 발생할 가능성이 매우 높은 일에 집중하는 경향이 있습니다.\n" +
                                "\n" +
                                "사고형의 사람들은 객관성과 합리성을 중시하며 논리에 집중하느라 감정을 간과할 때가 많습니다. 이들은 사회적 조화보다는 효율성이 더 중요하다고 생각하는 경향이 있습니다.")
                        .resultPercentages(new ArrayList<>(List.of(new SimilarityResult[]{
                                SimilarityResult.builder().keyword("고양이상").value(0.6).build(),
                                SimilarityResult.builder().keyword("강아지상").value(0.2).build()
                        }))).build())
        );
    }
    //얼굴인식 키워드 넣기용
    @ApiOperation(value = "데이터용: 키워드 넣기", notes="카테고리: 0:PERSONALITY, 1:JOB, 2:ANIMAL")
    @PostMapping("/keyword")
    public ResponseEntity<?> saveKeyword(KeywordCreateReq keyword) {
        return ResponseEntity.ok().body(
                new ApiResult<>(SUCCESS, faceService.saveKeyword(keyword)
                ));
    }
    @ApiOperation(value = "키워드 리스트 확인하기", notes="키워드 리스트 확인하기")
    @GetMapping("/keyword/list")
    public ResponseEntity<?> findAllKeywords() {
        return ResponseEntity.ok().body(
                new ApiResult<>(SUCCESS, faceService.findAllKeywords()
                ));
    }
    //나와 닮은 동물 찾기(PERSONALITY + ANIMAL)
    @ApiOperation(value = "나와 닮은 동물 찾기", notes="나와 닮은 동물 찾기를 합니다. 다 되면 FCM을 보냅니다.")
    @PostMapping("/animal")
    public ResponseEntity<?> generateAnimal(@RequestBody MultipartFile image) {
        return ResponseEntity.ok().body(
                new ApiResult<>(SUCCESS, faceService.generateAnimal(image))
        );
    }
}
