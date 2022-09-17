---
title: "도커 컴포즈 소개"
date: 2020-03-01T08:50:10+03:00
draft: false
---

도커 컴포즈는 여러 컨테이너들의 상태를 관리하는 도구입니다. 일반적으로 도커에서 관리하는 컨테이너 상태는 다음과 같습니다.

-  `created`, `restarting`, `running`, `removing`, `paused`, `exited`, `dead`

이중 도커 컴포즈가 관리하는 상태는 다음과 같습니다. 도커 컴포즈는 [도커 데스크탑 for MAC](https://docs.docker.com/docker-for-mac/install/) 설치시 이미 포함되어 있어 별도 설치를 하지 않아도 됩니다.



### 도커 컴포즈 실행

도커 컴포즈는 여러 컨테이너의 실행을 `docker-compose.yml` 파일을 `docker-compose up` 명령어로 실행할 수 있게 합니다.



### docker-compose 파일에 서비스 정의

 `docker-compose.yml`는 `서비스`를 정의하는 파일입니다. 도커 컴포즈에 정의한 `서비스`는 `web`과 `redis`입니다.

```
version: '3'
services:
  web:
    build: .
    ports:
      - "5000:5000"
  redis:
    image: "redis:alpine"
```

위에서 정의한 `web` 서비스는 현재 디렉터리에 존재하느 Docker file에 설정된 이미지를 사용합니다. Flask 웹 서버의 기본 포트 `5000` 포트를 `5000 `포트로 out bound 했습니다. `redis` 서비스는  `Docker Hub registry`로 부터 Redis 이미지를 가져와 사용합니다.

