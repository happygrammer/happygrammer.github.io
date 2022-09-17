---
title: "파이썬 3 배열과 딕셔너리"
date: 2020-01-15T06:35:54+03:00
draft: false
---



## 배열



### 배열 탐색

```
token = [s.split() for s in arr] # 공백 단위로 split
token = [s.split()[1:] for s in arr] # 공백 단위로 split
```



## 딕셔너리

### 딕셔너리 선언

```
#!/usr/bin/python3

dict = {'Name': 'Sunflower', 'Kingdom': "Plantae", 'Class': 'Magnoliopsida'}
print ("dict['Name']: ", dict['Name'])
print ("dict['Kingdom']: ", dict['Kingdom'])
print ("dict['Class']: ", dict['Class'])
```



### 딕셔너리 keys 사용

```
for key in dict.keys():
    print(key+":"+dict[key])
```



### 딕셔너리 메소드

| Sr.No. |                     Method & Description                     |
| ------ | :----------------------------------------------------------: |
| 1      | [dict.clear()](https://www.tutorialspoint.com/python3/dictionary_clear.htm)는 딕셔너리의 모든 아이템을 삭제함 |
| 2      | [dict.copy()](https://www.tutorialspoint.com/python3/dictionary_copy.htm) shallow copy하여 dict를 반환함* |
| 3      | [dict.fromkeys()](https://www.tutorialspoint.com/python3/dictionary_fromkeys.htm) Create a new dictionary with keys from seq and values *set* to *value*. |
| 4      | [dict.get(key, default=None)](https://www.tutorialspoint.com/python3/dictionary_get.htm)For *key* key, returns value or default if key not in dictionary |
| 5      | [dict.has_key(key)](https://www.tutorialspoint.com/python3/dictionary_has_key.htm)Removed, use the *in* operation instead. |
| 6      | [dict.items()](https://www.tutorialspoint.com/python3/dictionary_items.htm)Returns a list of *dict*'s (key, value) tuple pairs |
| 7      | [dict.keys()](https://www.tutorialspoint.com/python3/dictionary_keys.htm)Returns list of dictionary dict's keys |
| 8      | [dict.setdefault(key, default = None)](https://www.tutorialspoint.com/python3/dictionary_setdefault.htm)Similar to get(), but will set dict[key] = default if *key* is not already in dict |
| 9      | [dict.update(dict2)](https://www.tutorialspoint.com/python3/dictionary_update.htm)Adds dictionary *dict2*'s key-values pairs to *dict* |
| 10     | [dict.values()](https://www.tutorialspoint.com/python3/dictionary_values.htm)Returns list of dictionary *dict*'s values |



### 더 읽어 볼만한 글

- Python3 튜토리얼 문서 https://docs.python.org/3/tutorial/

