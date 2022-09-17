---
title: "Rust 크로스 컴파일 방법"
date: 2021-01-16T18:34:29+03:00
draft: false
---

특정 OS에서 개발한 프로그램을 다른 OS 환경에서 실행 하고 싶은 경우가 있다. [`rustup`](https://www.rust-lang.org/tools/install) 명령어(rust toolchain installer)를 이용해  대상 OS에 맞는 툴체인을 설치해 크로스 컴파일이 가능하다. 본 글은 맥 OS 환경에서 Rust 프로그램을 Linux와 Windows 플랫폼으로 크로스 컴파일하는 상황을 가정해 작성 하였다.



## rustup 명령어 알아보기

`rustup` 명령어는 러스트 툴체인 인스톨러 명령어이다. 툴체인 설정 관리 기능을 제공한다. rustup 명령어 옵션은 다음과 같다.

```
$ rustup
rustup 1.23.1 (3df2264a9 2020-11-30)
The Rust toolchain installer

USAGE:
    rustup [FLAGS] [+toolchain] <SUBCOMMAND>

FLAGS:
    -v, --verbose    Enable verbose output
    -q, --quiet      Disable progress output
    -h, --help       Prints help information
    -V, --version    Prints version information

ARGS:
    <+toolchain>    release channel (e.g. +stable) or custom toolchain to set override

SUBCOMMANDS:
    show           Show the active and installed toolchains or profiles
    update         Update Rust toolchains and rustup
    check          Check for updates to Rust toolchains
    default        Set the default toolchain
    toolchain      Modify or query the installed toolchains
    target         Modify a toolchain's supported targets
    component      Modify a toolchain's installed components
    override       Modify directory toolchain overrides
    run            Run a command with an environment configured for a given toolchain
    which          Display which binary will be run for a given command
    doc            Open the documentation for the current toolchain
    man            View the man page for a given command
    self           Modify the rustup installation
    set            Alter rustup settings
    completions    Generate tab-completion scripts for your shell
    help           Prints this message or the help of the given subcommand(s)
```

서브커맨드 옵션중에 `override 옵션`은 사용자 환경에 맞게 툴체인을 자동으로 결정할때 사용하는 옵션이다. 툴체인 설정이 잘 못 되었을때 아래 override 옵션으로 설정을 초기화할 때 사용할 수 있다. `override` 옵션은 툴체인을 자동으로 결정하기 위한 명령어이다.

```rust
$ rustup override set stable // 사용자 repo에 stable 채널 툴체인으로 설정(대부분 stable을 사용)
#$ rustup override set beta // 사용자 repo에 beta 채널 툴체인으로 설정(잘안씀)
#$ rustup override set nightly // 사용자 repo에 nightly 채널 툴체인으로 설정(잘안씀)
```

만약 사용자 환경의 디폴트 툴체인을 채널별로 설정하고자 한다면  `default` 옵션을 이용해 디폴트 툴체인을 설정할 수 있다.

```
$ rustup default stable // stable 툴체인
#$ rustup default beta // beta 툴체인 (잘안씀)
#$ rustup default nightly // nightly 툴체인(잘안씀)
```

앞서 언급한 대로 툴체인은 릴리즈 채널에 따라 stable, beta, nightly 방식으로 설치 한다. 현재 플랫폼 기준으로 stable, beta, nightly를 구분해 툴체인 설치하려면 다음 명령어를 이용할 수 있다.

```
$ rustup toolchain install stable
$ rustup toolchain install beta
$ rustup toolchain install nightly
```

 [러스트는 릴리즈](https://github.com/rust-lang/rust/blob/master/RELEASES.md) 채널에 따라 `Nightly`, `Beta`, `Stable`로 나뉜다. `Stable` 은 6주를 주기로 릴리즈 되며 `Beta`는 차기 `Stable` 릴리즈 전에 배포된다. `Nightly`는 매일 밤 릴리즈가 된다. 러스트 개발자는 대부분 `Stable` 채널을 이용한다. 최신 버전의 릴리즈를 업데이트 하려면  `rustup update`  명령어를 입력한다. `rustup` 명령어는 기본적으로 `stable`을 디폴트로 채널로 사용한다.

```
$ rustup update
info: syncing channel updates for 'stable-x86_64-apple-darwin'
info: syncing channel updates for 'stable-x86_64-pc-windows-gnu'
info: syncing channel updates for 'stable-x86_64-pc-windows-msvc'
info: syncing channel updates for 'stable-x86_64-unknown-linux-gnu'
info: syncing channel updates for 'stable-x86_64-unknown-linux-musl'
info: syncing channel updates for 'nightly-x86_64-apple-darwin'
...
```

설치된 툴체인 목록이 무엇이고, 디폴트 툴체인에 대한 목록을 간략히 확인 하려면 다음 명령어를 입력한다.

```
$ rustup toolchain list
stable-x86_64-apple-darwin
stable-x86_64-pc-windows-gnu
stable-x86_64-pc-windows-msvc
stable-x86_64-unknown-linux-gnu
stable-x86_64-unknown-linux-musl
nightly-x86_64-apple-darwin (default)
```

만약 설치된 툴체인들에 대한 전반적인 목록과 활성 상태 목록을 확인 하고자 한다면  show 옵션만 붙인다.

```
$ rustup show
Default host: x86_64-apple-darwin
rustup home:  /Users/<사용자계정홈>/.rustup

installed toolchains
--------------------

stable-x86_64-apple-darwin
stable-x86_64-pc-windows-gnu
stable-x86_64-pc-windows-msvc
stable-x86_64-unknown-linux-gnu
stable-x86_64-unknown-linux-musl
nightly-x86_64-apple-darwin (default)

installed targets for active toolchain
--------------------------------------

x86_64-apple-darwin
x86_64-pc-windows-gnu
x86_64-unknown-linux-gnu
x86_64-unknown-linux-musl

active toolchain
----------------

nightly-x86_64-apple-darwin (default)
rustc 1.51.0-nightly (bc39d4d9c 2021-01-15)

```

다음은 주요한 툴체인 설치 관리 서브 명령이다.

```
SUBCOMMANDS:
    list      List installed and available components
    add       Add a component to a Rust toolchain
    remove    Remove a component from a Rust toolchain
    help      Prints this message or the help of the given subcommand(s)
```

list 서브 옵션을 전달하면 설치 가능한 툴체인 목록을 확인할 수 있다.

```
$ rustup component list
cargo-x86_64-apple-darwin (installed)
clippy-x86_64-apple-darwin (installed)
llvm-tools-preview-x86_64-apple-darwin
miri-x86_64-apple-darwin
rls-x86_64-apple-darwin
rust-analysis-x86_64-apple-darwin
rust-analyzer-preview-x86_64-apple-darwin
...
```

툴체인은 실재 다음에 해당하는 로컬 경로에 설치된다.

```
ls /Users/<사용자계정명>/.rustup/toolchains
nightly-x86_64-apple-darwin             stable-x86_64-pc-windows-gnu            stable-x86_64-unknown-linux-gnu
stable-x86_64-apple-darwin              stable-x86_64-pc-windows-msvc           stable-x86_64-unknown-linux-musl
```



## Linux용으로 빌드

맥OS 환경에서 Linux 용으로 컴파일 하기 위해 맥 OS 패키지 관리 도구인 홈브류 명령어를 이용해 [musl-cross](https://github.com/FiloSottile/homebrew-musl-cross)를 설치한다. musl-cross는 FiloSottile 개발자가 공개한 맥 OS에서 사용 가능한 리눅스 크로스 컴파일러이다.

```none
$ brew install FiloSottile/musl-cross/musl-cross  // 약 15분 소요
$ brew install gcc // gcc 설치
# $ brew cleanup // 최신 패키지 제외한 나머지 패키지 정리(필요시)
```

rustup 명령어를 이용해 툴체인 설치를 진행한다. 현재 플랫폼과 리눅스 용으로 크로스 컴파일을 위해서 `stable-x86_64-unknown-linux-musl` 툴체인을 설치해야 한다.

```
$ rustup toolchain install stable-x86_64-unknown-linux-musl // 삭제는 install 대신 uninstall 이용
$ rustup target add x86_64-unknown-linux-musl
```

Rust는 기본적으로 정적 링킹 방식으로 사용자 코드를 컴파일 하며, 표준 라이브러리를 사용할때 동적 링킹 방식(Dynamic linking)으로 라이브러리를 호출해 컴파일 한다. 만약 리눅스로 포팅하려 한다면 [MUSL Lib](https://www.musl-libc.org/intro.html)를 기반으로한 정적 링킹 방식을 고려해 컴파일을 해야 한다. 리눅스용 컴파일을 위해 먼저 `rustup target add` 명령어를 이용해 `x86_64-unknown-linux-musl`가 활성 툴체인 목록에 추가됨을 확인할 수 있다.

```
$ rustup target add x86_64-unknown-linux-musl
...

installed targets for active toolchain
--------------------------------------

x86_64-apple-darwin
x86_64-pc-windows-gnu
x86_64-unknown-linux-musl // 추가됨
```

이어서 `rustup toolchain install` 명령어를 이용해 명시한 target을 기준으로 툴체인 설치를 수행한다. 위 설치 진행 후 `[project]/.cargo/config/` 에 target 정보가 추가한다.

```
[target.x86_64-unknown-linux-musl]
linker = "x86_64-linux-musl-gcc"
```

설치가 완료되면 아래와 같이  `--taget` 옵션을 지정해 빌드 할 수 있다.

```
$ cargo build --target=x86_64-unknown-linux-musl
```

최종적으로 다음 위치에 리눅스에서 동작하는 실행 파일이 생성된다.

```
./target/target/x86_64-unknown-linux-musl/debug/<프로그램명>
```

현재 플랫폼이 Mac OS 환경이므로 리눅스 플랫폼을 타겟으로 빌드된 프로그램은 현재 환경에서 실행 되지 않으며 리눅스 용으로 빌드 했으므로 윈도우용 빌드와 달리 확장자가 존재하지 않는다.

```
# cross 컴파일을 했으으므로 현재 맥OS 환경에서 리눅스로 컴파일딘 파일 실행 불가
# cargo run --target=x86_64-unknown-linux-musl
```



## Windows용으로 빌드

Windows용으로 크로스 컴파일을 진행 하고자 한다. 다음 명령어는 맥OS에서 윈도우용 GCC인 [mingw-w64](http://mingw-w64.org/)를 설치하는 명령어이다.

```ç
$ brew install mingw-w64
```

mingw-w64 설치 후 target과 관련한 Rust 표준 라이브러리를 설치를 수행한다.

```
$ rustup target add x86_64-pc-windows-gnu
```

위 명령어를 수행하고 active 툴체인 목록에 정상적으로 추가되었는지 확인한다.

```
$ rustup show
...

installed targets for active toolchain
--------------------------------------

x86_64-apple-darwin
x86_64-pc-windows-gnu // 추가 되었음을 확인
x86_64-unknown-linux-musl
```

위 명령어를 실행하고 나면 GCC를 연결을 위한 `[project]/.cargo/config/` 설정이 추가한다.

```
[target.x86_64-pc-windows-gnu]
linker = 'x86_64-w64-mingw32-gcc'
```

이어서 `cargo build -target` 명령어를 이용해 windows 플랫폼을 target으로 빌드를 수행할 수 있다.

```
$ cargo build --target=x86_64-pc-windows-gnu;
```

최종적으로 빌드 결과는 사용자 repo기준으로 아래 경로에 윈도우 실행 파일인 `<프로그램명>.exe `파일이 생성된다.

```
./target/x86_64-pc-windows-gnu/debug/<프로그램명>.exe
```

현재 플랫폼이 아닌 Windows 플랫폼에서만 실행이 가능하다.

```
# cross 컴파일을 했으으므로 현재 OS에서 실행 불가.
# cargo run --target=x86_64-pc-windows-gnu; // x86_64-pc-windows-gnu로 빌드된 실행 파일 실행
```

## 

## 관련 사이트

- rustup 명령어 https://rust-lang.github.io/rustup/basics.html

