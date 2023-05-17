package co.ninuc.ninucco.api.service;

import co.ninuc.ninucco.api.dto.ErrorRes;
import co.ninuc.ninucco.api.dto.Similarity;
import co.ninuc.ninucco.api.dto.request.SimilarityReq;
import co.ninuc.ninucco.api.dto.response.SimilarityResultRes;
import co.ninuc.ninucco.common.exception.CustomException;
import co.ninuc.ninucco.common.util.SimilarityModelService;
import co.ninuc.ninucco.common.util.StabilityAIService;
import co.ninuc.ninucco.common.util.ValidateUtil;
import co.ninuc.ninucco.db.entity.SimilarityResult;
import co.ninuc.ninucco.db.repository.SimilarityResultRepository;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.ObjectMetadata;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@Slf4j
public class FaceServiceImpl {
    private final SimilarityModelService similarityModelService;
    private final StabilityAIService stabilityAIService;
    private final AmazonS3Client amazonS3Client;
    private final SimilarityResultRepository similarityResultRepository;
    private final RedisService redisService;
    private final ValidateUtil validateUtil;

    @Value("${cloud.aws.s3.bucket}")
    private String bucket;

    public SimilarityResultRes generate(SimilarityReq r){
        //유저 아이디 검증
        validateUtil.memberValidateById(r.getMemberId());
        //파일이 png인지 검사한다
        String contentType = r.getImg().getContentType();
        if(!StringUtils.hasText(contentType) || !contentType.equals("image/png"))
            throw new CustomException(ErrorRes.BAD_REQUEST);
        //파일 bypeArray로 변환
        byte[] inputImgByteArray;
        try{
            inputImgByteArray = r.getImg().getBytes();
        }catch(IOException e){
            throw new CustomException(ErrorRes.INTERNAL_SERVER_ERROR);
        }
        //2. 데이터 리스트를 받는다(keyword-value)
        List<Similarity> similarityResultList = similarityModelService.getList(r.getModelType(), inputImgByteArray);
        List<Similarity> personalitySimilarityResultList = similarityModelService.getList("personality", inputImgByteArray);
        log.info("1. 데이터 리스트 받기 완료");
        //3. 데이터 리스트에서 가장 상위의 키워드를 뽑는다
        String keyword = similarityResultList.get(0).getKeyword();
        String personalityKeyword = personalitySimilarityResultList.get(0).getKeyword();

        //프롬프트 생성
        String basePrompt = "sitting in a office typing code,unreal engine, cozy indoor lighting, artstation, detailed, digital painting,cinematic,character design by mark ryden and pixar and hayao miyazaki, unreal 5, daz, hyperrealistic, octane render";
        String prompt=new StringBuilder().append("Cute small ")
                .append(keyword)
                .append(personalityKeyword)
                //기본 프롬프트
                .append(basePrompt)
                .toString();

        //4. 이미지 생성
        byte[] resultImgByteArray = stabilityAIService.getByteArrayImgToImg(inputImgByteArray, prompt);
        log.info("2. 이미지 생성 완료");
        //S3에 저장
        //TODO: S3에 사진 저장되면 이전 사진 삭제되는 문제 해결
        ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(resultImgByteArray);
        ObjectMetadata objectMetadata = new ObjectMetadata();
        objectMetadata.setContentLength(byteArrayInputStream.available());
        String fileName = UUID.nameUUIDFromBytes(resultImgByteArray)+".png";
        amazonS3Client.putObject(
                bucket,
                fileName,
                byteArrayInputStream,
                objectMetadata
        );
        log.info("3. s3에 이미지 저장 완료");
        String imgUrl =amazonS3Client.getResourceUrl(bucket, fileName);
        // 5. resultTitle, resultDescription을 얻는다.

        String personalityKeywordKor = redisService.getRedisStringValue("kor:"+personalityKeyword);
        String keywordKor = redisService.getRedisStringValue("kor:"+keyword);

        String titleModifier = redisService.getRedisStringValue("title-modifier:"+personalityKeywordKor);
        String descriptionModifier = redisService.getRedisStringValue("description-modifier:"+personalityKeywordKor);

        StringBuilder resultTitle = new StringBuilder().append(titleModifier).append(' ')
                .append(personalityKeywordKor).append(' ')
                .append(keywordKor)
                .append("상");
        String resultDescription = descriptionModifier;
        //6. 유저 아이디로 FCM을 보낸다.

        //6. HTTPResponse로 보낸다.
        List<Similarity> listTop5 = new ArrayList<>(similarityResultList.subList(0, Math.min(5, similarityResultList.size())));

        similarityResultRepository.save(
                SimilarityResult.builder()
                        .memberId(r.getMemberId())
                        .modelType(r.getModelType())
                        .imgUrl(imgUrl)
                        .resultTitle(resultTitle.toString())
                        .resultDescription(resultDescription)
                        .resultList(listTop5).build()
        );

        return SimilarityResultRes.builder()
                .imgUrl(imgUrl)
                .resultTitle(resultTitle.toString())
                .resultDescription(resultDescription)
                .resultList(listTop5).build();
    }
//    public SimilarityResultListRes findSimilarityResultsByMemberId(String memberId){
//        return new SimilarityResultListRes(similarityResultRepository.findAllByMemberId(memberId).stream()
//                .map((r -> SimilarityResultRes.builder()
//                        .modelType(r.getModelType())
//                        .imgUrl(r.getImgUrl())
//                        .resultTitle(r.getResultTitle())
//                        .resultDescription(r.getResultDescription())
//                        .resultList(r.getResultList()).build())).collect(Collectors.toList()));
//    }
}
