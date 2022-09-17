---
title: "Sudo 권한 획득(CVE-2021-3156) 취약점 조치방법"
date: 2021-04-09T21:45:33+03:00
draft: false
---

[sudo](sudo.ws/download.html) 명령어의 -s 또는 -i 옵션을 사용할때 특수 문자 이스케이프시에 로컬 사용자가 root권한을 획득할 수 있는 보안 취약점이 발견 되었다.

- 취약점 코드 - [CVE-2021-3156](https://blog.qualys.com/vulnerabilities-research/2021/01/26/cve-2021-3156-heap-based-buffer-overflow-in-sudo-baron-samedit) (취약점 명칭은 `Baron Samedit`라고 명명됨)

권한 없는 로컬 사용자가 인증 없이 root 권한 획득을 할 수 있다. 취약점이 있는 sudo 버전은 다음과 같다.

```
1.8.2 ~ 1.8.31p2
1.9.0 ~ 1.9.5p1
```

sudo 버전은 다음 명령어로 확인할 수 있다.

```
$ sudo -V
```

sudo에 취약점이 있는지를 확인하고 싶다면 다음 명령어를 입력해 확인할 수 있다.

```
$ sudoedit -s /
sudoedit: /: not a regular file
```

'sudoedit: /: not a regular file' 이라고 출력되었다면 취약점에 노출 되었다고 볼 수 있다. 위 치약점을 해결 하려면 sudo 업데이트가 필요하다.

```
 yum install -y sudo
```

만약 업데이트 할 수 있는 sudo를 찾을 수 없다면 취약점이 해결된 최신의 [sudo](sudo.ws/download.html) 패키지를 내려 받아 yum을 이용해 인스톨을 수행한다.

```
wget https://github.com/sudo-project/sudo/releases/download/SUDO_1_9_6p1/sudo-1.9.6-2.el6.x86_64.rpm
yum localinstall sudo-1.9.6-2.el6.x86_64.rpm
```



### 관련 사이트

- [[1] ](https://dev.to/mbcrump/cve-2021-3156-heap-based-buffer-overflow-in-sudo-5efp) CVE-2021-3156: Heap-Based Buffer Overflow in Sudo