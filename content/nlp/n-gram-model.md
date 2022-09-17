---
title: "n-gram 모델"
date: 2020-01-31T01:21:05+03:00
draft: false
---

### n-gram 모델

**n-gram** 모델은 자연어 처리, 정보 검색 등에서 활용이 되는 시퀀스 데이터 표현 방식입니다. 자연어 처리에서는 문서 또는 문장을 벡터로 변환해 자연어 처리의 여러 응용 분야에 활용할 수 있도록 합니다. 예를 들어 다음 단어를 예측해야 하는 오타 교정과 같은 분야에 활용될 수 있습니다. 정보 검색에서는 문서에 나타난 단어들의 분포들을 고려해 문서 간의 유사도 계산해 **문서 분류**(document classification)에 활용합니다. ngram에서 n은 연속된 단어의 개수를 의미합니다. 여기서 각 단어는 토큰(token)이라 하며 토큰 개수(n)에 따라 다음과 같이 부릅니다.

- n=1 : 1-gram(unigram)
- n=2 : 2-gram(bigram)
- n=3: 3-gram(trigram)
- n=4 : 4-gram
- ...

n-gram 모델에서 단어가 $w_i$ 부터 $w_{i-1}$ 개 단어가 나열 되었을때 i번째 단어 $w_i$ 의 확률 $P(w_i\mid w_1,\ldots,w_{i-1})$  문장  $w_1,\ldots,w_m$ 에서 얻어진 학률 $P(w_1,\ldots,w_m)$ 입니다. 

$$
P(w_1,\ldots,w_m) = \prod^m_{i=1} P(w_i\mid w_1,\ldots,w_{i-1})
 \approx \prod^m_{i=1} P(w_i\mid w_{i-(n-1)},\ldots,w_{i-1})
$$


n-gram은 빈도수 값을 이용해 조건 확률을 계산할 수 있습니다.
$$
P(w_i\mid w_{i-(n-1)},\ldots,w_{i-1}) = \frac{\mathrm{count}(w_{i-(n-1)},\ldots,w_{i-1},w_i)}{\mathrm{count}(w_{i-(n-1)},\ldots,w_{i-1})}
$$


### 어휘 벡터 생성

n-gram 기반으로 단어 시퀀스를 만들어 보겠습니다. n-gram 기반으로 단어 시퀀스를 만들려면 n-gram 어휘 벡터를 만들 수 있어야 합니다. n-gram 어휘 벡터는 처리하려는 데이터셋에 등장하는 어휘 집합을 의미합니다. 예를 들어 "동해 물과 백두산이 마르고 닳도록 하느님이 보우하사 우리나라 만세 무궁화 삼천리 화려강산 대한 사람 대한으로 길이 보전하세"라는 문장의 어휘 벡터는 다음과 같이 나타냅니다.

```
[['동해'], ['물과'], ['백두산이'], ['마르고'], ['닳도록'], ['하느님이'], ['보우하사'], ['우리나라'], ['만세'], ['무궁화'], ['삼천리'], ['화려강산'], ['대한'], ['사람'], ['대한으로'], ['길이'], ['보전하세']]
```

위와 같이 n-gram 어휘 벡터를 생성하는 모듈을 만들어 보면 아래와 같습니다.

[예제] /language-model/ngram.py

```
# n-gram 어휘 벡터 생성
def getNgramWord(N,txt):
    txt = txt.split()
    ngrams = [txt[i:i+N] for i in range(len(txt)-N+1)]
    return ngrams

# n-gram 어휘 벡터의 빈도수 추출
def getFrequencyVector(N, documentTxt, arrVocabulary):
    # arrVocabulary 길이로 Bag-Of-Words 벡터 초기화
    vectorBoW = [0] * len(arrVocabulary)

    # n-gram 빈도수 벡터 생성
    words = getNgramWord(N, documentTxt)
    for word in words:
        wordIndex = arrVocabulary.index(word)
        vectorBoW[wordIndex] = 1
    return vectorBoW
```

위 모듈중에 getNgramWord 함수를 이용해 n이 1, 2, 3인 어휘 벡터를 만들어 보겠습니다.

[예제] /language-model/test-ngram-getNgramWord.py

```
from ngram import getNgramWord

txt = "동해 물과 백두산이 마르고 닳도록 하느님이 보우하사 우리나라 만세 무궁화 삼천리 화려강산 대한 사람 대한으로 길이 보전하세"
print("1-gram : " + str(getNgramWord(1, txt))) # unigram
print("2-gram : " + str(getNgramWord(2, txt))) # bigram
print("3-gram : " + str(getNgramWord(3, txt))) # trigram
```

