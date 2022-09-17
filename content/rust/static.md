---
title: "Static"
date: 2021-12-27T20:43:24+09:00
draft: true
---

static 변수 선언은 가능하지만, 직접적인 선언이 되지 않는다. 힙 할당은 런타임시에 수행되며 다음 예제와 같다. 

```rust
static SOME_INT: i32 = 5;
static SOME_STR: &'static str = "A static string";
static SOME_STRUCT: MyStruct = MyStruct {
    number: 10,
    string: "Some string",
};
static mut db: Option<sqlite::Connection> = None;

fn main() {
    println!("{}", SOME_INT);
    println!("{}", SOME_STR);
    println!("{}", SOME_STRUCT.number);
    println!("{}", SOME_STRUCT.string);

    unsafe {
        db = Some(open_database());
    }
}

struct MyStruct {
    number: i32,
    string: &'static str,
}
```

https://stackoverflow.com/questions/19605132/is-it-possible-to-use-global-variables-in-rust
