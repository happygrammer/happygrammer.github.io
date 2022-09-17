---
title: "도커에 Mariadb 설치"
date: 2020-03-01T00:55:12+03:00
draft: false
---



### 도커 실행 여부 체크

설치를 진행하기 전에 도커 실행 여부를 확인합니다. 도커가 실행중인 상태가 아니면 다음과 같은 예외 메시지가 출력됩니다.

```
Using default tag: latest
Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running?
```

지금 부터 mariadb를 다운로드 받아 설정 까지 진행하도록 하겠습니다.



### 도커 이미지 다운로드

```
docker pull mariadb
```



### 컨테이너 실행

3306 port로 설정해 실행합니다.

```
docker container run -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=1234 --name mariadb mariadb
```

docker 볼륨을 `/Users/Shared/data/mariadb`로 설정합니다.

```
docker container run -d -p 3306:3306 	\
-e MYSQL_ROOT_PASSWORD=1234 		\
-v /Users/Shared/happy/mariadb:/var/lib/mysql 	\
--name mariadb mariadb
```

`-v`는 Bind mount a volume와 관련한 옵션입니다. 형식은 다음과 같습니다.

```
-v <bind-path>:<file or directory on the host machine>
```

맥 OS에서 `/Users/Shared `는 공용 폴더이므로 `/Users/Shared/happy/mariadb` 디렉터리로 설정하였습니다.

그리고 `--name` 옵션은 컨테이너 실행시 컨네이너 실행시 컨테이너 이름을 부여하기 위한 용도입니다.

```
--name <original-container-name> <new-container-name>
```

* `--name` 옵션 없이 컨테이너 실행을 진행하면 임의의 이름으로 컨테이너가 실행됩니다. 이때 실행중인 컨테이너의 이름을 변경하려면 `docker rename [old-container-name] [new-container-name]`와 같이 명령어를 입력합니다.

이어서 컨테이너가 정상적으로 실행 됐는지 확인합니다.

```
docker container ls -a
```

이때 `-s`옵션을 붙여주면 컨테이너에서 사용량을 확인할 수 있습니다.

```
docker container ls -as
```

```
(base) dialogui-MacBookPro:~ smarthome$ docker container ls -as
CONTAINER ID        IMAGE                   COMMAND                  CREATED             STATUS                    PORTS                    NAMES                   SIZE
2463b80300ec        mariadb                 "docker-entrypoint.s…"   8 hours ago         Up 8 hours                0.0.0.0:3306->3306/tcp   mariadb                 82.8MB (virtual 438MB)
```



### mariadb 접속

```
docker exec -i -t mariadb bash 
mysql -uroot -p1234
```

mariadb 커맨드 화면이 나타나며 `show databases;`명령어를 이용해 현재 추가된 데이터베이스를 확인합니다.

```
MariaDB [(none)]> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
+--------------------+
3 rows in set (0.001 sec)
```



### my.cnf 수정

vi 편집기 설치 후 my.cnf를 수정합니다.

```
apt-get update
apt-get install vim 
vi /etc/mysql/my.cnf 
```

```
character-set-client-handshake = FALSE
init_connect="SET collation_connection = utf8_general_ci"
init_connect="SET NAMES utf8"
character-set-server = utf8

[client]
default-character-set = utf8

[mysql]

default-character-set = utf8

[mysqldump]
default-character-set = utf8
```

위 옵션 중에서 `character-set-client-handshake`의 값이 `FALSE`이면 클라이언트 문자셋을 무시하고 서버 문자셋을 사용한다는 의미입니다.



### 컨테이너 재시작

```
docker stop mariadb
docker start mariadb
```



### mariaDB 로그 보기

```
$ docker logs -f --tail=10 mariadb
2020-02-29 22:13:47 0 [Note] InnoDB: 10.4.12 started; log sequence number 60990; transaction id 21
...
```