실행 결과

```
1-gram : [['동해'], ['물과'], ['백두산이'], ['마르고'], ['닳도록'], ['하느님이'], ['보우하사'], ['우리나라'], ['만세'], ['무궁화'], ['삼천리'], ['화려강산'], ['대한'], ['사람'], ['대한으로'], ['길이'], ['보전하세']]
2-gram : [['동해', '물과'], ['물과', '백두산이'], ['백두산이', '마르고'], ['마르고', '닳도록'], ['닳도록', '하느님이'], ['하느님이', '보우하사'], ['보우하사', '우리나라'], ['우리나라', '만세'], ['만세', '무궁화'], ['무궁화', '삼천리'], ['삼천리', '화려강산'], ['화려강산', '대한'], ['대한', '사람'], ['사람', '대한으로'], ['대한으로', '길이'], ['길이', '보전하세']]
3-gram : [['동해', '물과', '백두산이'], ['물과', '백두산이', '마르고'], ['백두산이', '마르고', '닳도록'], ['마르고', '닳도록', '하느님이'], ['닳도록', '하느님이', '보우하사'], ['하느님이', '보우하사', '우리나라'], ['보우하사', '우리나라', '만세'], ['우리나라', '만세', '무궁화'], ['만세', '무궁화', '삼천리'], ['무궁화', '삼천리', '화려강산'], ['삼천리', '화려강산', '대한'], ['화려강산', '대한', '사람'], ['대한', '사람', '대한으로'], ['사람', '대한으로', '길이'], ['대한으로', '길이', '보전하세']]
```



### n-gram  모듈

n-gram 벡터를 생성하기 위해 n-gram 모듈을 만들어 보겠습니다. n-gram 모듈은 문서 집합에 나타난 n-gram에 해당하는 전체 어휘 벡터와, 빈도수 벡터를 생성하는 모듈입니다. 먼저 n개의 문서로 구성된 문서 집합을 준비합니다.

```
documents = [
"동해 물과 백두산이 마르고 닳도록 하느님이 보우하사 우리나라 만세 무궁화 삼천리 화려강산 대한 사람 대한으로 길이 보전하세",
"떴다 떴다 비행기 날아라 날아라 높이 높이 날아라 우리 비행기",
"엄마 앞에서 짝짜꿍 아빠 앞에서 짝짜꿍 엄마 한숨은 잠자고 아빠 주름살 펴져라",
"반짝반짝 작은 별 아름답게 비치네 동쪽 하늘에서도",
"이 기상과 이 맘으로 충성을 다하여 괴로우나 즐거우나 나라 사랑하세 무궁화 삼천리 화려강산 대한 사람 대한으로 길이 보전하세"]
```

위 문서 집합에 대해 n-gram을 고려하려면 하나의 문서가 아닌 전체 문서 집합에 대한 n-gram 벡터를 만들어야 합니다. 

[예제] /language-model/ngramDocument.py

```
from ngram import getNgramWord, getFrequencyVector

# 전체 문서의 n-gram 어휘 벡터 생성
def getVocabularyAllDocuments(N, arr):
    allVocabulary = []
    for documentTxt in arr:
        ngramWords = getNgramWord(N, documentTxt)
        for word in ngramWords:
            if word not in allVocabulary:
                allVocabulary.append(word)
    return allVocabulary

# 전체 문서에 대한 빈도수 벡터 생성
def getNgramDocuments(N, documents):
    allVocabulary = getVocabularyAllDocuments(N, documents)
    bowDocuments = []

    # 각 문서에 대한 빈도수 벡터를 합쳐 하나의 빈도수 벡터로 만듦
    for document in documents:
        vectorBow = getFrequencyVector(N, document, allVocabulary)
        bowDocuments.append(vectorBow)
    return bowDocuments
```



### unigram 벡터

unigram은 **Bag-Of-Words**(이하 BoW)라는 표현 간소화 방법입니다. 유니 그램은 어순 정보를 고려하지 않습니다. 따라서 어순 정보만 다른 두 문장은 동일 문장이 됩니다.

- 동해 물과 백두산이 마르고 닳도록
- 닳도록 마르고 백두산이 물과 동해

