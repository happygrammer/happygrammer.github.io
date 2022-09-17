---
title: "Spring Boot 시작하기"
date: 2019-11-20T06:37:32+03:00
draft: false
---

`스프링 부트`는 쉽게 제품 등급의 독립형 스프링 기반 애플리케이션을 만들 수 있습니다. 대부분의 스프링 부트 애플리케케이션은 적은 설정을 필요로 합니다.



## 특징

- 독립형 애플리케이셩 생성
- 내장 톰캣, 제티 포함. (WAR파일 배포 불필요)
- 스타터는 단순한 빌드 설정을 이용합니다.
- Spring 및 타사 의존 라이브러리를 자동으로 설정 되도록 합니다.
- 운영에 필요한 health 체크, 외부 설정 등의 기능을 제공합니다.
- 코드를 생성하거나 XML 설정을 요구 하지 않습니다.

### 스프링 부트 소개

이 문서는 레퍼런스 [문서](https://docs.spring.io/spring-boot/docs/2.2.2.RELEASE/reference/html/getting-started.html#getting-started)의 번역 문서입니다. 스프링 부트의 목표는 다음과 같습니다.

- 스프링 개발을 위한 빠르게 넓게 접근할 수 있는 스프링 개발 경험을 제공
- 프로젝트 공통에 해당하는 특징을 제공함 예를 들어 내장 서버, 보안, 메트릭, 헬스 체크, 외부 설정
- XML 설정을 요구하거나 코드 생성이 없음

스프링 부터는 다음의 내장 서블릿 컨테이를 제공하고 있습니다.

| Name         | Servlet Version |
| :----------- | :-------------- |
| Tomcat 9.0   | 4.0             |
| Jetty 9.4    | 3.1             |
| Undertow 2.0 | 4.0             |



### 스프링 부트 시작

프로젝트 생성 후 Dependencies로 JDBC가 있다면 아래와 같은 메시지가 뜨면서 실행이 안될 것 입니다.

```
***************************
APPLICATION FAILED TO START
***************************

Description:

Failed to configure a DataSource: 'url' attribute is not specified and no embedded datasource could be configured.

Reason: Failed to determine a suitable driver class
```

JDBC 설정을 바로 하지 않을 것이라면 다음 애노테이션을 추가합니다.

```
@EnableAutoConfiguration(exclude={DataSourceAutoConfiguration.class})
```

예제를 시작 하겠습니다. 프로젝트 우클릭후 Run As - Spring Boot App을 선택합니다.

```
package com.example.demo.com.example.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;

@SpringBootApplication
@EnableAutoConfiguration(exclude={DataSourceAutoConfiguration.class})

public class Application {

	public static void main(String[] args) {
		SpringApplication.run(Application.class, args);
	}

}
```

그리고 브라우저를 이용해 다음 주소로 접속합니다.

```
http://localhost:8080/login
```

만약 디폴트 포트인 8080을 8081로 변경하려면 애플리케이션 프로퍼티에 포트 설정을 합니다.

```
server.port=8081
```

@SpringBootApplication는 다음 세가지를 합한 의미입니다.

```
@SpringBootConfiguration
@ComponentScan
@EnableAutoConfiguration
```

@ComponentScan은  각종 @Component를 상속 받는 각종 애노테이션(@Configuration, @Repository, @Service, @Controller, @RestController )을 빈으로 인식해 스캔하는 역할을 합니다.

#### 빈 이름 출력

```
package main;

import java.util.Arrays;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
@EnableAutoConfiguration(exclude = { DataSourceAutoConfiguration.class })
public class Application {

	public static void main(String[] args) {
		SpringApplication.run(Application.class, args);
	}

	@Bean
	public CommandLineRunner commandLineRunner(ApplicationContext ctx) {
		return args -> {
			System.out.println("Let's inspect the beans provided by Spring Boot:");
			String[] beanNames = ctx.getBeanDefinitionNames();
			Arrays.sort(beanNames);
			for (String beanName : beanNames) {
				System.out.println("BeanName : " + beanName);
			}
		};
	}
}
```

빈 이름 목록 출력 결과입니다.

```
Let's inspect the beans provided by Spring Boot:
BeanName : application
BeanName : applicationTaskExecutor
BeanName : basicErrorController
BeanName : beanNameHandlerMapping
BeanName : beanNameViewResolver
BeanName : characterEncodingFilter
...(중략)
BeanName : webServerFactoryCustomizerBeanPostProcessor
BeanName : websocketServletWebServerCustomizer
```



### 서블릿 컨테이너

서블릿 컨테이너인 톰캣은 요청을 받아 SpringDispatcherServlet  객체로 전달합니다. 이후 컨트롤러의 액션 메소드로 dispatch를 하게 됩니다. dispatch 수행시 URL과 파라메터와 일치하는 메소드를 찾고 없다면 페이지 없음 응답을 내보냅니다. 액션 메소드를 찾았다면 뷰 이름을 찾습니다. 뷰가 JSP라면 서블릿 컴파일러(tomcat embed-jasper)로 컴파일 후 톰캣이 해당 서블릿을 실행 하도록 합니다. 요약하면 다음 순서로 실행합니다.

```
JSP → JSTL(서블릿 코드로 변환) → 톰캣(서블릿실행)
```



[서블릿 예제 코드]

```
import javax.servlet.http.*;  
import javax.servlet.*;  
import java.io.*;

public class HelloServlet extends HttpServlet{ 
public void doGet(HttpServletRequest req,HttpServletResponse res)  
throws ServletException,IOException  
{  
    res.setContentType("text/html");//컨텐츠 타입 설정
    PrintWriter pw=res.getWriter();//데이터 쓰기위한 스트림 가져옴 

    // 스트림을 이용해 컨텐츠를 출력함
    pw.println("<html><body>");  
    pw.println("Hello Servlet");  
    pw.println("</body></html>");

    pw.close();// 스트림을 닫음
}}  
```



### Hello JSP 출력

JSP 출력을 위해서 pom.xml에 의존성을 추가합니다. 아래 추가한 [JSTL](https://www.oracle.com/technetwork/java/index-jsp-135995.html)은 Oracle에서 제공하는 표준 태그 라이브러리입니다. 즉 JSP에서 사용하는 표준 태그를 지원하기 위한 라이브러리입니다. ```tomcat-embed-jasper```은 JSP파일은 서블릿으로 변환하는 컴파일러입니다. 톰캣은 JSP가 서블릿으로 변환되면, 해당 서블릿을 실행합니다. 해당 의존성을 추가하지 않으면 서블릿으로 변환되지 않고 출력됩니다.

```
<dependency>
    <groupId>javax.servlet</groupId>
    <artifactId>jstl</artifactId>
</dependency>
<dependency>
    <groupId>org.apache.tomcat.embed</groupId>
    <artifactId>tomcat-embed-jasper</artifactId>
</dependency>
```



#### 포트 설정, 뷰 설정

이후 [애플리케이션 프로퍼티 파일](https://docs.spring.io/spring-boot/docs/current/reference/html/appendix-application-properties.html) ```src/main/resources/applicaton.properties```에 뷰 설정을 합니다.

```
spring.mvc.view.prefix=/WEB-INF/views/ # 디폴트 JSP 파일 위치
spring.mvc.view.suffix=.jsp # view의 확장자.
```

애플리케이션 프로퍼티 파일이 아니라 코드를 이용해 `@Configuration` 애노테이션을 이용합니다.

```
@Configuration
public class SpringConfig {

	@Bean
	public ViewResolver getViewResolver() {
		InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
		viewResolver.setPrefix("/WEB-INF/jsp/");
		viewResolver.setSuffix(".jsp");
		return viewResolver;
	}
}

```

위 ```/WEB-INF/views	```의 스프링부트 프로젝트의 실재 경로는 아래와 같습니다.

```
/src/main/webapp/WEB-INF/views
```

위 위치에 hello.jsp 파일을 만듭니다.

```
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
Hell Spring
</body>
</html>
```



#### 컨트롤러 설정

Hello 컨트롤러 클래스를 추가하고, 컨트롤러 애노테이션을 추가합니다.

```
@Controller
```

이때 @RequestMappin 애노테이션을 이용해 위에서 만들어둔 hello.jsp 응답을 하도록 합니다.

```
package example.boot;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HelloController {
	
	@RequestMapping("/hello")
    public String jsp() throws Exception {
        return "hello";
    }

}
```

그리고 브라우저를 이용해 아래 URL을 이용해 접속해서 hello.jsp 응답 결과인 ```Hello Spring```가 출력된 것을 확인합니다.

```
http://localhost:8080/hello
```



### 에러 페이지 처리

페이지가 존재하지 않을 경우 에러 페이지를 커스텀 마이징 할 수 있습니다. ErrorController 크래스를 상속 받아 커스텀 에러 컨트롤러를 구현해 줍니다.

```
package example.boot;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;

@Controller
public class CustomErrorController implements ErrorController {

    private static final String ERROR_PATH = "/error";

    @Override
    public String getErrorPath() {
        return ERROR_PATH;
    }
    
    @RequestMapping(value = ERROR_PATH)
    public String error(HttpServletRequest servletReq) {
        Object status = servletReq.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
        if (status != null) {
            Integer statusCode = Integer.valueOf(status.toString());
            if(statusCode == HttpStatus.NOT_FOUND.value()) {
                return "errors/404";
            }
            else if(statusCode == HttpStatus.INTERNAL_SERVER_ERROR.value()) {
                return "errors/500";
            }
        }
        return "errors/default";
    }
}
```

위 예제에도 나와 있지만 커스텀 에러 페이지는 다음 경로에 만듭니다.

```
/src/main/webapp/WEB-INF/views/errors/404
/src/main/webapp/WEB-INF/views/errors/500
/src/main/webapp/WEB-INF/views/errors/default
```



### Mustache 템플릿 사용

스프링부트에서  JSP는 권장 사항이 아닙니다. 다음과 같은 이유입니다.

- war로 배포해야 합니다. (java -jar로 실행은 가능함)
- Undertow(JBoss EAP 7에 새롭게 도입된 자바 언어로 작성된 웹서버)는 JSP를 지원하지 않습니다.
  - 톰캣만 사용한다면 문제 없음
- 사용자 재정의 에러 페이지가 적용되지 않을 수 있습니다.

따라서 JSP 외의 템플릿 엔진을 도입할 필요가 있습니다. 한가지 대안이 바로 [Mustache](https://www.thymeleaf.org/documentation.html)입니다.



#### Mustache 템플릿 사용하기

애플리케이션 프로퍼티 파일에 설정해 줍니다.

```
spring.mustache.prefix=/WEB-INF/views/
spring.mustache.suffix=.html
```

이후 mustache 템플릿을 만듭니다. 경로는 ```/src/main/webapp/WEB-INF/views/mustache.html```로 만들었습니다.

```
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8"/>
	<title>{{ title }}</title>
</head>
<body>
<div>
	{{ msg }}
</div>
</body>
</html>
```

위 mustache.html를 연결해줄 컨트롤러를 만듭니다.

```
package example.boot;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MustacheController {
	
	@RequestMapping("/mustache")
    public String jsp(Model model) throws Exception {
		model.addAttribute("title", "Mustache Test Title");
		model.addAttribute("msg", "Hello Mustache!");
        return "mustache";
    }

}

```

```http://localhost:8080/mustache```주소를 호출해 보면 ```Hello Mustache!```라는 문자열이 브라우저에 표시됩니다.

### 스프링 오류 처리 프로퍼티



```
server.error.include-exception : 오류 응답에 exception 포함 여부 (TRUE, FALSE)
server.error.include-stacktrace : 오류 응답에 stacktrace 포함 여부 (ALWAYS, NEVER, ON_TRACE_PARAM)
server.error.path : 오류 응답을 처리할 핸들러(ErrorController)의 path
server.error.whitelabel.enabled : 화이트라벨 페이지 사용여부 (TRUE, FALSE)
```



기본 폴더 구조

```
src/
 +- main/
     +- java/
     |   + <source code>
     +- resources/
         +- templates/
             +- error/
             |   +- 404.html
             +- <other templates>
```

