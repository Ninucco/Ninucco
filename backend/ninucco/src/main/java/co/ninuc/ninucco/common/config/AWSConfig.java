package co.ninuc.ninucco.common.config;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Component
@ConfigurationProperties(prefix = "cloud.aws")
@Getter
@AllArgsConstructor
@Slf4j
public class AWSConfig {
    String endPoint;
    String regionName;
    String bucket;
    String accessKey;
    String secretKey;
}
