---
title: "[쉘스크립트] 날짜와 시간 처리"
date: 2020-01-15T07:15:14+03:00
draft: false
---



#### 날짜 포맷 출력(기본 포맷)

mm/dd/yy형식으로 날짜 출력

```
date +"%D"
```

#### 날짜 포맷 출력(지정 포맷)

yyyy-mm-dd 형식의 날짜 출력

```
date "+%Y-%m-%d"
echo date # 2020-01-14
```

#### 시간 출력(기본 포맷)

hh-mm-ss 형식의 시간 출력

```
date +"%T" # 04:09:51
```

#### 시간 출력(12시간 기준)

```
date +"%r" # 04:09:51 AM
```

#### 날짜와 시간 출력(기본 포맷)

```
now=$(date)
echo $no # 2020년 1월 15일 수요일 05시 19분 36초 MSK
```

#### 날짜와 시간 출력(지정 포맷)

yyyy-mm-dd_hh-mm-ss 형식으로 출력

```
echo $(date +%F_%H-%M-%S) # 2020-01-15_05-12-24
```

#### 시간 조건 분기(12시간 기준)

쉘 코드로 오전(AM), 오후(PM)에 대한 조건 분기는 다음과 같습니다.

```
h=$(date +%H)
if (( h < 12)); then
    echo YES # AM
else
    echo NO  # PM
fi
```

출력결과

```
YES
```

------

#### [첨부] Date 포맷 코드 목록

| FORMAT code | Description                                                  |
| :---------- | :----------------------------------------------------------- |
| %%          | a literal %                                                  |
| %a          | locale’s abbreviated weekday name (e.g., Sun)                |
| %A          | locale’s full weekday name (e.g., Sunday)                    |
| %b          | locale’s abbreviated month name (e.g., Jan)                  |
| %B          | locale’s full month name (e.g., January)                     |
| %c          | locale’s date and time (e.g., Thu Mar 3 23:05:25 2005)       |
| %C          | century; like %Y, except omit last two digits (e.g., 20)     |
| %d          | day of month (e.g., 01)                                      |
| %D          | date; same as %m/%d/%y                                       |
| %e          | day of month, space padded; same as %_d                      |
| %F          | full date; same as %Y-%m-%d                                  |
| %g          | last two digits of year of ISO week number (see %G)          |
| %G          | year of ISO week number (see %V); normally useful only with %V |
| %h          | same as %b                                                   |
| %H          | hour (00..23)                                                |
| %I          | hour (01..12)                                                |
| %j          | day of year (001..366)                                       |
| %k          | hour, space padded ( 0..23); same as %_H                     |
| %l          | hour, space padded ( 1..12); same as %_I                     |
| %m          | month (01..12)                                               |
| %M          | minute (00..59)                                              |
| %n          | a newline                                                    |
| %N          | nanoseconds (000000000..999999999)                           |
| %p          | locale’s equivalent of either AM or PM; blank if not known   |
| %P          | like %p, but lower case                                      |
| %q          | quarter of year (1..4)                                       |
| %r          | locale’s 12-hour clock time (e.g., 11:11:04 PM)              |
| %R          | 24-hour hour and minute; same as %H:%M                       |
| %s          | seconds since 1970-01-01 00:00:00 UTC                        |
| %S          | second (00..60)                                              |
| %t          | a tab                                                        |
| %T          | time; same as %H:%M:%S                                       |
| %u          | day of week (1..7); 1 is Monday                              |
| %U          | week number of year, with Sunday as first day of week (00..53) |
| %V          | ISO week number, with Monday as first day of week (01..53)   |
| %w          | day of week (0..6); 0 is Sunday                              |
| %W          | week number of year, with Monday as first day of week (00..53) |
| %x          | locale’s date representation (e.g., 12/31/99)                |
| %X          | locale’s time representation (e.g., 23:13:48)                |
| %y          | last two digits of year (00..99)                             |
| %Y          | year                                                         |
| %z          | +hhmm numeric time zone (e.g., -0400)                        |
| %:z         | +hh:mm numeric time zone (e.g., -04:00)                      |
| %::z        | +hh:mm:ss numeric time zone (e.g., -04:00:00)                |
| %:::z       | numeric time zone with : to necessary precision (e.g., -04, +05:30) |
| %Z          | alphabetic time zone abbreviation (e.g., EDT)                |

