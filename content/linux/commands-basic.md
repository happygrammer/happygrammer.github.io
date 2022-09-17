---
title: "Linux 기본 관리 명령어"
date: 2020-12-30T12:21:00+03:00
draft: false
---

### 앨리어스 사용

`alias`는 명령어를 대체하는 명령어이다. 명령어를 축약해 사용자의 정의 명령어를 정의할 수 있다. `alias`라고 입력하면 시스템이 정의한 `alias` 명령어를 확인할 수 있다.

```
$ alias
```

디렉터리만 조회하는 명령어는 다음과 같다.

```
$ ls -l | grep "^d"
```

용량이 큰 대상부터 출력하는 명령은 다음과 같다.

```
$ ls - al | sort -rk 5 # 5열(-k)을 기준으로 용량이 큰것 것(-r) 부터 출력
```

위 명령어는 `lsd`라는 앨리어스로 등록할 수 있다.

```
$ alias lsd='ls -l | grep "^"'
```

아파치 서버를 시작하거나 종료하는 명령어를 앨리어스를 등록해 두면 편리하다.

```
$ alias apachestop='/etc/rc.d/init.d/httpd stop'
$ alias apachstart='/etc/rc.d/init.d/httpd start'
```

`script` 명령어를 이용하면 명령어를 기록할 수 있다.

```
$ script <script>
Script started, output file is typescript
bash-3.2$
```

위 명령어를 입력하면 스크립트가 실행된다. typescript 파일이 아닌 파일명을 지정할 때는 `<script>`에 파일명을 입력한다. 

```
exit
```

위 명령어를 입력하면 기록이 중지 디고 typescript 파일에 입력한 명령어가 저장된다.



### 시스템 종료

시스템 종료 명령어 중 halt명령어를 이용하면 /var/log/wtmp에 시스템 종료시 수행되는 snyc 기록을 남길 수 있다.

```
$ halt
```

만약 sync 작업을 원치 않을 경우 -n 옵션을 줄 수 있다. 시스템 부팅 메시지는 `dmesg` 파일에서 확인 가능하다.

```
$ more /var/log/dmesg
```



## 라우팅 테이블 확인

라이팅 테이블 확인은 route 명령어 또는 netstat 명령어를 사용한다.

```
$ netstat -nr
Internet:
Destination        Gateway            Flags        Refs      Use   Netif Expire
default            192.168.219.1      UGSc           91        0     en0       
127                127.0.0.1          UCS             0        0     lo0       
127.0.0.1          127.0.0.1          UH              2   620406     lo0       
169.254            link#9             UCS             1        0     en0      !
192.168.219        link#9             UCS             1        0     en0      !
192.168.219.1/32   link#9             UCS             1        0     en0      !
192.168.219.1      0:27:1c:de:1d:f2   UHLWIir        32       82     en0   1129
192.168.219.21     98:93:cc:24:a1:a2  UHLWI           0      799     en0   1165
192.168.219.157/32 link#9             UCS             0        0     en0      !
224.0.0/4          link#9             UmCS            2        0     en0      !
224.0.0.251        1:0:5e:0:0:fb      UHmLWI          0        0     en0       
239.255.255.250    1:0:5e:7f:ff:fa    UHmLWI          0     3272     en0       
255.255.255.255/32 link#9             UCS             0        0     en0      !
```

netstat 옵션 중에서 `-p 옵션`은 `--program`과 같으며 실행되고 있는 각 프로그램과 프로세스 ID(PID) 정보를 출력하며, `-n`은 `--numeric`과 같으며 10진수 수치 정보로 결과를 출력해준다. `-l`은 `--listening`과 같으며 현재 listen되고 있는 소켓정보를 출력한다. `-an` 옵션은 시스템이 응답 가능한 프로그램이 무엇인지 표시할 수 있다.

```
$ netstat -an | grep LISTEN
tcp46      0      0  *.8080                 *.*                    LISTEN     
tcp46      0      0  *.8088                 *.*                    LISTEN     
tcp46      0      0  *.80                   *.*                    LISTEN     
tcp4       0      0  *.7070                 *.*                    LISTEN     
tcp6       0      0  fe80::aede:48ff:.49156 *.*                    LISTEN     
tcp6       0      0  fe80::aede:48ff:.49155 *.*                    LISTEN     
tcp6       0      0  fe80::aede:48ff:.49154 *.*                    LISTEN     
tcp6       0      0  fe80::aede:48ff:.49153 *.*                    LISTEN
```

외부 서버와 통신이 가능한지를 확인하는 명령어로 ping이 있다.

```
$ ping 192.168.0.1
```

`-c 3`옵션을 추가하면 ping 개수를 제한할 수 있다.



