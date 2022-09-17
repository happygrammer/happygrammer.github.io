---
title: "Rust if 조건문"
date: 2020-12-31T09:39:24+03:00
draft: false
---

### if 문

if 문은 조건이 참인지 거짓인지를 판단하고 분기를 수행한다.

```
fn main() {
    let n = 1;

    if n < 0 {
        print!("{}는 음수 입니다.", n);
    } else if n > 0 {
        print!("{}은 양수 입니다.", n);
    } else {
        print!("{}은 0입니다.", n);
    }
}
```

실행 결과

```
1은 양수 입니다.
```

### 조건부 할당

변수에 초깃값을 할당 할때 다른 언어와 유사하게 삼항 연산자를 이용할 수 있다.

```
let n = 1;
let is_positive = if n > 0 { true } else { false }; // true
```

위 삼항 연산자는 연산자의 조건이 참과 거짓으로 제한되어 3개 이상의 조건 기술은 깊이 2 이상의 조건 문이 필요하다.

```
let n = 1;
let is_positive2 = if n >= 0 { if n>0 {true} else{false} } else { false }; // true
```

rust는 3개 이상의 조건을 고려해 초기값을 할당을 위해 `if, else if, else` 구문을 지원한다.

```
fn main() {
    let n = 1;
    let result = if n < 0 {
        format!("{}은 음수 입니다.", n)
    } else if n > 0 {
        format!("{}은 양수 입니다.", n)
    } else {
        format!("{}은 0 입니다.", n)
    };
    println!("{}",result);
}
```

실행 결과

```
1은 양수 입니다.
```


