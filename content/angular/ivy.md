---
title: "Ivy"
date: 2020-02-29T18:15:50+03:00
draft: true
---

Angular 9에서는 IVY 엔진이 기본으로 탑재 됐습니다. 따라서 tsconfig.json에 별도 설정을 하지 않아도 됩니다.

[tsconfig.json] Angular 9 이상 부터 지원하지 않는 Ivy 설정

```

{
  "angularCompilerOptions": {
    "enableIvy": false
  }
}
```

