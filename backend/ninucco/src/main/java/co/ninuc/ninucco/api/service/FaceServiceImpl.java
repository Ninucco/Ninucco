package co.ninuc.ninucco.api.service;

import co.ninuc.ninucco.api.dto.ErrorRes;
import co.ninuc.ninucco.api.dto.Similarity;
import co.ninuc.ninucco.api.dto.request.SimilarityReq;
import co.ninuc.ninucco.api.dto.response.SimilarityResultRes;
import co.ninuc.ninucco.common.exception.CustomException;
import co.ninuc.ninucco.common.util.SimilarityModelService;
import co.ninuc.ninucco.common.util.StabilityAIService;
import co.ninuc.ninucco.common.util.ValidateUtil;
import co.ninuc.ninucco.db.entity.Member;
import co.ninuc.ninucco.db.entity.SimilarityResult;
import co.ninuc.ninucco.db.repository.MemberRepository;
import co.ninuc.ninucco.db.repository.SimilarityResultRepository;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.ObjectMetadata;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.io.ByteArrayInputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@Slf4j
public class FaceServiceImpl {
    private final MemberRepository memberRepository;
    private final SimilarityModelService similarityModelService;
    private final StabilityAIService stabilityAIService;
    private final AmazonS3Client amazonS3Client;
    private final SimilarityResultRepository similarityResultRepository;
    private final RedisService redisService;
    private final ValidateUtil validateUtil;

    @Value("${cloud.aws.s3.bucket}")
    private String bucket;

    public SimilarityResultRes generate(SimilarityReq r){
        //유저 아이디 검증, 포인트 검증, 포인트 빼기
        Member member = validateUtil.memberValidateById(r.getMemberId());
        if(!member.subtractPoint(50))
            throw new CustomException(ErrorRes.NOT_ENOUGH_POINT);
        memberRepository.save(member);
        //파일이 png인지 검사한다
        String contentType = r.getImg().getContentType();
        if(!StringUtils.hasText(contentType) || !contentType.equals("image/png"))
            throw new CustomException(ErrorRes.BAD_REQUEST);
        //파일 resource로 변환
        Resource imgResource = r.getImg().getResource();

        //2. 데이터 리스트를 받는다(keyword-value)
        List<Similarity> similarityResultList = similarityModelService.getList(imgResource, r.getModelType());
        List<Similarity> personalitySimilarityResultList = similarityModelService.getList(imgResource, "personality");
        log.info("1. 데이터 리스트 받기 완료");
        //3. 데이터 리스트에서 가장 상위의 키워드를 뽑는다
        String keyword = similarityResultList.get(0).getKeyword();
        String personalityKeyword = personalitySimilarityResultList.get(0).getKeyword();
        //프롬프트 생성
        String prompt=this.getPrompt(personalityKeyword, keyword);
        String imageStrength = redisService.getRedisStringValue("image_strength:"+r.getModelType());
        String stylePreset = redisService.getRedisStringValue("style_preset:"+r.getModelType());
        log.info(">> prompt: "+prompt);
        //4. 이미지 생성
        byte[] resultImgByteArray = stabilityAIService.getByteArrayImgToImg(r.getImg(), prompt, imageStrength, stylePreset);
        log.info("2. 이미지 생성 완료");
        //S3에 저장
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
        String keywordKor = r.getModelType().equals("programming")?keyword:redisService.getRedisStringValue("kor:"+keyword);

        String titleModifier = redisService.getRedisStringValue("title-modifier:"+personalityKeyword);
        String personalityDescriptionModifier = redisService.getRedisStringValue("description-modifier:"+personalityKeyword);
        String descriptionModifier = redisService.getRedisStringValue("description-modifier:"+keyword);

        StringBuilder resultTitle = new StringBuilder().append(titleModifier).append(' ')
                .append(personalityKeywordKor).append(' ')
                .append(keywordKor)
                .append("상");
        String resultDescription = descriptionModifier+personalityDescriptionModifier;
        //6. 유저 아이디로 FCM을 보낸다.

        //6. HTTPResponse로 보낸다.
        List<Similarity> listTop5 = new ArrayList<>(similarityResultList.subList(0, Math.min(5, similarityResultList.size())));
        if(!r.getModelType().equals("programming"))
            listTop5.forEach(result->result.setKeyword(redisService.getRedisStringValue("kor:"+result.getKeyword())));

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
    private String getPrompt(String personalityKeyword, String keyword){
        return personalityKeyword + ',' +
                redisService.getRedisStringValue("prompt:" + keyword) + ',' +
                redisService.getRedisStringValue("prompt:base");
    }
}
