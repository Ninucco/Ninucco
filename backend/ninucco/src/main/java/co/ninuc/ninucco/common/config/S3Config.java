package co.ninuc.ninucco.common.config;

import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class S3Config {
    @Value("${cloud.aws.accessKey}")
    private String accessKey;
    @Value("${cloud.aws.secretKey}")
    private String secretKey;
    @Value("${cloud.aws.regionName}")
    private String region;


    @Bean
    public AmazonS3Client amazonS3Client() {
        BasicAWSCredentials awsCredits = new BasicAWSCredentials(accessKey, secretKey);
        return (AmazonS3Client) AmazonS3ClientBuilder.standard()
                .withRegion(region)
                .withCredentials(new AWSStaticCredentialsProvider(awsCredits))
                .build();
    }
}