---
title: "Use_strict"
date: 2014-11-28T08:17:03+09:00
draft: false
---

`use strict` 키워드는  ECMAScript 언어 사양(5번째 버전)에 포함되어 있다. ECMA스크립트는 ECMA-262에 의해 표준화된 언어의 이름이다. 자바스크립트와 J스크립트는 모두 ECMA스크립트와의 호환을 목표로 하면서, ECMA 규격에 포함되지 않는 확장 기능을 제공한다. 자바스크립트 라이브러리를 보다보면 `strict mode` 키워드를 만나볼 수 있다. `strict mode`는 자바스크립트를 좀더 엄격하게 다루고자 하는 의미이다.



## Strict Mode를 사용하는 두가지 이유 

- 모듈화 작업시 모호한 변수선언에 대해 제한과 엄격한 규칙을 통한 오류 발생 가능성을 낮춘다. 

- 전역변수와 지역변수간 Scope에 따른 변수 충돌을 방지할 수 있다.  

 

## Strict Mode의 예외 상황

Strict 모드를 적용을 통해 속성제약을 할 수 있다. 속성제약은 곧 좀더 엄격한 의미에서 자바스크립트의 규칙을 적용하겠다는 것이다. 다음 사례는 strict mode 사용시 제한되는 상황이다.

- delete 사용을 막는다.

```
'use strict';
var x;
delete x;   // synctax 에러 발생, delete 대신 x = null 을 할당해서 삭제한다.
```



- 한 속성을 여러번 정의하는 형태를 막는다.

```
var testObj = {
    prop1: 10,
    prop2: 15,
    prop1: 20   // synctax 에러 발생
};
```

- 매개변수가 중복되는 상황을 막는다.

```
function testFunc(param1, param1) {   // synctax 에러 발생
    return 1;
};
```

 

## Strict 선언위치

1. ### 전역에서 사용

   `use strict`를 전역에 선언하면 모든 함수와 전역에 존재하는 모든 변수에 `strict`가 적용된다.

```
"use strict";

function testFunction(){
    var testvar = 4;
    return testvar;
}
testvar = 5;  // synctax 에러 발생
```

2. ###  함수내

   함수 내에 `use strict`를 선언하면 함수 내에만 적용된다.

```
x = 3.14; // synctax 에러가 발생하지 않음
myFunction();
function myFunction() {
   "use strict";
    x = 3.14;
}
```