출처 : https://www.cyberciti.biz/faq/linux-unix-formatting-dates-for-display/

#### [첨부] GNU/date 포맷코드

FORMAT controls the output. It can be the combination of any one of the following:

| %FORMAT String | Description                                                  |
| :------------- | :----------------------------------------------------------- |
| %%             | a literal %                                                  |
| %a             | locale’s abbreviated weekday name (e.g., Sun)                |
| %A             | locale’s full weekday name (e.g., Sunday)                    |
| %b             | locale’s abbreviated month name (e.g., Jan)                  |
| %B             | locale’s full month name (e.g., January)                     |
| %c             | locale’s date and time (e.g., Thu Mar 3 23:05:25 2005)       |
| %C             | century; like %Y, except omit last two digits (e.g., 21)     |
| %d             | day of month (e.g, 01)                                       |
| %D             | date; same as %m/%d/%y                                       |
| %e             | day of month, space padded; same as %_d                      |
| %F             | full date; same as %Y-%m-%d                                  |
| %g             | last two digits of year of ISO week number (see %G)          |
| %G             | year of ISO week number (see %V); normally useful only with %V |
| %h             | same as %b                                                   |
| %H             | hour (00..23)                                                |
| %I             | hour (01..12)                                                |
| %j             | day of year (001..366)                                       |
| %k             | hour ( 0..23)                                                |
| %l             | hour ( 1..12)                                                |
| %m             | month (01..12)                                               |
| %M             | minute (00..59)                                              |
| %n             | a newline                                                    |
| %N             | nanoseconds (000000000..999999999)                           |
| %p             | locale’s equivalent of either AM or PM; blank if not known   |
| %P             | like %p, but lower case                                      |
| %r             | locale’s 12-hour clock time (e.g., 11:11:04 PM)              |
| %R             | 24-hour hour and minute; same as %H:%M                       |
| %s             | seconds since 1970-01-01 00:00:00 UTC                        |
| %S             | second (00..60)                                              |
| %t             | a tab                                                        |
| %T             | time; same as %H:%M:%S                                       |
| %u             | day of week (1..7); 1 is Monday                              |
| %U             | week number of year, with Sunday as first day of week (00..53) |
| %V             | ISO week number, with Monday as first day of week (01..53)   |
| %w             | day of week (0..6); 0 is Sunday                              |
| %W             | week number of year, with Monday as first day of week (00..53) |
| %x             | locale’s date representation (e.g., 12/31/99)                |
| %X             | locale’s time representation (e.g., 23:13:48)                |
| %y             | last two digits of year (00..99)                             |
| %Y             | year                                                         |
| %z             | +hhmm numeric timezone (e.g., **-0400**)                     |
| %:z            | +hh:mm numeric timezone (e.g., **-04**:00)                   |
| %::z           | +hh:mm:ss numeric time zone (e.g., **-04**:00:00)            |
| %:::z          | numeric time zone with : to necessary precision (e.g., **-04**, +05:30) |
| %Z             | alphabetic time zone abbreviation (e.g., EDT)                |

출처 : https://www.cyberciti.biz/faq/linux-unix-formatting-dates-for-display/

#### [첨부] BSD/date 커맨드(맥OS, FreeBSD)

