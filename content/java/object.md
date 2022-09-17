---
title: "Object"
date: 2021-10-15T07:57:23+03:00
draft: true
---

POJO : getter, setter를 가진 단순 Object를 의미함

DTO  : DTO

VO : DTO와 개념이 유사 Read Only 특성,

DTO와 달리 VO는 Read-Only속성을 값 오브젝트이다.
자바에서 단순히 값 타입을 표현하기 위해 불변 클래스(Read-Only)를 만들어 사용한다.
예를 들면 빨강은 Color.RED, 초록은 Color.GREEN 이렇게 단순히 값만 표현하기 위해 getter기능만 존재한다.

VO의 핵심 역할은 equals()와 hashcode() 를 오버라이딩 하는 것이다.
