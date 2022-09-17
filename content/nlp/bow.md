---
title: "Bag-Of-Words 모델"
date: 2020-01-31T01:21:05+03:00
draft: false
---

### Bag-Of-Words

Bag-Of-Word는 순서를 단어 순서를 고려하지 않고 출현 빈도만 고려합니다. Bag-Of-Words 관점에서 "the dog bite you"와 "you bite the dog"는 어순은 다르지만 동일한 벡터로 표현 되어 동일한 문장으로 취급됩니다. 이들 두 문장에 대한 BoW를 만드는 방법은 두 단계로 진행합니다.

- 데이터 준비 : 텍스트를 수집합니다. 그리고 토큰화(tokenize)를 합니다.
- 어휘 벡터 만들기 : 단어를 토큰화(tokenize) 하여 어휘(vocabulary 벡터(0으로 초기화된 zero 벡터)를 만듭니다.
- 단어가 문서에 있으면 1, 단어가 문서에 없으면 0으로 표시합니다.

```
{"the":1, "dog":1, "bite":1 ,"you",1}
{"the":1, "dog":1, "bite":1 ,"you",1}
```

BoW를 코드로 구현해 보겠습니다.

```
import nltk 
import re 
import numpy as np 
import heapq
from nltk.corpus import stopwords

# 텍스트를 문장 단위로 나누기
def getSentences(text):
    sentences = nltk.sent_tokenize(text) 
    for i in range(len(sentences)): 
        sentences[i] = sentences[i].lower()
        sentences[i] = re.sub(r'\W', ' ', sentences[i]) # 알파벳(문자), 숫자, _가 아닌 문자는 공백으로 치환
        sentences[i] = re.sub(r'\s+', ' ', sentences[i]) # N개 공백을 하나의 공백으로 치환하고
        sentences[i] = sentences[i].lower().strip()
    return sentences

# 불요어 제거
def removeStopwords(sentence):
    wordlist = sentence.split()
    listStopWords = stopwords.words('english')
    wordlist = [w for w in wordlist if w not in listStopWords]
    return wordlist

# 어휘 집합 구하기
def getFreqVocabulary(sentences):
    vocabulary = {} 
    for sentence in sentences:
        words = removeStopwords(sentence)
        for word in words: 
            if word not in vocabulary.keys(): 
                vocabulary[word] = 1
            else: 
                vocabulary[word] += 1
    return vocabulary

# BoW 벡터 목록 얻기
def getBowVectors(vocabulary):
    # 상위 빈도수 기준 N개의 아이템을 찾음
    topFreqWords = heapq.nlargest(30, vocabulary, key=vocabulary.get)
    bowVectors = [] 
    for sentence in sentences: 
        bowVector = []
        words = nltk.word_tokenize(sentence)
        for word in topFreqWords: 
            if word in words: 
                bowVector.append(1) 
            else: 
                bowVector.append(0) 
        bowVectors.append(bowVector)
    return bowVectors

text = "Twinkle, Twinkle, little start. How I Wonder what you are. Up above the world so high. Like a diamond in the sky. Twinkle, Twinkle little start. how I wonder what you are.;"

sentences = getSentences(text)
print("문장 집합 : {}".format(sentences))

vocabulary = getFreqVocabulary(sentences)
print("어휘 : {}".format(vocabulary))

bowVectors = getBowVectors(vocabulary)
print("Bag Of Words 벡터 : {}".format(bowVectors))
```

이후 이러한 순서 적인 약점을 보완하기 위해 n-gram이 등장하게 됐습니다.