| 포맷 코드 | 설명                                                         |
| :-------- | :----------------------------------------------------------- |
| %a        | is replaced by national representation of the abbreviated weekday name. |
| %B        | is replaced by national representation of the full month name. |
| %b        | is replaced by national representation of the abbreviated month name. |
| %C        | is replaced by (year / 100) as decimal number; single digits are preceded by a zero. |
| %c        | is replaced by national representation of time and date.     |
| %D        | is equivalent to “%m/%d/%y”.                                 |
| %d        | is replaced by the day of the month as a decimal number (01-31). |
| %E* %O*   | POSIX locale extensions. The sequences %Ec %EC %Ex %EX %Ey %EY %Od %Oe %OH %OI %Om %OM %OS %Ou %OU %OV %Ow %OW %Oy are supposed to provide alternate representations. Additionally %OB implemented to represent alternative months names (used standalone, without day mentioned). |
| %e        | is replaced by the day of the month as a decimal number (1-31); single digits are preceded by a blank. |
| %G        | is replaced by a year as a decimal number with century. This year is the one that contains the greater part of the week (Monday as the first day of the week). |
| %g        | is replaced by the same year as in “%G”, but as a decimal number without century (00-99). |
| %H        | is replaced by the hour (24-hour clock) as a decimal number (00-23). |
| %h        | the same as %b.                                              |
| %I        | is replaced by the hour (12-hour clock) as a decimal number (01-12). |
| %j        | is replaced by the day of the year as a decimal number (001-366). |
| %k        | is replaced by the hour (24-hour clock) as a decimal number (0-23); single digits are preceded by a blank. |
| %l        | is replaced by the hour (12-hour clock) as a decimal number (1-12); single digits are preceded by a blank. |
| %M        | is replaced by the minute as a decimal number (00-59).       |
| %m        | is replaced by the month as a decimal number (01-12).        |
| %n        | is replaced by a newline.                                    |
| %O*       | the same as %E*.                                             |
| %p        | is replaced by national representation of either “ante meridiem” (a.m.) or “post meridiem” (p.m.) as appropriate. |
| %R        | is equivalent to “%H:%M”.                                    |
| %r        | is equivalent to “%I:%M:%S %p”.                              |
| %S        | is replaced by the second as a decimal number (00-60).       |
| %s        | is replaced by the number of seconds since the Epoch, UTC (see mktime(3)). |
| %T        | is equivalent to “%H:%M:%S”.                                 |
| %t        | is replaced by a tab.                                        |
| %U        | is replaced by the week number of the year (Sunday as the first day of the week) as a decimal number (00-53). |
| %u        | is replaced by the weekday (Monday as the first day of the week) as a decimal number (1-7). |
| %V        | is replaced by the week number of the year (Monday as the first day of the week) as a decimal number (01-53). If the week containing January 1 has four or more days in the new year, then it is week 1; otherwise it is the last week of the previous year, and the next week is week 1. |
| %v        | is equivalent to “%e-%b-%Y”.                                 |
| %W        | is replaced by the week number of the year (Monday as the first day of the week) as a decimal number (00-53). |
| %w        | is replaced by the weekday (Sunday as the first day of the week) as a decimal number (0-6). |
| %X        | is replaced by national representation of the time.          |
| %x        | is replaced by national representation of the date.          |
| %Y        | is replaced by the year with century as a decimal number.    |
| %y        | is replaced by the year without century as a decimal number (00-99). |
| %Z        | is replaced by the time zone name.                           |
| %z        | is replaced by the time zone offset from UTC; a leading plus sign stands for east of UTC, a minus sign for west of UTC, hours and minutes follow with two digits each and no delimiter between them (common form for RFC 822 date headers). |
| %+        | is replaced by national representation of the date and time (the format is similar to that produced by date(1)). |
| %-*       | GNU libc extension. Do not do any padding when performing numerical outputs. |
| %_*       | GNU libc extension. Explicitly specify space for padding.    |
| %0*       | GNU libc extension. Explicitly specify zero for padding.     |
| %%        | is replaced by %.                                            |

출처 : https://www.cyberciti.biz/faq/linux-unix-formatting-dates-for-display/