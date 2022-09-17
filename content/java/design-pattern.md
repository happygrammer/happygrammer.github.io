---
title: "디자인 패턴 설계 원칙"
date: 2020-10-20T07:07:18+03:00
draft: true
---

## 디자인 패턴 설계 원칙

1. 클래스가 아닌 인터페이스를 이용 : 구현 클래스의 영향도를 최소화할 수 있다.
2. 상속(Inheritance)가 아닌 위임(Delegation)
   - 상속은 컴파일시 수퍼클래스와 서브클래스 구조가 결정됨.
   - 위임은 런타임시 필요한 클래스를 생성.
3. 커플링을 최소화 한다
   - God Class를 만들지 않고, 한 클래스의 변화가 전체 클래스를 변화되지 않게 한다.



## GoF 디자인 패턴

### 생성패턴

- Factory Method
- Abstract Factory
- Builder
- Prototype
- Singleton

### 구조패턴

- Adaptor
- Bridge
- Composite
- Decorator
- 파사드(Facade) : 복잡한 서브 시스템클래스에 대한 단일화된 고수준 인터페이스를 정의해 서브시스템 사용을 돕는 패턴
- Flyweight
- Proxy

### 행위패턴

- Command
- Chain of Responsibility
- Mediator
- Interpreter
- Iterator
- Observer
- State
- Strategy
- Template
- Visitor

