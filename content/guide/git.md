---
title: "1시간 안에 Git 익히기"
date: 2020-01-15T06:36:29+03:00
draft: false
---

Git은 분산 버전 관리 시스템으로 `리눅스 토발즈`가 만들었으며 파일의 변경사항을 추적하고 관리할 수 있습니다.

### 1. Git 설치

- GIt 설치 : https://git-scm.com/downloads
- Github : 깃허브는 Git을 지원하는 웹 호스팅 서비스
- Github Desktop : https://desktop.github.com/, Github을 편리하게 이용할 수 있도록 만든 소프트웨어

### 2. Git을 이용한 형상 관리

![img](https://miro.medium.com/max/1222/1*AZa45AoRHDQJsMKdAkTlLA.png)

http://nvie.com/posts/a-successful-git-branching-model/

### 3. Git 쉘 명령어

#### 기본 명령어

- git init: 깃 저장소를 초기화한다.
- git help: 깃 명령어를 확인한다.
- git status: 저장소 상태 정보 표시(저장소에 존재하는 파일, 커밋이 필요한 변경 사항, 현재 브랜치 위치 등)
  - 상태 상태라면 `"your branch is up-to-date with 'origin/master'"`와 같이 표시

#### 사용자 설정

- git config –global user.name “happygrammer”
- git config –global user.email “your-github-email”

#### 파일 add 파일 commit

- git add: git이 새로운 파일을 지켜보도록 stage에 add함(staging)

```
git add . // 모든 파일을 add함
git add test.js // test.js 파일만을 add함
```

- git commit: git의 가장 중요한 명령어로 스냅샷을 찍기 위해 커밋함.

```
git commit -m "커밋 메시지"
```

#### 브랜치 checkout

- git checkout <이동할 브랜치명>

```
git checkout master // 마스터 브랜치로 변경
git checkout -b hello // hello 브랜치를 새성하고 checkout함
git checkout -m <기존 브랜치> <새로운 브랜치> // 브랜치명 변경하기	
```

#### branch와 merge

- git branch

```
git branch <생성할 브랜치명> // 브랜치 생성
git branch -d <삭제할 브랜치> // 브랜치 삭제
git branch -D mybranch // 브랜치 강제삭제(non-merged 브랜치 삭제)
git branch -f master HEAD~3 // master 브랜치를 헤드로부터 위로 3단계 올라감
git branch -m <기존 브랜치> <수정할 브랜치명> // 브랜치명 변경
git branch -r // 원격 브랜치 목록
git branch -l // 로컬 브랜치 목록
git branch -v  // 마지막 커밋 메시지도 함께 출력
git branch -vv  // 추적중인 브랜치 확인
git branch --merged // 머지가 완료된 브랜치만 표시
git branch --no-merged // 머시가 미완료인 브랜치만 표시
```

- git merge

```
git merge <브랜치> // 다른 브랜치를 현재 브랜치로 합치기
git merge --no-commit <브랜치> // 커밋 없이 합치기
git cherry-pick <커밋명> // 선택하여 합치기
git cherry-pick -n <커밋명> // 커하지 않고 선택하여 합치기
git merge --squash <브랜치> // 브랜치 이력을 다른 브랜치에 합치기
```

- git reset

```
git reset // add 한 파일 취소
git reset —-merge // merge 한 코드 취소
git reset —-hard HEAD^ // 이전 커밋 리셋하기
git reset —-soft HEAD^ // 코드는 살리고 이전 커밋만 취소하기
```

#### 원격 저장소에서 가져오기와 반영하기

git merge: 브랜치 작업을 끝내고 master 브랜치로 병합. (예) cats 브랜치에서 만든 모든 변경사항을 master 브랜치로 병합하려면 “git merge cats"로 입력

- git pull: 원격 저장소를 로컬 컴퓨터(서버)로 가져오기 위한 다운로드 명령어
- git push: 로컬 저장소를 원격 저장소(깃서버)로 업로드 하는 명령어

```
git push origin master // 원격 저장소의 master 저장소로 업로드
```

#### 깃 이력 보기

- git log

```
git log // 모든 이력 보기
git log -1 // 1개 이력만 표시
git log --since=”6 hours” // 6시간 이후 커밋 이력 보기
git log --before=”2 days” // 2일전까지 커밋 이력 보기 
git log --pretty=oneline // 로그 이력 한 줄씩 보기
```