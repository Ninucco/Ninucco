package co.ninuc.ninucco.api.controller;

import co.ninuc.ninucco.api.dto.ApiResult;
import co.ninuc.ninucco.api.dto.Res;
import co.ninuc.ninucco.api.dto.Similarity;
import co.ninuc.ninucco.api.dto.request.SimilarityReq;
import co.ninuc.ninucco.api.dto.response.SimilarityResultRes;
import co.ninuc.ninucco.api.service.FaceServiceImpl;
import co.ninuc.ninucco.api.service.RedisService;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/face")
@RequiredArgsConstructor
public class FaceController {
    private final FaceServiceImpl faceService;
    private final RedisService redisService;
    private final boolean SUCCESS = true;
    @ApiOperation(value = "나와 닮은 것 찾기", notes="나와 닮은 것 찾기를 합니다.")
    @RequestMapping(value="", method = RequestMethod.POST,consumes = {"multipart/form-data"})
    public ResponseEntity<ApiResult<Res>> generate(@ModelAttribute SimilarityReq similarityReq) {
        return ResponseEntity.ok().body(
                new ApiResult<>(SUCCESS, faceService.generate(similarityReq))
        );
    }
//    @ApiOperation(value = "내 닮은것 찾기 내역")
//    @GetMapping(value = "/{memberId}")
//    public ResponseEntity<?> findAllSimilarityResultsByMemberId(@PathVariable String memberId){
//        return ResponseEntity.ok().body(
//                new ApiResult<>(SUCCESS, faceService.findSimilarityResultsByMemberId(memberId))
//        );
//    }
}
