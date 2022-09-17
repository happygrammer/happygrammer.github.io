---
title: "Spring Boot Mariadb"
date: 2020-03-01T13:15:27+03:00
draft: true
---



### 의존성 추가

```
<dependency>
		<groupId>mysql</groupId>
		<artifactId>mysql-connector-java</artifactId>
</dependency>
```



spring boot에서는 `starter-data-jpa` 의존성을 추가하면, 별도 persistence.xml 설정을 하지 않아도 됩니다. 다만 아래와 같이 application.properties에 [설정](https://docs.spring.io/spring-boot/docs/current/reference/html/howto.html#howto-data-access)을 추가해 주면 됩니다.

```
spring.datasource.url=jdbc:mysql://localhost/test
spring.datasource.username=dbuser
spring.datasource.password=dbpass
spring.datasource.driver-class-name=com.mysql.jdbc.Driver
```



### 관계 맺기

```
@ManyToOne
@JoinColumn(name="cart_id", nullable=false)
private Cart cart;
```



```
@OneToMany(mappedBy="cart")
private Set<Items> items;
```

