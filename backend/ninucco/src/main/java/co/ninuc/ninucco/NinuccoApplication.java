package co.ninuc.ninucco;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;

@SpringBootApplication
@EnableJpaAuditing
public class NinuccoApplication {

	public static void main(String[] args) {
		SpringApplication.run(NinuccoApplication.class, args);
	}

}
