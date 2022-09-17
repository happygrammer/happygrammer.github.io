---
title: "스프링부트 에러에 대한 조치 방법"
date: 2020-01-15T06:37:32+03:00
draft: true
---

스프링부트가 설정을 최소화 했다고 하지만, 최소화 한 것이지 설정을 없앤 것은 아닙니다. 따라서 설정에 따른 각종 에러 메시지를 볼 수 있습니다. 본 문서는 스프링부트 실행시 나타날 수 있는 에러메시지의 종류와 조치를 어떻게 할지를 모아둔 문서 입니다.



### 1. 스프링부트 관련 에러



#### Failed to configure a Datasource

에러 메시지의 내용은 아래와 같습니다.

```
***************************
APPLICATION FAILED TO START
***************************

Description:

Failed to configure a DataSource: 'url' attribute is not specified and no embedded datasource could be configured.

Reason: Failed to determine a suitable driver class


Action:

Consider the following:
	If you want an embedded database (H2, HSQL or Derby), please put it on the classpath.
	If you have database settings to be loaded from a particular profile you may need to activate it (no profiles are currently active).
```

src/main/resources/applicaton.properties 파일에 설정을 추가합니다

```
spring.datasource.url=jdbc:mysql://localhost/myapp
spring.datasource.username=root
spring.datasource.password=root
spring.datasource.driver-class-name=com.mysql.jdbc.Driver
```

설정 없이 예외 처리할 수 도 있습니다.

```
@EnableAutoConfiguration(exclude={DataSourceAutoConfiguration.class})
@SpringBootApplication
public class SpringBootTutorialApplication {
	public static void main(String[] args) {
		SpringApplication.run(SpringBootTutorialApplication.class, args);
	}
}
```



#### Error starting ApplicationContext.

애플리케이션 컨텍스트 에러로 실행이 안됨

```
Error starting ApplicationContext. To display the conditions report re-run your application with 'debug' enabled.
```



### 2. 렌더링 관련 에러



#### ```Whitelabel Error Page```

```
Whitelabel Error Page
This application has no explicit mapping for /error, so you are seeing this as a fallback.

Sun Jan 19 14:42:17 MSK 2020
There was an unexpected error (type=Not Found, status=404).
No message available
```

만약 스프링부트의 에러 페이지를 사용하지 않으려면 다음과 같이 설정을 입력합니다.

```
server.error.whitelabel.enabled=false
```

만약 에러 페이지인 경우 톰캣 화면으로 나타납니다.



### 3. 메이븐 관련 에러

```No goals have been specified for this build```

메이븐의 goal가 없는 경우에 나는 메시지입니다.  메이블의 빌드 라이클 사이클은 아래와 같습니다.

```
compile => test => package => install => deploy
```

pom.xml에 ```<defaultGoal>```instlal```<defaultGoal>```을 추가해주세요.

```
[INFO] Scanning for projects...
[INFO] ------------------------------------------------------------------------
[INFO] BUILD FAILURE
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  0.151 s
[INFO] Finished at: 2020-01-19T13:30:17+03:00
[INFO] ------------------------------------------------------------------------
[ERROR] No goals have been specified for this build. You must specify a valid lifecycle phase or a goal in the format <plugin-prefix>:<goal> or <plugin-group-id>:<plugin-artifact-id>[:<plugin-version>]:<goal>. Available lifecycle phases are: validate, initialize, generate-sources, process-sources, generate-resources, process-resources, compile, process-classes, generate-test-sources, process-test-sources, generate-test-resources, process-test-resources, test-compile, process-test-classes, test, prepare-package, package, pre-integration-test, integration-test, post-integration-test, verify, install, deploy, pre-clean, clean, post-clean, pre-site, site, post-site, site-deploy. -> [Help 1]
[ERROR] 
[ERROR] To see the full stack trace of the errors, re-run Maven with the -e switch.
[ERROR] Re-run Maven using the -X switch to enable full debug logging.
[ERROR] 
[ERROR] For more information about the errors and possible solutions, please read the following articles:
[ERROR] [Help 1] http://cwiki.apache.org/confluence/display/MAVEN/NoGoalSpecifiedException
```





#### ```The method builder() is undefined for the type```

JPA설정시 사용하는 JAR중에 lombok의 경우 STS에 연결이 안될 수 있습니다. 아래 과정으로 조치합니다.

1. STS를 닫습니다.
2.  https://projectlombok.org/download에서 jar파일을 받습니다.
3. 해당 jar파일을 엽니다.
4.  https://projectlombok.org/setup/eclipse 단계를 따라 설치합니다.
   1. 맥 사용자의 경우 STS를 설치한뒤, 응용 프로그램에 설치된 STS를 선택합니다.
      1. STS 선택시 폴더 창이 뜨며 ecipse 디렉터리 내에 있는 STS.ini를 선택합니다.
5. IDE를 엽니다.
6. ```About Spring Tool Suite 4```에 대하여 메뉴를 선택합니다.





```A component required a bean of type 'javax.persistence.EntityManagerFactory' that could not be found.```

```
***************************
APPLICATION FAILED TO START
***************************

Description:

A component required a bean of type 'javax.persistence.EntityManagerFactory' that could not be found.


Action:

Consider defining a bean of type 'javax.persistence.EntityManagerFactory' in your configuration.
```



```Caused by: java.sql.SQLSyntaxErrorException: Table 'happygrammer.SPRING_SESSION' doesn't exist```

```
spring.session.jdbc.initialize-schema: always
```



```Loading class `com.mysql.jdbc.Driver'. This is deprecated. The new driver class is `com.mysql.cj.jdbc.Driver'. The driver is automatically registered via the SPI and manual loading of the driver class is generally unnecessary.```

AS-IS

```
spring.datasource.driver-class-name=com.mysql.jdbc.Driver
```

TO-BE

```
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
```

