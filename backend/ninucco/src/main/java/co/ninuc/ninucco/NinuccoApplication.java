package co.ninuc.ninucco;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

import java.io.IOException;
import java.net.URISyntaxException;

@SpringBootApplication
@EnableJpaAuditing
@EnableConfigurationProperties
public class NinuccoApplication {

	public static void main(String[] args) throws URISyntaxException, IOException {
		SpringApplication.run(NinuccoApplication.class, args);
	}

}
