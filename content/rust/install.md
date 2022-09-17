---
title: "Rust 설치하기"
date: 2020-06-07T14:35:56+03:00
draft: false
---

리눅스, 맥OS 환경이면 명령 인터페이스 1줄로 Rust 설치가 가능하다.



### Rust 설치 명령

Rust 설치는 `rustup`를 다운로드 하여 설치 하는 명령어이다.

```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```



### 설치 과정

```
Welcome to Rust!

This will download and install the official compiler for the Rust
programming language, and its package manager, Cargo.

It will add the cargo, rustc, rustup and other commands to
Cargo's bin directory, located at:

  /Users/smarthome/.cargo/bin

This can be modified with the CARGO_HOME environment variable.

Rustup metadata and toolchains will be installed into the Rustup
home directory, located at:

  /Users/smarthome/.rustup

This can be modified with the RUSTUP_HOME environment variable.

This path will then be added to your PATH environment variable by
modifying the profile files located at:

  /Users/smarthome/.profile
/Users/smarthome/.bash_profile

You can uninstall at any time with rustup self uninstall and
these changes will be reverted.

Current installation options:


   default host triple: x86_64-apple-darwin
     default toolchain: stable
               profile: default
  modify PATH variable: yes

1) Proceed with installation (default)
2) Customize installation
3) Cancel installation
```

설치 옵션 중에서 디폴트 옵션인 `1`번을 선택한다.

```
info: profile set to 'default'
info: default host triple is x86_64-apple-darwin
info: syncing channel updates for 'stable-x86_64-apple-darwin'
info: latest update on 2020-06-04, rust version 1.44.0 (49cae5576 2020-06-01)
info: downloading component 'cargo'
info: downloading component 'clippy'
info: downloading component 'rust-docs'
 12.2 MiB /  12.2 MiB (100 %)   9.1 MiB/s in  1s ETA:  0s
info: downloading component 'rust-std'
 16.5 MiB /  16.5 MiB (100 %)   9.3 MiB/s in  1s ETA:  0s
info: downloading component 'rustc'
 55.9 MiB /  55.9 MiB (100 %)   9.4 MiB/s in  6s ETA:  0s
info: downloading component 'rustfmt'
info: installing component 'cargo'
info: installing component 'clippy'
info: installing component 'rust-docs'
 12.2 MiB /  12.2 MiB (100 %)   7.5 MiB/s in  1s ETA:  0s
info: installing component 'rust-std'
info: installing component 'rustc'
 55.9 MiB /  55.9 MiB (100 %)  15.8 MiB/s in  3s ETA:  0s
info: installing component 'rustfmt'
info: default toolchain set to 'stable'

  stable installed - rustc 1.44.0 (49cae5576 2020-06-01)


Rust is installed now. Great!

To get started you need Cargo's bin directory ($HOME/.cargo/bin) in your PATH
environment variable. Next time you log in this will be done
automatically.

To configure your current shell run source $HOME/.cargo/env
```



### 시스템 Path

설치 완료후 PATH를 수동으로 설정한다.

```
$ source $HOME/.cargo/env
```

이때 ~/.bash_profile에 PATH를 추가해 시스템 PATH에 등록 한다.

```
$ export PATH="$HOME/.cargo/bin:$PATH"
```



### Rust 업데이트

Rust를 업데이트 하려면 rustup 명령어를 통해 쉽게 업데이트할 수 있다.

```
$ rustup update
```

rustup은 Rust의 인스톨러 명령어다.($HOME/.cargo/bin/rustup 디렉터리에 위치함)

```
The Rust toolchain installer

USAGE:
    rustup [FLAGS] [+toolchain] <SUBCOMMAND>
```



### Hello World

설치가 완료 되었다면 Rust를 컴파일 하여 `hello, world!`를 출력 하고자 한다.

```
$ cargo new helloworld --bin
     Created binary (application) `helloworld` package
```

위 전달 오션에서 `-bin`는 바이너리 생성용 옵션이며 `-lib`는 라이브러리 생성용 옵션이다. 프로젝트 생성 후 다음과 같이 프로젝트가 구성된다.

```
./helloworld/Cargo.toml
./helloworld/src/main.rs
```

일단 hello world를 출력한다.

```
$ cargo build
   Compiling helloworld v0.1.0 (/Users/smarthome/Documents/RustTutorial/ch2/helloworld)
    Finished dev [unoptimized + debuginfo] target(s) in 0.42s
dialogui-MacBookPro:helloworld smarthome$ cargo run
    Finished dev [unoptimized + debuginfo] target(s) in 0.00s
     Running `target/debug/helloworld`
Hello, world!
```

이때 Cargo.toml는 패키징 설정 파일 역할을 한다.

```
[package]
name = "helloworld"
version = "0.1.0"
authors = ["happygrammer <happygrammer.dev@gmail.com>"]
edition = "2018"

[dependencies]
```

[main.rs]

```
fn main() {
    println!("Hello, world!");
}
```



### 언인스톨

 `rustc` 컴파일이 정상적으로 동작할 수 없는 경우 언인스톨이 필요한 경우가 있다. `rustc`를 언인스톨 하기 위해서는` rustup` 명령어이용해 언인스톨을 수행한다.

```
$ rustup self uninstall
```

그리고 재설치한다.

```
$ curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```



### Rust 설치(윈도우)

윈도우에서 Rust를 설치 하려면 https://www.rust-lang.org/tools/install의 안내를 따른다.

