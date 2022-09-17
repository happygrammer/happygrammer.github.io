---
title: "VSCode에서 Sass 설치와 개발"
date: 2019-11-20T06:37:32+03:00
draft: true
---

[*Sass*(Syntactically Awesome StyleSheets)](https://sass-lang.com/)는 preprocessor로 CSS 단점을 보완합니다. 



### 1. Sass 설치하기

#### 맥OS에서 Sass 설치

Sass 설치하고 버전을 확인합니다. 맥 OS기준 아래 명령어 이용해 설치합니다.

```
$ gem install sass
$ sass --version
1.23.7 compiled with dart2js 2.6.1
```



#### VSCode에서 Sass설치

VSCode를 이용하는 경우 아래 이름의 플러그인을 설치합니다.

```
Live Sass Compiler
```

세팅은 다음 경로로 접근합니다. `User Setting` 메뉴ㄹ 이동합니다. 이후 `Select Live Sass Compiler Config`를 선택합니다.

```
{
    "liveServer.settings.donotShowInfoMsg": true,
    "liveSassCompile.settings.generateMap": false,
    "liveSassCompile.settings.formats": [{
        "format": "expanded",
        "extensionName": ".css",
        "savePath": "/css"
    }]
}
```



### 3. Sass 기본문법



