---
title: "Hugo 정적 사이트 생성기 가이드"
date: 2020-01-15T06:27:50+03:00
draft: f
---

Hugo는 Go언어로 만들어진 정적 사이트 생성기(static site generator)입니다. Go언어로 만들어져서 정적 파일 생성이 빠르고 최근 많은 인기를 얻고 있습니다.

### 변수

사전 정의 변수

```
 {{ .Title }}
```

사용자 정의

```
{{ $address }}
```

### 템플릿 가져 오기

파셜 템플릿 가져오기

```
{{ partial "header.html"}}
```



### 템플릿 룩업 순서

layouts/posts/single.html.html가 layouts/posts/single.html보다 우선 순위가 높습니다.



### 베이스 템플릿

layouts/_default

위 디렉터리에 접근해보면 베이스 템플릿인 baseof.html가 존재합니다. 디폴트 리스트 템플릿인 list.html 파일이 존재합니다.



### 템플릿

템플릿 설치는 https://themes.gohugo.io/ 사이트를 이용할 수 있습니다.



### Hugo 명령어

##### happy라는 저장소 추가

```
$ hugo new site happy
```

##### hugo 서버 실행

```
$ hugo server -D
```

##### 테마 적용하여 hugo 서버 실행

```
$ hugo server -t <theme name>
```

##### 디버그 옵션으로 hugo 서버 실행

```
$ hugo server -v --debug
```

##### 새로운 마크다운 문서 추가하기

```
$ hugo new posts/hello.md
```

위와 같이 추가하면 `/posts/hello` 경로의 마크다운 문서가 추가됩니다.

##### 정적 파일 만들기

-t 옵션을 추가해 public 디렉터리에 정적 파일을 만듭니다.

```
$ hugo -t <theme name>
```

주의할 사항은 마크다운 상단에 설정이 `draft: false` 인 문서만을 정적 파일로 만듭니다. 예를 들어 /posts/hello.md라는 파일을 정적 파일을 생성하려면 draft 상태값이 false여야 합니다.

```
---
title: "hello"
date: 2019-12-25T21:59:01+03:00
draft: false
---
```



### 정적 사이트 배포하기

hugo를 배포를 빠르게 하기 위해 저장소에 연결 후 배포 스크립트를 작성해 두면 편리합니다. 먼저 hugo를 배포하기 위해서는 로컬 저장소를 원격 저장소에 연결해 주어야 합니다.

```
$ git remote add origin https://github.com/happygrammer/happygrammer.github.io.git
```

이후, 아래와 같은 쉡 스크립트(push.sh)를 두어 hugo의 정적 파일 생성과 commit 그리고, 원격 저장소의 배포를 한번에 처리하면 효율적입니다.

```
hugo -t hugo-theme-minos
cd public
git add .
git commit -m "commit"
git push -u origin master
```



### HTML 출력

HTML 태그를 사용하려 할때 hugo는 safe하지 않다고 판단해 아래와 같이 "raw HTML omitted" 주서으로 치환을 수행합니다.

```ᆨhtml
<p>...</p>
<!-- raw HTML omitted -->
<p>...</p>
```

이러한 경우는 hugo 설정에서 `unsafe` 값을 true로 해주면, safe 모드가 해제 되어 html 태그를 사용할 수 있게 됩니다.

```toml
[markup.goldmark.renderer]
unsafe = true
```