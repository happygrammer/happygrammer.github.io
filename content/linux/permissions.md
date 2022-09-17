---
title: "Linux 권한 관리"
date: 2020-12-30T16:47:03+03:00
draft: false
---

### 

### 현재 접속 사용자

현재 서버에 접속한 사용자의 id 확인은 `users` 명령어를 이용해 확인 한다.

```
$ users
user
```

users 명령과 비슷한 명령어로, 사용자의 접속 정보도 함께 볼 수 있는 명령어로 `who` 와 `w` 명령어가 있다.

 `who -H` 명령어는 헤더 정보를 포함해 접속 사용자 정보를 표시한다.

```
$ who -H
USER      LINE     WHEN         
user console  Nov 27 07:09 
user ttys000  Dec  8 23:25 
user ttys001  Dec  9 19:27 
user ttys003  Dec 14 03:35 
```

가능한 많은 정보를 얻기 위해 `-aH` 옵션을 줄 수 있다.

```
$ who -aH
USER      LINE     WHEN         IDLE  	   PID	COMMENT
reboot    ~        Nov 27 07:08 00:22 	     1
user console  Nov 27 07:09  old  	    92
user ttys000  Dec  8 23:25 10:25 	 13286
user ttys001  Dec  9 19:27 00:24 	 20614
user ttys002  Dec 14 02:33   .   	 44278	term=0 exit=0
user ttys003  Dec 14 03:35   .   	 44929
user ttys004  Dec 29 13:57   .   	 97822	term=0 exit=0
```

서버 사용자 정보를 정확히 파악하려면 `w` 명령어를 사용할 수 있다.

```
$ w
17:12  up 33 days, 10:04, 4 users, load averages: 2.04 1.76 1.69
USER     TTY      FROM              LOGIN@  IDLE WHAT
user console  -                271120  33days -
user s000     -                081220  10:26 -bash
user s001     -                091220     25 -bash
user s003     -                141220      - w
```

이때 user 사용자의 접속 정보만을 확인은 다음과 같이 입력한다.

```
$ w user
```

who am i는 접속할 당시의 계정명이다. id는 바뀐 시점의 id를 표시한다.

```
$ whoami
user
```

id 명령어는 현재 사용자의 uid, gid, group 정보를 확인하는 명령어이다.

```
$ id
uid=502(user) gid=20(staff) groups=20(staff),12(everyone), ...
```



### 계정 권한 변경

root 계정 변경은 `su`명령어(`substitute user`의 약자)를 이용한다. 로그아웃 없이 다른 사용자의 권한을 획득할 수 있다.

```
$ su - root
```

위에서 사용한 `-`는 ‘-’는 -l 혹은 --login를 의미한다. `su`라고 입력하면 user 기준으로 환경 변수를 유지하며, `su -`라고 입력하면 root 기준으로 환경 변수 설정을 변경한다. 여기서 `su root` 명령어와 `su` 명령어는 동일한 명령어이다.

```
$ su root  // root 계정으로 로그인 (user 기준으로 환경변수 유지)
$ su       // root 계정으로 로그인 (user 기준으로 환경변수 유지)
```

환경 변수는 `env` 명령어로 확인할 수 있다.

```
$ env
TERM_PROGRAM=Apple_Terminal
SHELL=/bin/bash
TERM=xterm-256color
...
```



### 쉘 지정후 전환

쉘은 커널을 이어주는 통로역할을 한다. 현재 사용중인 쉘은 다음 명령어로 확인 한다.

```
$ echo $SHELL
/bin/bash
```

리눅스는 본쉘(/bin/sh)을 확장한 Bash SHELL(/bin/bash)을 기본으로 사용하지만 root 계정 전환시 본쉘(/bin/sh)을 지정할 수 있다.

```
$ su -s /bin/sh
```



### 사용자 추가

신규 사용자가 있다면 `useradd` 명령어를 이용해 사용자 추가가 가능하다. `useradd` 명령어의 옵션은 다음과 같다.

| **옵션** | **설명**                                                     |
| -------- | ------------------------------------------------------------ |
| -u       | 사용자 계정의 uid 지정 `-u happy`                            |
| -g       | 사용자 계정의 gid 지정                                       |
| -G       | 사용자 계정의 2차 그룹의 GID 지정                            |
| -d       | 사용자의 홈 디렉토리를 지정  `-d /home/happy`는 `/home/happy`를 사용자 홈 디렉터리로 사용 |
| -e       | 사용자의 계정 만기일 지정                                    |
| -f       | 사용자의 계정 유효일 지정  `-f -30` 는 30일동안 유효한 계정으로 관리 |
| -s       | 로그인 시 사용할 기본 쉘 지정                                |
| -M       | 사용자의 홈 디렉토리를 생성하지 않음                         |
| -c       | comment                                                      |

예를 들어 `happy`라는 사용자가 추가 되었고 비밀번호를 설정 명령은 다음과 같이 입력한다.

```
$ useradd happy
$ passwd happy
New Password : ****
Retype new Password : ****
```

MAC OS를 사용 중이라면 `useradd`대신 `dscl` 명령어를 이용한다.