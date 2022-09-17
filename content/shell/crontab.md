---
title: "crontab을 이용한 스케쥴 관리"
date: 2020-02-28T10:39:13+03:00
draft: false
---



### crontab 설정

```
# ┌───────────── min (0 - 59)
# │ ┌────────────── hour (0 - 23)
# │ │ ┌─────────────── day of month (1 - 31)
# │ │ │ ┌──────────────── month (1 - 12)
# │ │ │ │ ┌───────────────── day of week (0 - 6) (0 to 6는 일~토, 7=일)
# │ │ │ │ │
# │ │ │ │ │
# * * * * * <실행할 커맨드>
```



### crontab 작업 리스트

```
$ crontab -l
```



### crontab 로그 확인

```
$ cat /var/log/cron
```



### crontab 설정 확인

```
$ cat /var/spool/cron/<user_id>
```



### crontab service 상태 확인과 재실행

```
$ service crond status
crond (pid 2994)를 실행하고 있습니다.
$ source ~/.bash_profile
$ service crond {start|restart|stop}
```



crontab 디버깅

```
10 12 * * 1-5 /usr/bin/perl /home/my/test.pl > /home/my/error.log 2>&1
```

`>`  : redirect

2 : stderr

1 : stdout

즉, `2>&1`을 둠으로서 표준 출력과 표준 에러 출력을 `/home/my/error.log`파일에 출력하라는 의미로 볼 수 있습니다. 여기서 다음과 같이 순서를 뒤집을 수 없습니다.

```
2>&1 /home/my/error.log 
```

