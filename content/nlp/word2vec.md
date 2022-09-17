---
title: "Word2vec를 이용한 임베딩"
date: 2020-02-03T23:33:53+03:00
draft: false
---

**Word2vec**은 워드 고품질의 워드 벡터를 생성하는 임베딩 태스크에 사용할 수 있는 모델입니다. 구글의 [Tomas Mikolov](https://en.wikipedia.org/wiki/Tomas_Mikolov)이 2013년에  [논문](https://arxiv.org/abs/1301.3781)으로 발표했습니다. 이 논문에서 소개하는 단어 예측 모델로 크게 CBOW와 Skip-gram을 소개합니다. CBOW는 Context 정보를 활용해 현재 단어를 예측 하는 모델이라면 Skip-gram은 현재 워드 주변의 단어를 예측하는 모델입니다. Word2vec을 실행하면 입력으로 대규모 텍스트 코퍼스를 수백 차원의 벡터 스페이스(vector space)로 만듭니다. 기존 LSA(latent semantic analysis)에 비해 여러 장점이 있습니다.

- 계산 비용이 적습니다.
- 정확도(accuracy)가 개선 됐습니다.



## gensim을 이용한 word2vec

### gensim 설치

```
pip install --upgrade gensim
```



### gensim api

word2vec model 호출

```
import gensim.downloader as api
wv = api.load('word2vec-google-news-300')
```

Gensim 모델 확인

```
word2vec.Word2Vec(["happy"], size=5, window=1, negative=3, min_count=1)
```

size는 워드 벡터 차원입니다. window는 현재 단어와 예측 단어의 최대 윈도우 사이즈입니다. negative는 얼마나 많은 노이즈 워드를 사용할지를 설정합니다. min_count는 무시할 단어가 있다면 min_count값을 설정합니다. min_count가 1이면 1개 이하로 출현한 단어는 무시라는 의미입니다.

### gensim을 이용한 word2vec 임베딩

분석을 위해 전세계에서 가장 많이 판매된 것으로 알려진 성경 코퍼스를 준비합니다.

```
from gensim.models import word2vec

with open('./gensim/input/bible.txt', 'r') as f:
     text = f.readlines()

token = []
for txt in text:
    token.append(txt.split()[1:])

embedding = word2vec.Word2Vec(token, size=10, window=5, negative=3, min_count=1, workers=3, sg=1)
embedding.save('./gensim/model/window-5-bible_without_analysis.model')
```

Word2Vec 모델 학습에 사용된 하이퍼 파라메터를 보면 다음과 같습니다.

- sentences : 각 문장 마다 하나의 토큰 list를 생성하며 토큰 list의 개수는 문장 개수 n개 만큼 생성하여 sentences에 저장해둠
- size : word 벡터 차원
- window : 현재 단어와 예측 단어의 최대 거리
- negative : 0으로 두면 negative smapling을 하지하지 않으며, 0보다 큰 값이면 negative sampling을 수행함
- min_count : min_count의 빈도수보다 낮은 빈도수인 단어는 무시합니다.
- worker : 모델 생성시 사용할 쓰레드 개수
- sg : sg 값이 1이면 skip-gram이지만 그렇지 않으면 CBOW 알고리즘을 이용합니다.

임베딩 모델을 ./gensim/bible.model에 저장했습니다. 해당 로드를 로드해 "사랑"이라는 어휘의 분석 결과를 확인해 보겠습니다.

```
from gensim.models import word2vec

input = "여호와는"
model = word2vec.Word2Vec.load('./gensim/model/window-5-bible_without_analysis.model')
try:
    arrSimilar = model.wv.most_similar(input)
    print(arrSimilar)
except:
    print("탐색 불가")
```

실행 결과

```
[('예수', 0.9934951663017273), ('구별하여', 0.992172122001648), ('이스라엘의', 0.9916245937347412), ('여호와의', 0.9914567470550537), ('찬양을', 0.9897100925445557), ('여호와를', 0.9891390800476074), ('우리', 0.9884810447692871), ('아버지와', 0.9881623387336731), ('앞에서', 0.9866857528686523), ('위하여', 0.9842418432235718)]
```



### konlp를 이용한 word2vec 임베딩

워드 임베딩 품질을 위해 특수  형태소 분석, 특수문자 제거와 같은 전처리가 필요할 수 있습니다.

konlp 설치

```
$ python3 -m pip install --upgrade pip
$ python3 -m pip install konlpy # 파이썬 3.x 버전에서 실행
```

mecab설치

```
bash <(curl -s https://raw.githubusercontent.com/konlpy/konlpy/master/scripts/mecab.sh)
```

먼저 word2vec을 이용한 임베딩 벡터를 만들어 보겠습니다.

```

from gensim.models import word2vec
from konlpy.tag import Kkma
from konlpy.utils import pprint

kkma = Kkma()

with open('./gensim/input/bible.txt', 'r') as f:
     text = f.readlines()

token = []
for txt in text:
    refinedTxt = " ".join(txt.split()[1:])
    print(refinedTxt)
    token.append(kkma.nouns(refinedTxt))

embedding = word2vec.Word2Vec(token, size=10, window=5, negative=3, min_count=0)
embedding.save('./gensim/model/window-5-bible.model')
```

만들어진 임베딩 벡터를 테스트 해보겠습니다.

```
from gensim.models import word2vec
from konlpy.tag import Kkma
from konlpy.utils import pprint

kkma = Kkma()

input = "믿음"
input = " ".join(kkma.nouns(input))
print(input)
model = word2vec.Word2Vec.load('./gensim/model/bible.model')
try:
    arrSimilar = model.wv.most_similar(input)
    print(arrSimilar)
except:
    print("탐색 불가")
```

실행 결과

```

```

