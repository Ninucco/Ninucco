package co.ninuc.ninucco.api.service;

import co.ninuc.ninucco.api.dto.ErrorRes;
import co.ninuc.ninucco.api.dto.Similarity;
import co.ninuc.ninucco.api.dto.response.SimilarityResultRes;
import co.ninuc.ninucco.common.exception.CustomException;
import co.ninuc.ninucco.common.util.SimilarityModelService;
import co.ninuc.ninucco.common.util.StabilityAIService;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.ObjectMetadata;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

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

    @Value("${cloud.aws.s3.bucket}")
    private String bucket;

    public SimilarityResultRes generate(String modelType, MultipartFile inputImg){
        //1. 입력으로부터 유저 아이디를 받는다

        //파일이 png인지 검사한다
        String contentType = inputImg.getContentType();
        if(!StringUtils.hasText(contentType) || !contentType.equals("image/png"))
            throw new CustomException(ErrorRes.BAD_REQUEST);
        //파일 bypeArray로 변환
        byte[] inputImgByteArray;
        try{
            inputImgByteArray = inputImg.getBytes();
        }catch(IOException e){
            throw new CustomException(ErrorRes.INTERNAL_SERVER_ERROR);
        }
        //2. 데이터 리스트를 받는다(keyword-value)
        List<Similarity> similarityResultList = similarityModelService.getList(modelType, inputImgByteArray);
        List<Similarity> personalitySimilarityResultList = similarityModelService.getList("job", inputImgByteArray);
        log.info("1. 데이터 리스트 받기 완료");
        //3. 데이터 리스트에서 가장 상위의 키워드를 뽑는다
        String animalKeyword = similarityResultList.get(0).getKeyword();
        String personalityKeyword = personalitySimilarityResultList.get(0).getKeyword();

        //프롬프트 생성
        String basePrompt = "sitting in a office typing code,unreal engine, cozy indoor lighting, artstation, detailed, digital painting,cinematic,character design by mark ryden and pixar and hayao miyazaki, unreal 5, daz, hyperrealistic, octane render";
        String prompt=new StringBuilder().append("Cute small ")
                .append(animalKeyword)
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
        // 5. 무슨 수를 써서 resultTitle, resultDescription을 얻는다.
        /*
         * ......
         *
         * */
        String resultTitle = "1퍼센트의 오차도 허용하지 않는 깐깐한 고양이상";
        String resultDescription = "장인은 대담하면서도 현실적인 성격으로, 모든 종류의 도구를 자유자재로 다루는 성격 유형입니다. \\n\" +\n" +
                "                                \"\\n\" +\n" +
                "                                \"내향형의 사람들은 소수의 사람들과 깊고 의미 있는 관계를 맺는 일을 선호하며, 차분한 환경을 원할 때가 많습니다.\\n\" +\n" +
                "                                \"\\n\" +\n" +
                "                                \"관찰형의 사람들은 실용적이고 현실적인 성격을 지니고 있습니다. 이들은 현재 발생하고 있거나 발생할 가능성이 매우 높은 일에 집중하는 경향이 있습니다.\\n\" +\n" +
                "                                \"\\n\" +\n" +
                "                                \"사고형의 사람들은 객관성과 합리성을 중시하며 논리에 집중하느라 감정을 간과할 때가 많습니다. 이들은 사회적 조화보다는 효율성이 더 중요하다고 생각하는 경향이 있습니다.";

        //6. 유저 아이디로 FCM을 보낸다.

        //6. HTTPResponse로 보낸다.
        List<Similarity> listTop5 = new ArrayList<>(similarityResultList.subList(0, Math.min(5, similarityResultList.size())));
        return SimilarityResultRes.builder()
                .imgUrl(imgUrl)
                .resultTitle(resultTitle)
                .resultDescription(resultDescription)
                .resultList(listTop5).build();
    }
}
