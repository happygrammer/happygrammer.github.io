---
title: "텍스트 전처리"
date: 2020-02-07T01:08:14+03:00
draft: false
---

**텍스트 전처리**(text preprocessing)은 입력 데이터셋에 섞여 있는 불필요한 노이즈를 제거하거나 데이터를 일관성있게 만드는 정규화 과정을 포함한다. 전처리는 크게 두 단계의 작업을 수행한다.

- 노이즈 제거
- 텍스트 정규화

노이즈 제거(Noise removal)는 불필요한 태그 제거, 특수 문자 제거, 구두점 제거, 공백 제거등 실질 데이터와 무관한 문자를 삭제해 단어나 문장 인식을 명확히 할 수 있도록 만드는 전 처리 단계다. 텍스트 정규화(Text normalization)는 계산량을 줄이기 위한 처리다. 텀 매트릭스의 차원 축소(dimensionally reduction)을 축소해 계산을 빠르고 효율적이도록 한다. 텍스트 정규화의 예로 오타 교정, 대소문자 치환, 단위 치환,  불용어 삭제, 스테밍, 렘마티제이션를 처리하는 과정다. 이러한 전 처리 과정이 이뤄지고 나면 단어 단위로 토큰화를 하거나, 문장 분리 등을 처리하게 됩니다.



## 1. 노이즈 제거

### 태그 제거

HTML 태그 제거는 Beautiful 스프를 이용하면 좋다. Beautiful는 파스 트리를 탐색해 XML, html에 대한 검색, 생성, 수정을 수행할 수 있다. 설치 방법은 간단한다.



우분투/데비안(python3)

```
apt-get install python3-bs4
```

맥OS

```
pip install beautifulsoup4
```

설치를 마치면 간단히 테스트해볼 수 있다. 예를 들어 soup에서 제공하는 pretty() 함수 기능은 아래와 같이 사용한다.

```
from bs4 import BeautifulSoup

html_doc = """  
<html><head><title>Happygrammer's story</title></head>
<body>
<p class="title"><b>Happygrammer's story</b></p>
<p class="story">Hello, Happygrammer World
<a href="http://happygrammer.com/hello" class="sister" id="link1">Elsie</a>,
<a href="http://example.com/happy" class="sister" id="link2">Lacie</a>
"""

soup = BeautifulSoup(html_doc, 'html.parser')
print(soup.prettify())
```

html_doc 개체는 검색, 생성, 수정에 활용됩니다.

```
from bs4 import BeautifulSoup
soup = BeautifulSoup(html_doc, 'html.parser')

print(soup.prettify())
soup.title
# <title>The Dormouse's story</title>

soup.title.name
# u'title'

soup.title.string
# u'The Dormouse's story'

soup.title.parent.name
# u'head'

soup.p
# <p class="title"><b>The Dormouse's story</b></p>

soup.p['class']
# u'title'

soup.a
# <a class="sister" href="http://example.com/elsie" id="link1">Elsie</a>

soup.find_all('a')
# [<a class="sister" href="http://example.com/elsie" id="link1">Elsie</a>,
#  <a class="sister" href="http://example.com/lacie" id="link2">Lacie</a>,
#  <a class="sister" href="http://example.com/tillie" id="link3">Tillie</a>]

soup.find(id="link3")
# <a class="sister" href="http://example.com/tillie" id="link3">Tillie</a>
```

이때 hrml 태그를 제거한 텍스트를 얻으려면 "html.parser" 인자 값을 넘깁니다.

```
def removeHtmlTags(text):
    soup = BeautifulSoup(text, "html.parser")
    txt = soup.get_text(separator=" ")
    return txt
```



### 구두점 제거

구두점 제거는 간단한다.

```
out = "".join(c for c in asking if c not in ('!','.',':'))
```



## 2. 텍스트 정규화

텍스트 정규화는 자연어 처리에 앞서 처리 형태에 맞추는 정제 작업다. 텍스트 정규화를 하는 목적은 표준화된 단어를 식별해 계산 또는 처리 성능을 높이기 위한 목적다. 한국어는 교착어(agglutinative langauge)의 특성이 있다. 교착어는 고립어와 굴절어의 중간 정도에 행당하는 언어이다.

```
고립어 : 교착어는 낱말 변형이 없는 언어
굴절어 : 문장속의 문법적 기능에 따라 단어의 형태가 변하는 언어
```

