package co.ninuc.ninucco;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;
import org.springframework.scheduling.annotation.EnableScheduling;

import java.io.IOException;
import java.net.URISyntaxException;

@SpringBootApplication
@EnableJpaAuditing
@EnableConfigurationProperties
@EnableScheduling
public class NinuccoApplication {

	public static void main(String[] args) {
		SpringApplication.run(NinuccoApplication.class, args);
	}

}
