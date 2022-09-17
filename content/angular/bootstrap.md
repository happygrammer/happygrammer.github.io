---
title: "Bootstrap"
date: 2020-03-01T00:27:06+03:00
draft: true
---

### 부트스트랩 설치

간다한 애플리케이션 이라면 부트스트랩 이용해 CSS 개발의 수고를 덜 수 있습니다. index.html 파일에 선언해줍니다.

```
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
```

angular 프로젝트의 컴포넌트로 이용하려면 모듈을 직접 설치해 줍니다.

```
$ npm install --save bootstrap jquery
```

```
npm WARN bootstrap@4.4.1 requires a peer of popper.js@^1.16.0 but none is installed. You must install peer dependencies yourself.

+ bootstrap@4.4.1
+ jquery@3.4.1
added 1 package from 1 contributor, updated 1 package and audited 15576 packages in 5.131s
found 0 vulnerabilities
```

Angular.json을 열어 부트스트랩을 설정해줍니다.

```
...
            "styles": [
              "src/styles.css",
              "node_modules/bootstrap/dist/css/bootstrap.min.css"
            ],
            "scripts": [
              "node_modules/jquery/dist/jquery.min.js",
              "node_modules/bootstrap/dist/js/bootstrap.min.js"
            ]
...
```

이후 [ngx-bootstrap](https://github.com/valor-software/ngx-bootstrap)을 설치합니다.

```
npm install ngx-bootstrap --save
npm install popper.js@^1.16.0 --save // ngx-bootstrap 의존 모듈
```

angular cli에서 ngx-bootstrap 명령어를 이용할 수 있게 ng를 업데이트 해줍니다.

```
ng add ngx-bootstrap
```

`--component tooltip`를 주어 추가하겠습니다.

```
ng add ngx-bootstrap --component tooltip
```

애플리케이션 템플릿(app.component.html)을 열고 router-outlet만 남기고 모두 삭제합니다.

```
<router-outlet></router-outlet>
```



### Pagination

https://www.npmjs.com/package/ngx-pagination

```
npm install ngx-pagination --save
```