---
title: "Spring Boot 시작하기"
date: 2020-01-15T06:37:32+03:00
draft: false
---

이 문서는 스프링 [문서](https://spring.io/projects/spring-boot)의 번역 문서입니다. `스프링 부트`는 쉽게 제품 등급의 독립형 스프링 기반 애플리케이션을 만들 수 있습니다. 대부분의 스프링 부트 애플리케케이션은 적은 설정을 필요로 합니다.

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

### 빈 이름 출력

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

### Mustache 템플릿 사용

Mustache는 Logic-Less해 배우기 쉽고 사용법도 간단합니다. [공식 문서](https://www.thymeleaf.org/documentation.html)를 확인해 보시기 바랍니다.