`액자를 붙였다` 라고 했을때 여기서 `붙` (어간)이 중심 의미에 해당하고 `액자를 붙였다`, 액자를 `붙이었다`  대신에 `액자를 붙` 과 같은 형태로 어간 자체를 중심 의미로 두어 임베딩 하면 의미를 유지하면서도, N개의 워드 임베딩을 1개의 워드 임베딩만 해도 되도록 계산량을 줄일 수 있다. 텍스트 정규화 처리를 위한 방식에는 단위 치환, 스테밍과 같은 표준화 방식과 토큰화, 문장 분리와 같은 분리 방식이 있다.

단위 치환, 스테밍, 토큰화, 문장 분리 등의 처리가 있다.



### 단위 치환

단위를 나타내는 명사는 띄어쓰기 표준이 존재한다.

```
제2절   의존 명사, 단위를 나타내는 명사 및 열거하는 말 등
제42항  의존 명사는 띄어 쓴다.
제43항  단위를 나타내는 명사는 띄어 쓴다.
제44항  수를 적을 적에는 ‘만(萬)’ 단위로 띄어 쓴다.
십이억 삼천사백오십육만 칠천팔백구십팔, 12억 3456만 7898
```

그런데 위와 같은 띄어쓰기 표준을 지켜 단위 치환도 고려할 수 있다. 화폐 단위를 치환해 정규화 전 후를 보면 다음과 같다.

| 정규화 전                                                    | 정규화 후           |
| ------------------------------------------------------------ | ------------------- |
| 300 달러, `$ 300`, `300 $`,`300 dollors`, ...                | `$300`, 300 달러    |
| 300 `삼백만원`, 300 만(WON), 3백만원, 3백(만원), 3,000,000원, 3,000,000 ₩, ... | `₩3,000,000`, 300만 |

화폐 단위 표기를 일관성 있게 표기 함으로서 계산 비용을 낮추고 코퍼스 분석 오류를 줄일 수 있다.



### 스테밍

스테밍(stemming)은 어형 변화를 일으키는 접사(의존 형태소)를 제거하여 어간을 분리하는 처리다. 스테밍을 처리할 때는 품사 정보를 고려해 임베딩 하기 위해 형태소 분석기를 이용할 수 있다. `덧붙이다`의 형태소는 다음과 같이 분석될 수 있다.

| 단어     | 어간 | 어미 | 어근 | 접사   |
| -------- | ---- | ---- | ---- | ------ |
| 덧붙이다 | 덧부 | 다   | 붙   | 덧, 이 |

스테밍은 변형 단어들을 어근(root)으로 치환해 계산량을 줄이려는 목적이 있다. 한글에서 어근은 단어의 실질적인 의미로 조사 외의 8품사에만 어근이 존재한다. 조사를 제외한 8품사는 ```명사, 대명사, 수사, 동사, 형용사, 관형사, 부사, 감탄사``` 가 있다.

| 단어         | 출력(접두사) | 출력(어근) | 출력(접미사) | 출력(어미) |
| ------------ | ------------ | ---------- | ------------ | ---------- |
| 간단하다     |              | 간단       | 하           | 다         |
| 거무스름하다 |              | 거무스름   | 하           | 다         |
| 그만하다     |              | 그만       | 하           | 다         |
| 샛노랗다     | 샛           | 노랗       |              | 다         |
| 짓밞히다     | 짓           | 밟         | 히           | 다         |

스테밍을 처리할때 어근은 다른 형태소(접두사, 접미사, 어미)와 분리한다. 어근에는 접미사가 붙는 경우가 많은데 역할이 어근에 붙어 의미를 더해주는 역할을 한다.



[스테밍 처리 생략]

| 단어   | 어근 | 접미사 |
| ------ | ---- | ------ |
| 지우개 | 지우 | 개     |
| 먹이   | 먹   | 이     |



### 세그멘테이션(segmentation)과 토큰화

세그멘테이션(segmentation)은 텍스트를 문단, 문장 단위로 분리하는 정규화 작업을 일컫다. 이러한 세그멘테이션 종류에는 문단 세그멘테이션과 문장 세그멘테이션이 있다. `문단 세그멘테이션`은 n개의 문장으로 이뤄진 문장 그룹을 분리하는 처리를 일컫다. 문단은 중심 문장과 뒷받침 문장으로 이뤄집니다. `문장 세그멘테이션`은 문단을 구성하는 문장을 분리하는 처리를 일컫다. 문장은 주어와 동사를 포함한 단어의 집합다.

토큰화(tokenization)는 언어 통계 모델을 고려할때 필요한 정규화 방법다. 문장을 공백 단위로 분절한 각 단어를 토큰(token)이라 하며, 토큰 n개에 대해 토큰열 이라 한다. 컴파일러에서 토큰은 예약어, 식별자, 리터럴 상수, 특수 기호 등을 의미한다. 비슷한 맥락으로 자연어 처리에서 토큰은 `단어`를 의미한다.

