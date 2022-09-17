---
title: "방화벽 설정 관리 iptables, firewalld"
date: 2020-12-30T16:47:03+03:00
draft: false
---

## Iptables 명령어를 이용한 방화벽 관리

Iptables 명령어는 Cent OS 6이하에서 사용하는 방화벽 설정 관리 명령이다.

### 방화벽 설정 확인 후 삭제

방화벽 설정 상태를 보려면 `-L` 옵션을 이용해 목록을 표시할 수 있다.

```
# iptables -L
Chain INPUT (policy ACCEPT)
target     prot opt source               destination         

Chain FORWARD (policy ACCEPT)
target     prot opt source               destination         

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination         
ACCEPT     tcp  --  anywhere             anywhere             tcp spt:40050
ACCEPT     tcp  --  anywhere             anywhere             tcp spt:40050
```

iptables `-L` 옵션을 주었을때 출력되는 `prot` 열은 프로토콜을 의미하며, 프로토콜의 종류로 `tcp`, `udp`, `icmp`, 또는 `all`가 있다. 이때 방화벽이 입력에 대한 방화벽이라면 INPUT 체인으로 묶어서 관리하고, 외부로 나가는 것과 관련한 방화벽이면 OUTPUT 체인으로 관리한다. 만약 NAT(Network Address Translation)으로 사설 네트워크를 사용하려면 FORWARD 체인을 이용한다. 특정 체인명만 출력 하려면 `-L` 옵션 뒤에 <체인명>을 전달해 준다.

```
iptables -L OUTPUT --line-numbers
Chain OUTPUT (policy ACCEPT)
num  target     prot opt source               destination         
1    ACCEPT     tcp  --  anywhere             anywhere             tcp spt:9000
2    ACCEPT     tcp  --  anywhere             anywhere             tcp spt:9000
```

만약 'IP 주소와 포트번호를 포함한 numeric 형식으로 표시하려면 `-n`옵션을 추가한다.

```
iptables -nL
```

특정 체인에 특정 번호를 삭제하는 명령어 형식은 다음과 같다.

```
iptables -D <chain name> <rule number>
```

만약 OUTPUT 체인명의 1번째 RULE을 삭제하려면 다음과 같이 입력해 준다.

```
iptables -D OUTPUT 1
```



### 방화벽 설정 적용

```
service iptables restart # 재시작
service iptables start # 시작
service iptables stop  # 중지
service iptables save  # iptables 내용을 실재 /etc/sysconfig/iptables에 저장
```



## firewall 명령어를 이용한 방화벽 설정관리

CentOS 7이상 부터 firewall 명령어를 이용한다.



### 방화벽 상태 확인

```
$ firewall-cmd --state
```



### 방화벽 설정

새로운 방화벽 설정 규칙을 추가하기 위해 `-A`(--append) 옵션을 이용한다.

```
firewall-cmd --zone=public --add-port=9000/tcp # 9000 포트 추가
firewall-cmd --permanent --add-remove=9000/tcp # 9000 포트 삭제
```



### 방화벽 적용 관리

CentOS7부터 방화벽 설정 방법이 `firewalld`로 바뀌었다.

```
systemctl restart firewalld
```

`systemctl` 관련 명령어를 나열해 보면 다음과 같다.

```
systemctl enable firewalld # 방화벽 사용
systemctl disable firewalld # 방화벽 비사용
systemctl start firewalld # 방화벽 시작
systemctl stop firewalld # 방화벽 중지
```