위 두 문장은 모두 아래와 같이 동일한 빈도수를 가집니다. 빈도수 요소인 unigram 벡터는 아래와 같습니다.

| 동해 | 물과 | 백두산이 | 마르고 | 닳도록 |
| ---- | ---- | -------- | ------ | ------ |
| 1    | 1    | 1        | 1      | 1      |

문장을 좀더 긴 문서 단위로 고려해도 unigram 결과는 동일합니다. 아래는 애국가 1절 가사를 하나의 문서로 보고 첫번째 문서를 정방향 어순으로 고려하고 있고 두번째 문서를 역방향 어순으로 고려하고 있습니다.

```
documents = [
"동해 물과 백두산이 마르고 닳도록 하느님이 보우하사 우리나라 만세 무궁화 삼천리 화려강산 대한 사람 대한으로 길이 보전하세",
"보전하세 길이 대한으로 사람 대한 화려강산 삼천리 무궁화 만세 우리나라 보우하사 하느님이 닳도록마르고 백두산이 물과 동해"]
```

이 예제를 앞서 만든 n-gram 벡터 모듈을 이용해 위 두 문장의 unigram 벡터 결과를 확인해 보겠습니다.



[예제] /langugage-model/test-1gram.py

```
from ngramDocument import getNgramDocuments

documents = [
"동해 물과 백두산이 마르고 닳도록 하느님이 보우하사 우리나라 만세 무궁화 삼천리 화려강산 대한 사람 대한으로 길이 보전하세",
"보전하세 길이 대한으로 사람 대한 화려강산 삼천리 무궁화 만세 우리나라 보우하사 하느님이 닳도록 마르고 백두산이 물과 동해"]

N = 1
oneGramVectors = getNgramDocuments(N, documents)
for i, vector in enumerate(oneGramVectors):
    print(documents[i]," : ",vector)
```

실행 결과

```
동해 물과 백두산이 마르고 닳도록 하느님이 보우하사 우리나라 만세 무궁화 삼천리 화려강산 대한 사람 대한으로 길이 보전하세  :  [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
보전하세 길이 대한으로 사람 대한 화려강산 삼천리 무궁화 만세 우리나라 보우하사 하느님이 닳도록 마르고 백두산이 물과 동해  :  [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
```

위 예제의 입력은 어순 정보만 바꾼 동일한 벡터입니다. 또한 실행 결과에서 확인할 수 있듯이 Bow 관점에서 두 문장은 동일한 벡터 입니다. 



### bigram 벡터

unigram은 단어 순서가 고려하지 하지 않아 문맥 의미가 제대로 반영 되지 않는 문제가 있습니다. 이러한 문제는 bigram 이상인 경우 해소 할 수 있습니다. n-gram 파라메터만 1에서 2로 바꿔 다시 확인해 보겠습니다.

[예제] /langugage-model/test-1gram.py

```
from ngramDocument import getNgramDocuments

documents = [
"동해 물과 백두산이 마르고 닳도록 하느님이 보우하사 우리나라 만세 무궁화 삼천리 화려강산 대한 사람 대한으로 길이 보전하세",
"보전하세 길이 대한으로 사람 대한 화려강산 삼천리 무궁화 만세 우리나라 보우하사 하느님이 닳도록 마르고 백두산이 물과 동해"]

N = 2
oneGramVectors = getNgramDocuments(N, documents)
for i, vector in enumerate(oneGramVectors):
    print(documents[i]," : ",vector)
```

실행 결과

```
동해 물과 백두산이 마르고 닳도록 하느님이 보우하사 우리나라 만세 무궁화 삼천리 화려강산 대한 사람 대한으로 길이 보전하세  :  [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
보전하세 길이 대한으로 사람 대한 화려강산 삼천리 무궁화 만세 우리나라 보우하사 하느님이 닳도록 마르고 백두산이 물과 동해  :  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
```

실행 결과에서 확인할 수 있듯이 n-gram의 n이 2이상 부터는 순서가 고려되기 때문에 동일 어휘가 사용된 두 문서라 할지라도 n-gram 벡터는 일치하지 않아 unigram에서 나타난 순서가 바뀌었을때의 문제를 해소할 수 있습니다



### N-Gram의 문제

n-gram은 데이터 표현 방식이 단순 한 반면 크게 다음과 같은 문제가 있습니다.

- 데이터 희소성(data sparsity) 문제
- 롱텀 의존성(*Long*-*Term* Dependencies) 문제

