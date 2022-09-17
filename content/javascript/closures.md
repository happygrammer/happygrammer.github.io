---
title: "클로저란 무엇인가?"
date: 2021-08-01T08:45:28+03:00
draft: false
---

## 내부 함수와 외부 함수

자바스크립트는 기본적으로 함수 내부에 내부 함수 선언을 지원한다. 이렇게 내부에 함수를 중복해서 중첩(nested) 형태로 선언이 가능하며, 외부 함수는 내부 함수를 포함하는 형태로 선언이 가능하다.

```
function init() { // 외부 함수 
  function message() {  // 내부 함수
    return "happyg"; // lexical scope에 선언된 로컬 변수인 name 응답 가능
  }
  return message();
}
document.write(init()); // 외부에서는 내부 함수가 message인지 알 수 없다.
```

외부 함수인 init이  내부 함수인 message 를 포함한 선언 형태이다. 여기서 외부 함수인 init은 내부에 함수를 포함하고 있어 `중첩 함수가 된다.



## 렉시컬 스코프란 무엇인가?

렉시컬 스코프(lexical scope)는 외부 변수를 통해 내부 함수로 접근 가능한 영역을 의미한다. 한번 초기화가 이뤄지면 이후 초기화 없이 접근이 가능하기에 스태틱 스코프(static scope)라고도 불린다. 렉시컬 스코프를 외부 변수로 선언한 형태의 예제는 다음과 같다.

[예제1](https://jsfiddle.net/happygrammer/fox5hjzr/8)

```
function init() {
  /* lexical scope 시작 */
  var name = 'happyg';
  function message() {  // 내부 함수
    return name; // 로컬 변수 name을 캡쳐해서 사용할 수 있음
  }
  return message(); // return 콜백
  /* lexical scope 끝 */
}
myMessage = init()
document.write(myMessage);
```

결과

```
happyg
```

위 예제는 내부 함수인 message 를 호출 하기 위해  init 함수를 외부 변수인 myMessage 에 할당했고, 해당 변수를 이용해 내부 함수인 message 를 호출했다. 자바스크립트가 실행 되면 실행 시점에 myMessage 변수에 init() 함수를 정적 스코핑으로 처리해 초기화 했기 때무에 이후 실행에는 별도 초기화 없이 호출이 가능하다.

```
document.write(myMessage);
```

로컬 name은 고정되면 안되기 때문에 매개변수 방식으로 변경을 고려할 수 있다.

```
function init(name) { // 내부 함수로 값 전달을 하려면 외부 함수에 매개변수가 선언 되어 있어야함
  /* lexical scope 시작 */
  return function(name) {  // return 콜백을 없애고, 내부 함수를 리턴 콜백 함수 형태로 변경
    return name;
  };
  /* lexical scope 끝 */
}
myMessage = init(""); // init 함수 초기화(빈 값으로 전달)
document.write(myMessage("happyg")); // 중복해서 값 전달
```

위 예제는 init 함수를 초기화해 myMessage 변수로 할당 하기 위해, 빈 값으로 초기화하고 있다.

```
myMessage = init(""); // init 함수 초기화(빈 값으로 전달)
```

내부 함수의 매개변수가 확장 되거나 축소 될때 외부 함수 선언에 의존되는 제한이 있다.

```
function init(name) { // 내부 함수의 매개 변수 개수와 일치 시킴
    return function(name) {
       ...
    }
}
```

이를 개선하기 위한 방식으로 체이닝 방식을 이용할 수 있다.



## 렉시컬 스코프 체이닝

체이닝 방식을 이용하면 렉시컬 스코프 내의 내부 함수를 개별로 호출할 수 있다. 내부 함수를 체이닝 방식으로 개선한 예는 다음과 같다.

[예제2](https://jsfiddle.net/happygrammer/fox5hjzr/27/)

```
myMessage = {
  /* lexical scope 없음 */
  message: function(name) {  // 내부 함수
    return name;
  },
  message2: function(name) {  // 내부 함수
    return name;
  }
  /* lexical scope 없음 */
}
document.write(myMessage.message("happyg")+"<br>");
document.write(myMessage.message2("happyg"));
```

```
happyg
happyg2
```

위 예제에서 myMessage 변수는 message 콜백 함수, message2 콜백 함수 선언을 포함한다. 그런데 위 예제에서는 여러 함수로 분기해서 작성할 수 있어 실용적이기는 하지만 lexical scope가 존재하지 않아 각 내부 함수가 로컬 변수에 접근할 수 없어 클로저로 부를 수 없다. 위 체이닝 형태의 장점을 살려 private한 클로저의 형태를 유지하면서 공개적 성격의 예제는 다음과 같이 작성할 수 있다.

예제3

```
var myMessage = (function() {
  /* lexical scope 시작 */
  var world = "world";
  function getMessage(val) { // 클로저 함수(private 성격)
    return val+" "+world; // 로컬 변수 world에 접근 가능
  }

  return {
    message: function(name) { // 공개 함수(public)
      return getMessage(name); // 클로저 함수 호출
    },

    message2: function(name) { // 공개 함수(public)
      return getMessage(name); // 클로저 함수 호출
    }
  };
  /* lexical scope 끝 */
})();
document.write(myMessage.message("happyg")+"<br>");
document.write(myMessage.message2("happyg"));
```

실행결과

```
happyg world
happyg world
```

message, message2 함수는 private 형태로 작성된 클로저 함수로 접근하였다. 클로저를 이용하면 private 한 함수와 public한 함수를 구분해서 클래스와 같은 형태의 중첩 함수를 개발할 수 있음을 알 수 있다.



## 클로저란 무엇일까?

클로저는 다른 객체 지향 언어처럼 class가 없는 상황에서 private 함수(클로저)와 public 함수를 구분해서 처리할 수 있는 일종의 자바스크립트 테크닉이 라 할 수 있다. 클로저를 정리해 보자면 크게 2가지 특성이 있다.

1. 클로저는 `렉시컬 스코프(lexical scope)`에 존재하는 익명의 `내부 함수`를 의미한다.

```
function init() {
  var name = 'happyg';
  function message() {  // 내부 함수
    return name;
  }
  return message(); 
}
document.write(init());
// 외부에서는 내부 함수가 message인지 알 수 없다.
```

2. 클로저인 내부 함수는 레시컬 스코프에 선언된 로컬 변수에 접근할 수 있다는 특성이 있다.

```
function init() {
  var name = 'happyg';
  function message() { 
    return name; // 로컬 변수 name를 캡쳐해 사용할 수 있음
  }
  return message(); 
}
```

결론, 클로저는 private 함수로 관리되는 외부에서 봤을때 익명인 클로저 함수와, 이들 클로저 함수에 접근하기 위한 공개 함수를 작성해 활용할 수 있다.

```
var myMessage = (function() {
  /* lexical scope 시작 */
  var world = "world";
  function getMessage(val) { // 클로저 함수(private 성격)
    return val+" "+world; // 로컬 변수 world에 접근 가능
  }

  return {
    message: function(name) { // 공개 함수(public)
      return getMessage(name); // 클로저 함수 호출
    },

    message2: function(name) { // 공개 함수(public)
      return getMessage(name); // 클로저 함수 호출
    }
  };
  /* lexical scope 끝 */
})();
```

클로저 프로그래밍의 경우 관리가 어렵고 난해할 수 있어 이를 좀더 손쉽게 하려면 [타입스크립트 클래스](https://www.typescriptlang.org/docs/handbook/classes.html)를 이용할 수 있다. 타입스크립트는 class 문법을 이용해 클로저 방식에서 처리하려던 private, public에 대한 처리를 지원한다.
