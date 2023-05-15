package co.ninuc.ninucco.common.filter;

import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.filter.CharacterEncodingFilter;

import javax.servlet.FilterRegistration;
import javax.servlet.ServletContext;

public class WebAppInitializer implements WebApplicationInitializer {
    @Override
    public void onStartup(ServletContext servletContext){
        FilterRegistration charEncodingFilterReg = servletContext.addFilter("CharacterEncodingFilter", CharacterEncodingFilter.class);
        charEncodingFilterReg.setInitParameter("encoding", "UTF-8");
        charEncodingFilterReg.setInitParameter("forceEncoding", "true");
        charEncodingFilterReg.addMappingForUrlPatterns(null, true, "/*");
    }
}
