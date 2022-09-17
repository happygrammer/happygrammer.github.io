---
title: "Spring Cloud Gateway를 이용한 다이나믹 라우팅"
date: 2022-03-06T10:22:18+09:00
draft: true
---

`라우팅`은 마이크로서비스 아키텍처의 부분이다. /product를 `/group/product`와 같은 URL로 라우팅을 처리할 수 있다. 웹 애플리케이션을 제작하다보면 1개의 웹앱인데 다수의 백엔드 서버들로 구성되어 있음을 알 수 있다. 이때 하나의 웹 애플리케이션에서 호출하는 백엔드 서버는 목적 별로 `회원관리 API`, `상품주문 API`와 같이 다수로 구성되어 있을 수 있다. 동일한 경로에서 다수의 사이트를 호출하는 경우는 CORS와 같은 문제가 발생할 수 있는데, 이러한 CORS 문제가 발생하지 않도록 맨 앞단에 Gateway 서버를 두고 라우팅해서 다수의 웹애플리케이션을 구성하는것과 같다. 백엔드 서버의 종류가 많고 각기 다른 서버들로 구성되어 있지만 마치 하나의 웹애플리케이션 동작할 수 있도록 해준다.

이러한 Gateway서버들의 종류는 다음과 같다.

- Spring cloud gateway
- Netflix Zuul
- kong
- ServiceComb EdgeService

라우팅은 `org.springframework.cloud` 그룹에 속하는 Spring Boot 기반에서 동작하는 도구들의 집합중 `Spring Cloud Gateway`에서 제공한다.

