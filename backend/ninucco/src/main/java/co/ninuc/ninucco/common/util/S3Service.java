package co.ninuc.ninucco.common.util;

import co.ninuc.ninucco.common.config.AWSConfig;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.client.builder.AwsClientBuilder;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
@Slf4j
public class S3Service {
    AWSConfig awsConfig;
    final AmazonS3 s3;
    public S3Service(){
        log.info("getAccessKey(): "+awsConfig.getAccessKey());
        s3 = AmazonS3ClientBuilder.standard()
                .withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration(awsConfig.getEndPoint(), awsConfig.getRegionName()))
                .withCredentials(new AWSStaticCredentialsProvider(new BasicAWSCredentials(awsConfig.getAccessKey(), awsConfig.getSecretKey())))
                .build();
    }
    public AmazonS3 getS3(){
        return this.s3;
    }
}
