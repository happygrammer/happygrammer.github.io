---
title: "Angular 컴포넌트"
date: 2020-02-29T18:26:19+03:00
draft: true
---

### 컴포넌트 소개와 중첩 컴포넌트에 대한 소개

Angular에서 컴포넌트는 그 자체로 하나의 독립적인 프로그램입니다. 즉, 외부 의존성 없이 동작이 가 능합니다. 그런데 단순히 외부 의존성 없이 동작하게끔 만들기보다는 컴포넌트의 부모가 자식 컴포넌트 를 포함하도록 계층성을 고려해 컴포넌트 관계를 만들 수 있습니다. 이처럼 부모 컴포넌트가 여러 자식 컴포넌트를 포함할 때 부모 컴포넌트를 중첩 컴포넌트(nested component)라고 합니다. 중첩 컴포넌 트는 내부에 중첩된 형태로 컴포넌트를 포함합니다.



### 컴포넌트 트리 컴포넌트

컴포넌트 트리 컴포넌트는 하나의 화면을 나타내며, 하나의 웹 페이지는 여러 컴포넌트로 구성되어 하나의 화면을 만듭 니다. 컴포넌트를 배치할 때 수평으로 배치해 구조를 잡기도 하지만 컴포넌트 안에 또 다른 컴포넌트를 넣어 중첩된 형태의 화면을 만들기도 합니다. 이처럼 컴포넌트 내부에 자식 컴포넌트를 포함하다 보면 컴포넌트 트리(component tree)라는 계층 구조가 만들어집니다.



### 컴포넌트 만들기

새로운 컴포넌트를 만드는 명령어는 아래와 같습니다.

```
ng g component <컴포넌트명>
```

main 이라는 컴포넌트를 만들어 보겠습니다.

```
$ ng generate component main
CREATE src/app/main/main.component.css (0 bytes)
CREATE src/app/main/main.component.html (19 bytes)
CREATE src/app/main/main.component.spec.ts (614 bytes)
CREATE src/app/main/main.component.ts (267 bytes)
UPDATE src/app/app.module.ts (467 bytes)
```

ng server 명령어를 이용해 컴파일을 수행하고, 신규로 추가된 main 컴포넌트 결과를 확인하겠습니다.



### 라우터 설정

router-outlet에 표시할 디폴트 화면에 대한 라우터를 설정합니다.

```
const helloRoutes: Routes = [
  { path: '', component: LoginComponent },
  { path: 'main', component: MainComponent }
];
```

위에 보시면 첫 화면으로 로그인 기능 역할을 하는 LoginComponent의 주소를 설정했습니다. 실재 주소는 다음과 같습니다.

```
localhost:4200/
```

이어서 메인 역할을 하는 페이지를 구성하기 위해 MainComponent의 주소를 설정했습니다. 실재 주소는 다음과 같습니다.

```
localhost:4200/main
```



[예제] 라우터 구성 결과

```
import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { LoginComponent } from './login/login.component';
import { MainComponent } from './main/main.component';

const helloRoutes: Routes = [
  { path: '', component: LoginComponent },
  { path: 'main', component: MainComponent }
];

const routes: Routes = [
  ...helloRoutes
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }

```



```
<div class="container">
  <form class="form-signin">
    <h2 class="form-signin-heading">Please sign in</h2>
    <label for="inputEmail" class="sr-only">ID</label>
    <input type="email" id="inputEmail" class="form-control" placeholder="ID" required autofocus>
    <label for="inputPassword" class="sr-only">Password</label>
    <input type="password" id="inputPassword" class="form-control" placeholder="Password" required>
    <div class="checkbox">
      <label>
        <input type="checkbox" value="remember-me"> Remember me
      </label>
    </div>
    <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
  </form>
</div>
```

