---
title: "Java 개발자를 위한 Eclipse의 숨인 기능 101가지"
date: 2020-11-21T07:32:43+03:00
draft: true
---

개발을 할 때 도움이 되는 깨알팁을 정리해 보고자 합니다.



### 클래스 다이어그램

클래스 다이어그램은 UML(Unified Modeling Language)의 한 요소로 다음을 파악하는데 용이합니다.

- 클래스 사이의 논리적인 관계, 클래스의 속성,  메서드

설치 방법은 다음 순서로 진행합니다.

- Help->Install New Software순으로 메뉴 선택
  - Add 버튼 선택 후 http://www.objectaid.com/update/current 입력해 ObjectAid UML Explorer 설치 후 Restart

실행 순서는 다음과 같습니다.

- File->New->Other->'Object Aid Class Diagram'이라고 입력->분석할 프로젝트 지정 후 finish 버튼 선택
- *.ucls라는 파일 선택 후 클래스 파일을 끌어 다 놓으면 다이어그램이 생성 됩니다.



### 죽은코드 찾기

Problem 창을 엽니다. 이때 자바 Problem을 살펴봅니다.

 

