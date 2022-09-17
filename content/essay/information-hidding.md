---
title: "정보 은닉과 추상화"
date: 2020-12-31T16:03:20+03:00
draft: false
---

소프트웨어 개발에서 `캡슐화`는 여러 기능을 하나의 기능으로 묶은 재사용 단위를 의미하며 번들링이라고도 불린다. `추상화`는 내부 기능을 사용하기 쉽도록 정의한 인터페이스를 의미한다. `정보 은닉`는 세부 구현을 숨겨 쉬운 사용을 돕고 내부의 기능을 참조 하지 못하도록 차단해 부주의한 사용을 막는 개념이다.



### 인터페이스를 이용한다.

자동차 운전자는 엔진의 구조를 알지 못해도 자동차에서 제공하는 핸들, 엑셀레이터, 브레이크 등의 `인터페이스`를 이용해 자동차를 운전할 수 있다. 자동차를 운전하기 위해 내부 동작을 모두 알지 못해도 된다. 자동차를 만들때 불필요한 정보는 정보 은닉하고, 복잡한 내부 동작을 추상화한 `인터페이스`(핸들, 엑셀레이터, 브레이크 등)만을 운전자에게 제공하면 된다.



### 인터페이스로 이해한다.

소프트웨어 설계는 UML(Unified Model Language)를 이용해 작성한다. UML에서 인터페이스는 다이어그램이다. 다이어그램 간의 관계만 보면 내부 기능에 알지 못하더라도 데이터의 흐름과 구조를 보다 쉽게 이해할 수 있다.






