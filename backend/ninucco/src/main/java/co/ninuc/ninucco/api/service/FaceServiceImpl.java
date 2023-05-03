package co.ninuc.ninucco.api.service;

import co.ninuc.ninucco.api.dto.ErrorRes;
import co.ninuc.ninucco.api.dto.SimilarityResult;
import co.ninuc.ninucco.api.dto.request.KeywordCreateReq;
import co.ninuc.ninucco.api.dto.response.SimilarityResultRes;
import co.ninuc.ninucco.common.exception.CustomException;
import co.ninuc.ninucco.common.util.LambdaService;
import co.ninuc.ninucco.common.util.StabilityAIService;
import co.ninuc.ninucco.db.entity.Keyword;
import co.ninuc.ninucco.db.repository.KeywordRepository;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.ObjectMetadata;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
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
    private final LambdaService lambdaService;
    private final StabilityAIService stabilityAIService;
    private final KeywordRepository keywordRepository;
    private final AmazonS3Client amazonS3Client;

    @Value("${cloud.aws.s3.bucket}")
    private String bucket;
    @Transactional
    public Long saveKeyword(KeywordCreateReq keyword){
        return keywordRepository.save(Keyword.builder()
                .category(keyword.getCategory())
                .name(keyword.getName()).build()).getId();
    }
    public List<Keyword> findAllKeywords(){
        return keywordRepository.findAll();
    }

    public SimilarityResultRes generateAnimal(MultipartFile inputImg){
        //1. 입력으로부터 유저 아이디, 유저 사진을 받는다
//        String picBase64 = similarityReq.getPicBase64();
//        byte[] picByteArray = Base64.decodeBase64(picBase64);
//
//        //파일이 사진인지 검사한다
//        String[] picBase64Tokens = picBase64.split(",");
//        String extension;
//        switch(picBase64Tokens[0]){
//            case "data:image/jpg;base64":
//                extension = "jpg";
//                break;
//            case "data:image/jpeg;base64":
//                extension = "jpeg";
//                break;
//            case "data:image/png;base64":
//                extension = "png";
//                break;
//            default:
//                //사진이 jpg, jpeg, png가 아님! 다시
//                throw new CustomException(ErrorRes.INTERNAL_SERVER_ERROR_FILE_NOT_PICTURE);
//        }
//        String fileName = LocalDateTime.now().toString()+extension;

        //2. 무슨 수를 써서 어딘가로부터 데이터 리스트를 받는다(keyword-value)
        //List<SimilarityResult> animalSimilarityResultList = new ArrayList<>();
        List<SimilarityResult> animalSimilarityResultList = lambdaService.getList();
        List<SimilarityResult> personalisySimilarityResultList = new ArrayList<>();

        //3. 데이터 리스트에서 가장 상위의 키워드를 뽑는다(리스트 길이가 0이 아님이 보장되어야함)
        String animalKeyword = animalSimilarityResultList.get(0).getKeyword();
        String personalityKeyword = "encouraged";//"깐깐한";//personalisySimilarityResultList.get(0).getKeyword();

        String prompt=new StringBuilder().append("Cute small ")
                .append(animalKeyword)
                .append(personalityKeyword)
                //기본 프롬프트
                .append("sitting in a office typing code,unreal engine, cozy indoor lighting, artstation, detailed, digital painting,cinematic,character design by mark ryden and pixar and hayao miyazaki, unreal 5, daz, hyperrealistic, octane render")
                .toString();
        //4. 무슨 수를 써서 이미지를 얻어온다.
        byte[] inputImgByteArray;
        try{
            inputImgByteArray = inputImg.getBytes();
        }catch(IOException e){
            throw new CustomException(ErrorRes.INTERNAL_SERVER_ERROR);
        }
        byte[] resultImgByteArray = stabilityAIService.getByteArrayImgToImg(inputImgByteArray, prompt);
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
        return SimilarityResultRes.builder()
                .imgUrl(imgUrl)
                .resultTitle(resultTitle)
                .resultDescription(resultDescription)
                .resultPercentages(animalSimilarityResultList).build();
    }
}
