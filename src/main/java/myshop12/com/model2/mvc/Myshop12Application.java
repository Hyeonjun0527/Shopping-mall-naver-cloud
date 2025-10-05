package myshop12.com.model2.mvc;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.context.annotation.FilterType;

import javax.sql.DataSource;

@SpringBootApplication
@EnableAspectJAutoProxy
@ComponentScan(
        basePackages = {"myshop12.com.model2.mvc.**","myshop12.com.model2.mvc"},
        includeFilters = {
                @ComponentScan.Filter(type= FilterType.ANNOTATION, classes = {
                        org.springframework.stereotype.Controller.class,
                        org.springframework.web.bind.annotation.RestController.class,
                        org.springframework.stereotype.Service.class,
                        org.springframework.stereotype.Repository.class,
                        org.springframework.context.annotation.Configuration.class,
                        org.springframework.context.annotation.Bean.class
                }),

        })//첫번째 scan할것, 두번째 @Configuration
//서블릿 이니셜라이저는 web.xml 역할 수행할 수 있다.
public class Myshop12Application extends SpringBootServletInitializer {

    @Autowired
    private DataSource dataSource;

    public static void main(String[] args) {
        System.out.println("테스트");
        SpringApplication.run(Myshop12Application.class, args);
    }

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(Myshop12Application.class);
    }

    @Bean
    public CommandLineRunner printDbUsername() {
        return args -> {
            System.out.println("===================================================");
            System.out.println("!!! DEBUGGING: ACTUAL DB USERNAME FROM DATASOURCE !!!");
            try {
                String username = dataSource.getConnection().getMetaData().getUserName();
                System.out.println("!!! ACTUAL USERNAME: " + username + " !!!");
            } catch (Exception e) {
                System.out.println("!!! COULD NOT GET USERNAME: " + e.getMessage() + " !!!");
            }
            System.out.println("===================================================");
        };
    }
}
