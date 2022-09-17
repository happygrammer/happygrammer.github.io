---
title: "스프링부트에 JPA 설정하기"
date: 2019-11-20T06:37:32+03:00
draft: true
---

JPA를 이용하면 자바 객체를 자동으로 테이블을 생성합니다.



스프링부트에서 JPA를 사용하려면 아래와 같은 의존성을 추가합니다.

```
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>2.1.7.RELEASE</version>
        <relativePath/> <!-- lookup parent from repository -->
    </parent>
    <groupId>com.example</groupId>
    <artifactId>accessing-data-jpa</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <name>accessing-data-jpa</name>
    <description>Demo project for Spring Boot</description>

    <properties>
        <java.version>1.8</java.version>
    </properties>

    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-jpa</artifactId>
        </dependency>

        <dependency>
            <groupId>com.h2database</groupId>
            <artifactId>h2</artifactId>
            <scope>runtime</scope>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>

```

### Entity

```
@Entity
@Table(value = "member")
@Transactional
public class Member {
	
	@Id
	@GeneratedValue
	private int user_n;

	public int getUser_n() {
		return user_n;
	}

	public void setUser_n(long user_n) {
		this.user_n = user_n;
	}
}
```



### 레파지토리 인터페이스

인터페이스를 만들어 주고, IntentRepository가 어떤 클래스의 Repository인지를 설정합니다. 그리고 두번째 전달할 인자는 프라이머리 키의 자료형입니다. 

```
<Intent, Integer>
```

```
package com.dm;

import org.springframework.data.jpa.repository.JpaRepository;

public interface IntentRepository extends JpaRepository<Intent, Integer>{

}

```



오류

```
***************************
APPLICATION FAILED TO START
***************************

Description:

The bean 'intentRepository' could not be registered. A bean with that name has already been defined and overriding is disabled.

Action:

Consider renaming one of the beans or enabling overriding by setting spring.main.allow-bean-definition-overriding=true
```

위 안내와 같이 설정 추가

```
# Bean Overriding 을 허용
spring.main.allow-bean-definition-overriding=true
```

