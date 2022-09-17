---
title: "견고한 코드 설계의 원칙들"
date: 2020-11-21T09:09:47+03:00
draft: false
---



## 코드 설계의 기본 원칙

- DRY (Don't Repeat Yourself)
  - 한번 이상 동일하거나 유사한 코드를 작성하지 않는 것이 좋다.
- SCP (Speaking Code Principle)
  - 코드는 그 목적을 전달해야 한다.
  - 코드에 주석을 추가했다는 것은 코드에 불충분한 목적이 있음을 암시 하기도 한다. 
- TDA (Tell, Don't Ask)
  - 객체에게 정보를 요구하지 말고 그냥 행위하도록 시키라.  ('[Law of Demeter'](http://en.wikipedia.org/wiki/Law_of_Demeter)와 유사)
  - 데이터 생성 객체(구현 정보 은닉, 캡슐화)로만 하고, 구체적인 타입이나 값은 넘기지 않는다.
  - 객체의 속성 보다는 행동에 집중한다.
- SOC (Separation Of Concerns)
  - 하나의 클래스 내에 여러 관심사를 혼합시키지 마라. ['Single Responsibility Principle'](https://en.wikipedia.org/wiki/Single-responsibility_principle)



## 객체지향 설계 원칙

객체 지향 특성(부록1)에 대한 객체 지향 설계 원칙은 다음과 같다.

- SRP(The Single responsibility principle) 원칙 : 모든 클래스/객체는 하나의 책임만을 지도록 합니다.

- OCP(The Open Close Principle) 원칙

  - 구성 요소(객체, 메서드 등)는 확장에 열려 있지만 변경에는 닫혀 있어야함
  - 클래스 변경으로 외부에 영향을 주어서는 안되며, 상속과 인터페이스를 이용해 OCP 구현 가능.
  - 상속 : 검증된 객체는 뇌두고 상속하는 방식을 이용
  - 인터페이스 : 인터페이스를 두어 구현 클래스에서 변경하도록 함

- LSP ( The liskov Substitution Principle) 원칙

  - 어떤 함수 q에 T타입의 객체 x가 잘 작동한다면 T타입을 생성한 객체 y도 잘 작동해야함
  - 부모 객체 자리에 자식 객체를 넣어도 동작할 수 있어야함

- ISP (The Interface Segregation Principle) 원칙

  - 한 클래스가 다른 클래스에 종속될 때는 가능한 최소한의 인터페이스를 통한다.
  - 하나의 일반적인 인터페이스보다 여러개의 구체적인 인터페이스가 낫다.
  - 클라이언트(기능을 사용하는 클래스)는 사용하지 않는 인터페이스(메소드 등)에 의존하면 안된다.

  ```
  public class 전기자동차 implements 자동차, 오디오{
    	시동걸기();
    	시동멈춤();
    	음악시작();
    	음악멈춤();
    	전기충전();
  }
  public class 디젤자동차 implements 자동차, 오디오{
    	시동걸기();
    	시동멈춤();
    	음악시작();
    	음악멈춤();
    	디젤충전();
  }
  
  // 여러개의 구체적인 인터페이스로 분리
  public interface 자동차{
    	시동걸기();
    	시동멈춤();
  }
  public interface 오디오{
    	음악시작();
    	음악멈춤();
  }
  ```

  

- DIP ( The Dependency Inversion Principle)  원칙

  - 고수준 모듈은 저수준 모듈에 종속되면 안되며 둘은 추상에 의존해야함.

  - DIP는 의존성 주입(dependency injection)의 배경이되는 원리

  - 추상적인 것은 구체적인에 의존하면 안되고 추상적인 것에 의존해야함.

  - 인터페이스, 부모 클래스, 추상 클래스 = 변할 가능성이 낮음
  - 하위 클래스, 구체 클래스 = 변할 가능성이 높음

  - 부모 클래스를 두어서 DIP를 수행하는 예시

    ```
    public class Child{
      // 변하기 쉬운 Car, Doll보다는 변하기 어려운 부모인 Tody와 의존 관계를 맺음
    	public void setToy(Toy toy){
    		toy.play();
    	}
    }
    public class Toy{
    	public void play(){ ...  }
    }
    public class Car extends Toy{}
    public class Doll extends Toy{}
    
    public class Main{
    	... main(...){
    		Toy car=new Car();
    		Toy doll=new Doll();
    		Child child=new Child();
    		child.setToy(car); // 자동차로 세팅
    		child.setToy(doll); // 인형으로 세팅
    	}
    }
    ```

    

## 패키지 설계 원칙

패키지는 응집도를 높이며, 결함도를 낮춥니다. 서로 다른 패키지간의 결합도를 낮추는 관리가 필요함.

- REP - Release/Reuse Equivalency Principle
  - 재사용 가능한 클래스 들은 하나의 패키지에 묶는다.
  - 재사용되는 요소들은 릴리즈(배포)되는 요소들임
  - 패키지의 모든 클래스는 재사용 가능해야한다.
- CCP - Common Closure Principle
  - 어떤 것을 변경해야 하면 그것 때문에 바꾸어야 할 클래스는 단 한 패키지에만 몰려 있어야한다.

- ADP - Acyclic Dependencies Principle
  - 패키지들 간의 의존성 구조는 비순환 구조여야함.
- SDP - Stable Dependencies Principle
  - 패키지는 바뀌기 않는 안정적인 패키지들에만 의존해야 함
- SAP - Stable Abstraction Principle
  - 패키지가 안정적일 수 록 매우 추상적이게 된다.
  - 패키지에 추상 클래스와 인터페이스가 많아질 수 록 패키지의 추상도도 높아진다.
  - 패키지가 안정될수록 점점 더 추상화 됨.
  - 안정적이지 못한 패키지들은 구체적(concrete)인 특성이 있음.



## 부록

##### 1) 객체지향 특성

|           특징           |                          세부 설명                           |
| :----------------------: | :----------------------------------------------------------: |
|  캡슐화 (Encapsulation)  | 멤버 메서드는 외부로 노출(public) 하지만, 내부 구현은 숨김(private) |
|   추상화 (Abstraction)   | 공통 특성이나 속성을 추출하여 코드의 재사용성과 가독성을 높임 |
|  다형성 (Polymorphism)   | 오버라이딩(하위 클래스에서 재정의), 오버로딩(매개변수의 유형과 개수를 다르게 정의) |
| 정보 은닉 (Info. Hiding) |                   객체의 세부 구현은 숨김                    |
|    상속 (Inheritance)    |          상위 클래스의 기능을 하위 크래스에서 받음           |





