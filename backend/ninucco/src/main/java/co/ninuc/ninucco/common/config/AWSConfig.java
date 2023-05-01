package co.ninuc.ninucco.common.config;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Component
//@ConfigurationProperties(prefix = "cloud.aws")
@Data
public class AWSConfig {
    String endPoint;
    String regionName;
    String bucket;
    String accessKey;
    String secretKey;
    public AWSConfig(@Value("${cloud.aws.endPoint}")String endPoint,
                     @Value("${cloud.aws.regionName}")String regionName,
                     @Value("${cloud.aws.bucket}") String bucket,
                     @Value("${cloud.aws.accessKey}")String accessKey,
                     @Value("cloud.aws.secretKey")String secretKey) {
        this.endPoint = endPoint;
        this.regionName = regionName;
        this.bucket = bucket;
        this.accessKey = accessKey;
        this.secretKey = secretKey;
    }
}
