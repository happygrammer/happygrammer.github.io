---
title: "Docker 명령어 소개"
date: 2020-02-19T06:50:32+03:00
draft: false
---



### 컨테이너 확인

```
docker container ls 
```

```
$ docker container ls 
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                    NAMES
2463b80300ec        mariadb             "docker-entrypoint.s…"   13 seconds ago      Up 12 seconds       0.0.0.0:3306->3306/tcp   mariadb
```

* 컨테이너 목록을 표시하는 명령어인 `docker ps` 는 오래전 방식입니다. 새로운 명령어 형식은 `docker container <subcommand>`입니다. 즉, `docker container ls`를 권장합니다. 이때 `docker container ls`는 `docker container ps`와 동일한 명령어입니다. 즉 아래 4개 명령어는 정확히 동일 기능을 수행하는 명령어입니다.

**실행중인 컨테이너 정보를 표시하는 동일 명령어**

```
$ docker container ls
$ docker container list
$ docker container ps
$ docker ps
```

- `docker container run`(최신 방식)과 `docker run`(1.13 이전 버전에서 사용)은 동일한 명령어입니다. 결론적으로 `docker + <command> + <sub-command>`의 조합을 사용하는 `docker container run`의 방식이 최신입니다.

이때 실행중인 컨테이너나 실행중이지 않은 컨테이너 모두를 표시하려면 `-a`옵션을 주면 출력됩니다.

```
$ docker container ls -a
```



## 에러 메시지 

`Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running?` 

프로세스가 실행 되지 않아서 입니다. 도커 실행 [명령어](https://docs.docker.com/config/daemon/systemd/)는 다음과 같습니다.

Linux

```null
systemctl start docker
```

```
sudo service docker start
```

맥 OS

```
launchctl start docker
```

