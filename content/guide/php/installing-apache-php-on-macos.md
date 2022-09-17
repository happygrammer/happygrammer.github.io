---
title: "맥 OS에서 아파치, PHP 시작 설정"
date: 2020-03-21T21:15:12+03:00
draft: false
---

퍼미션 문제가 발생할 수 있어 루트 사용자로 권한을 변경합니다.

```
sudo su -
```

## 맥 OS에서 아파치 시작

```
apachectl start
```

[http://localhost](http://localhost/) 접속해 서버 페이지 접속이 가능한지 확인합니다.

## 맥 OS에서 PHP 시작

서버 페이지가 표시 됐다면 서버 시작은 정상적으로 수행된 것 입니다. 서버가 정상적으로 정상적으로 시작 됐더라도 별도 설정을 하지 않으면 PHP 페이지는 출력되지 않습니다. PHP 페이지를 출력하려면 아파치 설정을 수정해야 합니다. 먼저 아파치 설정을 백업해 둡니다. 앞으로 설정이 바뀌더라도 디폴트 설정이 무엇인지 참고할 때 사용할 수 있습니다.

```
cd /etc/apache2/
cp httpd.conf httpd.conf.Catalina
```

vi를 이용해 아파치 설정을 수정합니다.

```
vi httpd.conf
```

아래 라인에 해당하는 줄의 커멘트를 제거합니다. (#를 제거)

```
LoadModule php7_module libexec/apache2/libphp7.so
```

아파치를 재시작합니다.

```
apachectl restart
```

 [`phpinfo()`](http://php.net/manual/en/function.phpinfo.php) 를 출력하는 페이지를 만들어 보겠습니다. 먼저 DocumentRoot가 어디에 있는지 확인해 보겠습니다. 맥 OS를 사용중 이라면 `/Library/WebServer/Documents`에 해당하는 위치입니다.

```
grep DocumentRoot httpd.conf
```

실행 결과

```
$ grep DocumentRoot httpd.conf
# DocumentRoot: The directory out of which you will serve your
DocumentRoot "/Library/WebServer/Documents"
    # access content that does not live under the DocumentRoot.
```

`phpinfo()` 페이지를 만들겠습니다.

```
echo '<?php phpinfo();' > /Library/WebServer/Documents/phpinfo.php
```

http://localhost/phpinfo.php 접속해 확인합니다.

