---
title: "Rust 데이터 타입"
date: 2020-06-07T15:00:03+03:00
draft: false
---

Rust는 두개의 서브 데이터 타입이 있다. `scalar`와 `compound`이다. Rust는 정적 타입 언어(statically typed language)이다. 따라서 값을 기반으로 타입을 추론할 수 있지만, 모든 변수에 대한 타입을 알아야 컴파일이 가능하다.



## Scalar Types

### Integer Types

| Length  | Signed  | Unsigned |
| ------- | ------- | -------- |
| 8-bit   | `i8`    | `u8`     |
| 16-bit  | `i16`   | `u16`    |
| 32-bit  | `i32`   | `u32`    |
| 64-bit  | `i64`   | `u64`    |
| 128-bit | `i128`  | `u128`   |
| arch    | `isize` | `usize`  |



### Floating-Point Types

```
fn main() {
    let x = 2.0; // f64

    let y: f32 = 3.0; // f32
}
```



### Numeric Operation

```
fn main() {
    // addition
    let sum = 1 + 2;
    println!("{}",sum);

    // subtraction
    let difference = 10.1 - 0.2;
    println!("{}",difference);

    // multiplication
    let multiplication = 10 * 20;
    println!("{}",multiplication);

    // division
    let division = 50.5 / 30.5;
    println!("{}",division);

    // remainder
    let remainder = 53 % 5;
    println!("{}",remainder);
}
```

실행 결과

```
$ rustc main.rs
$ ./main
3
9.9
200
1.6557377049180328
3
```



## Compound Types

하나의 타입이 여러 값으로 구성 됨으로서 여러 타입이 합쳐진 타입이다. Tuple Type과 Array Type이 있다.

### Tuple Type

```
fn main() {
    let tup: (i32, f64, u8) = (500, 6.4, 1);
}
```



### Array Type

```
fn main() {
    let x: [i32; 5] = [1, 2, 3, 4, 5]; // 고정 배열
    let y: [i32; 5] = [6; 5]; // 배열의 요소를 모두 6으로 초기화

    println!("x[0]         = {}", x[0]);
    println!("x[4]         = {}", x[4]);
    println!("x[x.len()-1] = {}", x[x.len()-1]);
    println!("x.len())     = {}", x.len());
    
    println!("y[0]         = {}", y[0]);
    println!("y[4]         = {}", y[4]);
    println!("y[y.len()-1] = {}", y[y.len()-1]);
    println!("y.len()      = {}", y.len());
}
```

실행 결과

```
x[0]         = 1
x[4]         = 5
x[x.len()-1] = 5
x.len())     = 5
y[0]         = 6
y[4]         = 6
y[y.len()-1] = 6
y.len()      = 5
```

