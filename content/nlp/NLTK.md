---
title: "NLTK를 이용한 자연어 처리"
date: 2020-02-19T07:01:31+03:00
draft: false
---

***[NLTK](https://www.nltk.org/#)***(Natural Language Toolkit)는 언어 처리 기능을 제공하는 파이썬 라이브러리입니다. 손쉽게 이용할 수 있도록 모듈 형식으로 제공하고 있습니다. 이러한 모듈의 범주로 분류 토큰화(tokenization), 스테밍(stemming)와 같은 언어 전처리 모듈 부터 구문분석(parsing)과 같은 언어 분석, 클러스터링, 감정 분석(sentiment analysis), 태깅(tagging)과 같은 분석 모듈 시맨틱 추론(semantic reasoning)과 같이 보다 고차원 적인 추론 모듈도 제공하고 있습니다. 각 모듈에서 사용하는 알고리즘은 최소 2개 이상의 알고리즘을 제공하고 있어, 사용자가 원하는 알고리즘을 폭넓게 사용할 수 있도록 돕습니다. 예를 들어 분류 알고리즘의 경우 SVMs, 나이브 베이즈(Naive Bayes), 로지스틱 회귀(logistic regression)와 결정 트리(decision trees)를 제공하고 있고 이들 중 하나를 선택해 분류 알고리즘을 적용할 수 있습니다. 무엇보다 NLTK는 문서화가 잘 되어 있고 포럼이 있어 개발 지원을 받을 수 있으며, 인지도 만큼 레퍼런스도 많다는 장점이 있습니다. 단점은 다른 도구에 비해 약간 느리다는 점입니다.



### NLTK 설치와 실행

NLTK 설치를 진행하기 위해 앞서 설치 환경을 확인합니다. NLTK는 파이썬 버전 기준 2.7, 3.5, 3.6, 또는 3.7 버전을 지원하고 있습니다. 파이썬 패키지 인스톨러인 pip를 이용해 NLTK를 인스톨합니다.

[맥 OS]

```
pip install --user -U nltk
```

```
$ pip install --user -U nltk
Collecting nltk
  Downloading nltk-3.4.5.zip (1.5 MB)
     |████████████████████████████████| 1.5 MB 232 kB/s 
...
Successfully built nltk
Installing collected packages: nltk
Successfully installed nltk-3.4.5
```

설치가 잘 되었는지 확인할 수 있습니다.

```
$ pip3 list | grep "nltk"
nltk                   3.4.5
```

이어서 NLTK에서 사용하는 라이브러리인 Numpy를 설치합니다.

```
pip install --user -U numpy
```



### 코퍼스 읽기

/nlltk/read_corpus.py

```
from nltk.corpus import PlaintextCorpusReader

def getWords(corpus_root,corpus_file):
    wordlists = PlaintextCorpusReader(corpus_root, '.*')
    wordlists.fileids()
    words = wordlists.words(corpus_file)
    return words

corpus_root = './input/'
corpus_file = 'bible.txt'
words = getWords(corpus_root,corpus_file)
print("단어 : {}".format(words))
print("개수 : {}".format(len(words)))
```

[실행 결과]

```
단어 : ['Gen', '.', '1', ':', '1', 'In', 'the', 'beginning', ...]
개수 : 1102788
```



### 불용어

불용어(Stopwords)는 높은 빈도수로 사용되는 고빈도 어휘 입니다. 불용어와 같은 고빈도 어휘들은 영어 뿐 아니라 대부분의 언어에 존재합니다. 불용어 활용의 예로 검색 엔진의 인덱싱 과정에서 입니다. 검색 엔진에서는 색인어를 생성하는 과정을 인덱싱(indexing)이라 합니다. 인덱싱에서 역 인덱싱(inverted indexing)은 사용자 검색어의 관련 문서를 빠르게 찾을 수 있도록 하는 색인 구축 방식입니다. 예를 들어 구글 트렌드의 인기 검색어(https://trends.google.com/trends/yis/2019/US/)중 "What is..." 그룹과 관련한 1위 검색어는 "What is Area 51"였습니다. 역 인덱싱 방식으로 구축 하면 다음과 같습니다.

|  단어   |          문서          |
| :-----: | :--------------------: |
|  What   | 문서 1, 문서 3, 문서 5 |
|   is    |     문서 2, 문서 3     |
| Area 51 |         문서 5         |

위 예시에서 What, is는 고빈도 어휘로 불용어입니다. 해당 단어를 인덱싱할 때 제거 한다면 인덱싱의 속도와 검색 효율성을 높일 수 있습니다. 자연어 처리에서 워드 임베딩 구축시 활용할 수 있습니다. Tomas Mikolov 연구자가 발표현 word2vec 알고리즘의 제안 [논문](https://papers.nips.cc/paper/5021-distributed-representations-of-words-and-phrases-and-their-compositionality.pdf) 에 따르면 임베딩 구축시 고빈도 어휘 제거를 통해 2배~10배의 성능 향상과 정확율 향상이 있음을 밝혔습니다.

NLTK에서는 자연어 처리 전처리에 필요한 용더로 불용어를 지원합니다. NLTK에서 지원하는 불용어는 별도 다운로드가 필요합니다.

/nltk/stopwords-download.py

```
import nltk
nltk.download('stopwords')
```

다운로드 마치고 나서 설치가 잘 되었는지 확인하겠습니다.

/nltk/stopwords-language.py

```
from nltk.corpus import stopwords
fileids = stopwords.fileids()
print("지원 언어 개수 : {}".format(len(fileids)))
print("지원 언어 목록 : {}".format(fileids))
```

[실행결과]

```
지원 언어 개수 : 23
지원 언어 목록 : ['arabic', 'azerbaijani', 'danish', 'dutch', 'english', 'finnish', 'french', 'german', 'greek', 'hungarian', 'indonesian', 'italian', 'kazakh', 'nepali', 'norwegian', 'portuguese', 'romanian', 'russian', 'slovene', 'spanish', 'swedish', 'tajik', 'turkish']
```

한국어는 지원 언어 목록에 없는 것으로 확인할 수 있습니다. 영어에 대한 불용어 목록 확인은 다음과 같이 할 수 있습니다.

```
from nltk.corpus import stopwords
listStopWords = stopwords.words('english')
print(listStopWords)
```

[실행 결과]

```
'i', 'me', 'my', 'myself', 'we', 'our', 'ours', 'ourselves', 'you', "you're", "you've", "you'll", "you'd", 'your', 'yours', 'yourself', 'yourselves', 'he', 'him', 'his', 'himself', 'she', "she's", 'her', 'hers', 'herself', 'it', "it's", 'its', 'itself', 'they', 'them', 'their', 'theirs', 'themselves', 'what', 'which', 'who', 'whom', 'this', 'that', "that'll", 'these', 'those', 'am', 'is', 'are', 'was', 'were', 'be', 'been', 'being', 'have', 'has', 'had', 'having', 'do', 'does', 'did', 'doing', 'a', 'an', 'the', 'and', 'but', 'if', 'or', 'because', 'as', 'until', 'while', 'of', 'at', 'by', 'for', 'with', 'about', 'against', 'between', 'into', 'through', 'during', 'before', 'after', 'above', 'below', 'to', 'from', 'up', 'down', 'in', 'out', 'on', 'off', 'over', 'under', 'again', 'further', 'then', 'once', 'here', 'there', 'when', 'where', 'why', 'how', 'all', 'any', 'both', 'each', 'few', 'more', 'most', 'other', 'some', 'such', 'no', 'nor', 'not', 'only', 'own', 'same', 'so', 'than', 'too', 'very', 's', 't', 'can', 'will', 'just', 'don', "don't", 'should', "should've", 'now', 'd', 'll', 'm', 'o', 're', 've', 'y', 'ain', 'aren', "aren't", 'couldn', "couldn't", 'didn', "didn't", 'doesn', "doesn't", 'hadn', "hadn't", 'hasn', "hasn't", 'haven', "haven't", 'isn', "isn't", 'ma', 'mightn', "mightn't", 'mustn', "mustn't", 'needn', "needn't", 'shan', "shan't", 'shouldn', "shouldn't", 'wasn', "wasn't", 'weren', "weren't", 'won', "won't", 'wouldn', "wouldn't"]
```



### Ngram 이용

NLTK는 bigrams을 처리할 수 있는 메서드를 지원합니다.

```
import nltk
txt = "동해 물과 백두산이 마르고 닳도록 하느님이 보우하사 우리나라 만세"
bigrams = list(nltk.bigrams(txt.split()))
print(bigrams)
```

[실행 결과]

```
[('동해', '물과'), ('물과', '백두산이'), ('백두산이', '마르고'), ('마르고', '닳도록'), ('닳도록', '하느님이'), ('하느님이', '보우하사'), ('보우하사', '우리나라'), ('우리나라', '만세')]
```

Trigrams을 처리할 수 있는 메서드를 지원합니다.

```
import nltk
txt = "동해 물과 백두산이 마르고 닳도록 하느님이 보우하사 우리나라 만세"
trigrams = list(nltk.trigrams(txt.split()))
print(trigrams)
```

```
[('동해', '물과', '백두산이'), ('물과', '백두산이', '마르고'), ('백두산이', '마르고', '닳도록'), ('마르고', '닳도록', '하느님이'), ('닳도록', '하느님이', '보우하사'), ('하느님이', '보우하사', '우리나라'), ('보우하사', '우리나라', '만세')]
```



## 에러

### numpy 설치 에러 대응

numpy 설치시 "The scripts f2py, f2py3 and f2py3.7 are installed"와 같은 에러가 표시 될 수 있습니다.

```
$ pip install --user -U numpy
Collecting numpy
  Downloading numpy-1.18.1-cp37-cp37m-macosx_10_9_x86_64.whl (15.1 MB)
     |████████████████████████████████| 15.1 MB 10.6 MB/s 
Installing collected packages: numpy
  WARNING: The scripts f2py, f2py3 and f2py3.7 are installed in '/Users/smarthome/.local/bin' which is not on PATH.
  Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.
Successfully installed numpy-1.18.1
(base) dialogucBookPro:testtorch smarthome$ 
```

파이썬 경로 설정이 필요합니다. 먼저 파이썬 설치 경로를 확인합니다.

```
$ which python
/Users/<사용자 계정명>/miniconda3/bin/python
```

그리고 PATH를 추가해 줍니다. vi 에디터를 엽니다.

```
$ vi /Users/<사용자 계정명>/.bashrc
```

아래 내용을 추가합니다.

```
export PATH=/Users/<사용자 계정명>/miniconda3/bin/python/bin:$PATH
```

그리고 반영해줍니다.

```
source /Users/<사용자 계정명>/.bashrc
```

