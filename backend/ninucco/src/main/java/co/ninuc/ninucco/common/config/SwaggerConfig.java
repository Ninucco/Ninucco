package co.ninuc.ninucco.common.config;

import com.google.common.base.Predicate;
import com.google.common.base.Predicates;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurationSupport;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;


@Configuration
@EnableSwagger2
public class SwaggerConfig extends WebMvcConfigurationSupport {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/static/**").addResourceLocations("classpath:/static/");
        registry.addResourceHandler("swagger-ui.html").addResourceLocations("classpath:/META-INF/resources/");
        registry.addResourceHandler("/webjars/**").addResourceLocations("classpath:/META-INF/resources/webjars/");
    }

    private ApiInfo apiInfo() {
        return new ApiInfoBuilder()
                .title("NINUCCO Spring Boot REST API")
                .version("1.0.0")
                .description("마 니누꼬?")
                .build();
    }

    public Docket getDocket(String groupName, Predicate<String> predicate) {
//		List<ResponseMessage> responseMessages = new ArrayList<ResponseMessage>();
//		responseMessages.add(new ResponseMessageBuilder().code(200).message("OK !!!").build());
//		responseMessages.add(new ResponseMessageBuilder().code(500).message("서버 문제 발생 !!!").responseModel(new ModelRef("Error")).build());
//		responseMessages.add(new ResponseMessageBuilder().code(404).message("페이지를 찾을 수 없습니다 !!!").build());
        return new Docket(DocumentationType.SWAGGER_2).groupName(groupName).apiInfo(apiInfo()).select()
                .apis(RequestHandlerSelectors.basePackage("co.ninuc.ninucco.api.controller")).paths(predicate)
                .apis(RequestHandlerSelectors.any())
                .build();
//				.useDefaultResponseMessages(false)
//				.globalResponseMessage(RequestMethod.GET,responseMessages);
    }

    @Bean
    public Docket memberApi() {
        return getDocket("member", Predicates.or(PathSelectors.regex("/member.*")));
    }

    @Bean
    public Docket battleApi() {
        return getDocket("battle", Predicates.or(PathSelectors.regex("/battle.*")));
    }

    @Bean
    public Docket faceApi() {
        return getDocket("face", Predicates.or(PathSelectors.regex("/face.*")));
    }

    @Bean
    public Docket rankApi() {
        return getDocket("rank", Predicates.or(PathSelectors.regex("/rank.*")));
    }


}

