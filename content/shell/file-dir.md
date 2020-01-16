---
title: "File Dir"
date: 2020-01-15T15:03:26+03:00
draft: true
---



특정 파일에 대해서 제외하기

```
cp -r `ls <src-dir-name> | grep -v <ignore-file-name> ` <target-dir-name>
```



 파일 제외 목록을 제외하고 복사 

```
cp -r `ls <src-dir-name> | grep -Ev <ignore-file-name>|<ignore-file-name2>|...` <target-dir-name>
```