[참고] [Spring Cloud](https://spring.io/projects/spring-cloud)의 주요 컴포넌트

```
- Spring Cloud Netflix(Eureka, Hystrix, Zuul, Archaius, etc.).
- Spriung Cloud Config(Configuration)
- Spring Cloud GateWay : Project Reactor기반의 프로그래밍 가능한 라우터
- ...
```

위 `Spring Cloud Gateway`가 있기 전에는 넷플릭스는 [zuul](https://github.com/Netflix/zuul/wiki)이라는 넷플릭스 OOS(Open Source Software)가 있고,  `zuul`을 이용해 백엔드 서버들을 라우팅을 처리할 수 있는 `Gateway`서버를 구축할 수 있었다. Zuul 1에서는 비동기 방식을 지원하지 않다고 zuul 2가 되면서 비동기 방식을 지원하게 되었다. 그러나 아쉽게도 `zuul`은 2018년 12월 이후 유지보수 모드로 전환되었다.

- 프리 필터 : 라우팅 전 실행하는 필터
- 라우트 필터 : 라우트시에 자신만의 라우트 로직을 반영 가능
- 포스트 필터 : 라우팅 이후에 ....
- 에러 필터 : 필터에서 에러가 발생한 경우

또한 Spring에서는 Zuul 이 다른 Spring Cloud 라이브러리 호환성 문제가 있어 Spring Gateway 사용을 권장하고 있다. 대체 가능한 모듈은 다음과 같다.

| 현재                        | 대체                                                         |
| --------------------------- | ------------------------------------------------------------ |
| Hystrix                     | [ Resilience4j](https://github.com/resilience4j/resilience4j) |
| Hystrix Dashboard / Turbine | Micrometer + Monitoring System                               |
| Ribbon                      | Spring Cloud Loadbalancer                                    |
| Zuul 1                      | Spring Cloud Gateway                                         |
| Archaius 1                  | Spring Boot external config + Spring Cloud Config            |



### Spring 클라우드 게이트웨이

Spring Cloud Gateway는 클라이언트 요청을 받아 어떤 서버를 호출할지를 중재하고, 인증의 처리를 담당하고 있어, Reverse Proxy 서버 역할을 한다. NGINX 웹서버로 Proxy를 구성할 수 있지만 보다 다양한 요구 사항을 처리하려면 Spring 클라우드 게이트웨이가 필요하다.

SCG는 크게 세가지 요소로 구성된다.

- Route : 라우팅할 대상 URI, 고유 ID
- Preicate : 라우팅 조건,  헤더와 전달된 요청 정보가 HTTP 요청이 조건에 맞는지
- Filter : 다운스트림 요청 전/후 응답을 추가, 수정할 수 있다.



![](https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2F4WJhG%2FbtqW4hdxvTj%2FXHpJWMP98kgdVWKj3oNPzk%2Fimg.png)



![](https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FlQYm5%2FbtqWWr2C2Y9%2FOKcLJkHzMKTeshh5cVRaz0%2Fimg.jpg)

Zuul은 Web/WAS로 Tomcat를 사요한다. SCG는 [Netty](https://netty.io/)를 사용한다.





### Spring 클라우드 게이트웨이

간단한 실습을 해보고자 한다.



### 필터

[필터](https://www.baeldung.com/spring-cloud-custom-gateway-filters) 를 정의한다.

```
spring:
  cloud:
    gateway:
      routes:
      - id: service_route
        uri: http://localhost:8081
        predicates:
        - Path=/service/**
        filters:
        - RewritePath=/service(?<segment>/?.*), $\{segment}
```

- id: 해당 라우트의 고유 ID이다. 중복되면 작동을 안할 수 있다.
- uri: 라우팅할 대상의 URI (해당 URI의 정보를 응답함)
- predicates: 해당 라우터의 path 조건, `/service/**`으로 시작하는 path에 대해 라우팅 처리
- filters:  라우터 필터, RewritePath는 path를 재작성함



### predicates

[predicate](https://cloud.spring.io/spring-cloud-gateway/2.1.x/multi/multi_gateway-request-predicates-factories.html)의 종류는 다음과 같다.

|         |                                |                         |                    |
| ------- | ------------------------------ | ----------------------- | ------------------ |
| After   | 특정 날짜 이후 호출 가능       | 특정 시점 이후 API 오픈 |                    |
| Before  | 특정 날짜 까지만 호출 가능     | 특점 시점에 API 닫기    |                    |
| Between | 지정한 날짜 기간에만 호출 가능 | 특정 기간에만 API 제공  |                    |
| Weight  | 그룹별로 라우팅을 분배함       |                         |                    |
| Method  | 요청 Method POST/GET           | 지정                    | \- Method=GET,POST |

예를 들어 predicates에 Before를 추가해 해당 시점까지만 API를 제공할 수 있다. 해당 날짜 이후는 API응답을할 수 없으므로 API를 deprecated처리할 때 유용하게 사용할 수 있다.

```
        predicates:
        - Path=/multi/**
        - Before=2022-08-20T19:10:10.126+09:00[Asia/Seoul]
```



Weight

```
routes:
    -   id: weather-service-high
        uri: http://localhost:8181
        predicates:
            - Path=/weather/**
            - Weight=group-weather, 7
        filters:
            - RewritePath=/weather/(?<path>.*),/$\{path}

    -   id: weather-service-low
        uri: http://localhost:8787
        predicates:
            - Path=/weather/**
            - Weight=group-weather, 3
        filters:
            - RewritePath=/weather/(?<path>.*),/$\{path}

```

(예제 수정필요)

/weather URL에 대해 weight를 조절하는데, 이때 7:3비율로 분배한다.



요청을 보낸 RemoteAddr이 192.168.1.1/24인 경우는 https://example.org 로 포워딩한다.

```
spring:
  cloud:
    gateway:
      routes:
      - id: remoteaddr_route
        uri: https://example.org
        predicates:
        - RemoteAddr=192.168.1.1/24
```



### Global Filter

글로벌 필터는 모든 라우터에서 정의되는 필터이다. 글로벌 pre 필터클래스를 정의한다.







src/main/java/gateway/Application.java

```
@Bean
public RouteLocator myRoutes(RouteLocatorBuilder builder) {
    return builder.routes().build();
}
```

자바 컨피그로 Route 구성하려면 다음과 같은 코드를 이용한다.

```
@Bean
public RouteLocator myRoutes(RouteLocatorBuilder builder) {
    return builder.routes()
        .route(p -> p
            .path("/get")
            .filters(f -> f.addRequestHeader("Hello", "World"))
            .uri("http://httpbin.org:80"))
        .build();
}
```

라우트가 추가되면 /get 요청을 받아서 `http://httpbin.org:80`으로 호출한 응답을 받는다. 위 설정은 *가 적용되지 않는다.  즉 다음과 같은 형태의 URL은 라우팅되지 않는다.

```
http://localhost:8080/get/test
```

여러 라우터를 설정하려면 다음과 같이 선언한다.

```
@Configuration
public class FilterConfig{
    @Bean
    public RouteLocator gatewayRoutes(RouteLocatorBuilder builder){
        return builder.routes()
                .route(r -> r.path("/first-service/**")
                            .filters(f -> f.addRequestHeader("first-request", "first-request-header")
                            .addResponseHeader("first-response", "first-response-header"))
                            .uri("http://localhost:8081")
                )
                .route(r -> r.path("/second-service/**")
                            .filters(f -> f.addRequestHeader("second-request", "second-request-header")
                            .addResponseHeader("second-response", "second-response-header"))
                            .uri("http://localhost:8082")
                )
                .build();
    }
}
```

filters는 여러개 설정하려면 다음과 같이한다.



이때 Header의 키:값을 설정한다.

```
{
  "args": {}, 
  "headers": {
    "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9", 
    "Accept-Encoding": "gzip, deflate, br", 
    "Accept-Language": "ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7", 
    "Cache-Control": "max-age=0", 
    "Content-Length": "0", 
    "Forwarded": "proto=http;host=\"localhost:8080\";for=\"[0:0:0:0:0:0:0:1]:64673\"", 
    "Hello": "World", 
    "Host": "httpbin.org", 
    "Sec-Ch-Ua": "\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"99\", \"Google Chrome\";v=\"99\"", 
    "Sec-Ch-Ua-Mobile": "?0", 
    "Sec-Ch-Ua-Platform": "\"macOS\"", 
    "Sec-Fetch-Dest": "document", 
    "Sec-Fetch-Mode": "navigate", 
    "Sec-Fetch-Site": "none", 
    "Sec-Fetch-User": "?1", 
    "Upgrade-Insecure-Requests": "1", 
    "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.84 Safari/537.36", 
    "X-Amzn-Trace-Id": "Root=1-6253be40-524952f0222aa8a3612ba52a", 
    "X-Forwarded-Host": "localhost:8080"
  }, 
  "origin": "0:0:0:0:0:0:0:1, 222.103.113.246", 
  "url": "http://localhost:8080/get"
}
```



### 설킷 브레이커





### Ribbon - Client 사이드 로드밸런스

![](https://www.codeusingjava.com/ribbondig-min.JPG)

RoundRobinLoadBalancer

@LoadBalancedClient





### 참고 사이트

- https://cloud.spring.io/spring-cloud-netflix/multi/multi__router_and_filter_zuul.html

- https://dahye-jeong.gitbook.io/spring/
