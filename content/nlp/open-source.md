---
title: "자연어처리 라이브러리 소개"
date: 2020-01-15T06:38:57+03:00
draft: false
---

자연어처리 모듈을 처음 부터 모두 개발하는 것은 쉽지 않습니다. 따라서 필요로 하는 자언어 처리 알고리즘이 이미 구현되어 있다면 효율적인 진행을 위해 공개된 자연어처리 라이브러리를 적절히 이용하는 것이 좋습니다. 오픈소스로 공개된 자연어처리 라이브러리는 그 수가 많습니다. 본문에서는 주요 **자연어처리 라이브러리**를 소개하며 어떤 점을 활용하면 좋을지를 소개 하겠습니다.



### 자연어처리 툴킷(NLTK)

***[NLTK](https://www.nltk.org/#)***(Natural Language Toolkit)는 언어 처리 기능을 제공하는 파이썬 라이브러리입니다. 손쉽게 이용할 수 있도록 모듈 형식으로 제공하고 있습니다. 이러한 모듈의 범주로 분류 토큰화(tokenization), 스테밍(stemming)와 같은 언어 전처리 모듈 부터 구문분석(parsing)과 같은 언어 분석, 클러스터링, 감정 분석(sentiment analysis), 태깅(tagging)과 같은 분석 모듈 시맨틱 추론(semantic reasoning)과 같이 보다 고차원 적인 추론 모듈도 제공하고 있습니다. 각 모듈에서 사용하는 알고리즘은 최소 2개 이상의 알고리즘을 제공하고 있어, 사용자가 원하는 알고리즘을 폭넓게 사용할 수 있도록 돕습니다. 예를 들어 분류 알고리즘의 경우 SVMs, 나이브 베이즈(Naive Bayes), 로지스틱 회귀(logistic regression)와 결정 트리(decision trees)를 제공하고 있고 이들 중 하나를 선택해 분류 알고리즘을 적용할 수 있습니다. 무엇보다 NLTK는 문서화가 잘 되어 있고 포럼이 있어 개발 지원을 받을 수 있으며, 인지도 만큼 레퍼런스도 많다는 장점이 있습니다. 단점은 다른 도구에 비해 약간 느리다는 점입니다.



- https://www.nltk.org/



### 스탠포드 코어 NLP

[스탠포드 CoreNLP](https://stanfordnlp.github.io/CoreNLP/) 는 통계 NLP와 딥러닝 NLP, 규칙 기반 NLP 기능을 지원하는 자바 기반 라이브러리입니다. 자바 외에도 많은 프로그래밍 언어에서 사용가능합니다. 듀얼 라이선스(dual-licensed) 기반으로 특별 라이선스(special license)는 상용 목적으로 사용할 수 있습니다. 상요 외에도 연구 실험을 위한 훌륭한 도구로 활용 되지만 상용에 적용하기 위해서는 라이선스 비용이 발생합니다. 스탠포드 NLP는 파이썬 버전이 있습니다. 자바 버전 보다 사용자 층이 두텁기 때문에 파이썬 프로젝트로 언어 프로젝트를 관리하고 한다면 스탠포드 NLP 파이썬 버전을 이용할 수 있습니다.

- https://stanfordnlp.github.io/stanfordnlp/



### 아파치 오픈 NLP

[아파치 오픈 NLP](https://opennlp.apache.org/)는 머신러닝 기반의 언어 처리를 지원하는 자바 기반의 라이브러리입니다. 토큰화, 문장 분리(sentence segmentation), POS 태깅, NER 등과 관련한 언어 처리를 지원합니다. 스탠포드 CoreNLP 툴셋과 기능적으로 유사하지만 라이선스가 다릅니다. 아파치 오픈 NLP는 [아파치 2.0 라이선스](http://www.apache.org/licenses/LICENSE-2.0)여서 아파치 2.0 라이서스 사본을 포함한다면 상용 라이선스 적용이 가능하며 소스코드 공개 의무가 없습니다. 반면 스탠포드 CoreNLP는 [GNU라이선스](http://www.gnu.org/licenses/gpl-3.0.html)입니다. 즉 수정한 코드의 공개 의무가 있습니다. 파이퍼폭스, 마리아DB가 대표적인 사례입니다.

- https://opennlp.apache.org/docs/



### 구글 슬링

[구글 슬링](https://github.com/google/sling)은 지식 베이스 완성을 목적으로 위키피디아 문서 읽고 이해하는 것을 목적으로 합니다. 예를 들어 위 문서에 언급된 사실(facts mentioned)을 지식 베이스에 추가 하려는 것 입니다. [프레임 시맨틱(frame semantics)](https://github.com/google/sling/blob/master/doc/guide/frames.md)를 이용해 지식 표현과 문서 애노테이션을 나타냅니다. SLING 구문 분석기(parser) 명시적인 개입(explicit intervening)하는 언어 표현 없이 텍스트의 프레임을 생성 하도록 훈련할 수 있습니다.

- https://github.com/google/sling



### MALLET

MALLET(MAchine Learning for LanguagE Toolkit)은 앤드류 맥칼룸(Andrew	McCallum)와 동료들이 만든 자바 기반 라이브러리입니다. 문서 분류, 정보 추출, 시퀀스 태깅, 토픽 모델링을 수행할 수 있습니다. MALLET은 지정된 포맷을 읽어 들여 학습을 수행할 수 있습니다.

```
bin/mallet train-classifier --input training.mallet --output-classifier my.classifier
```

레이블링 없는 데이터에 대해 테스트할 수 있습니다.

```
bin/mallet classify-file --input data --output - --classifier classifier
bin/mallet classify-dir --input datadir --output - --classifier classifier
```

- http://mallet.cs.umass.edu/



### Gensim

Gensim(Generate Similar)은 NLP와 정보 검색 도메인에서 활용할 수 있는 토픽 모델을 위한 파이썬 라이브러리입니다. 2008년 파이썬 수학 라이브러리로 시작 되었고,  대규모 코퍼스에서 문서 인덱싱과 유사도 검색에 활용할 수 있습니다.

- https://radimrehurek.com/gensim/index.html
- https://github.com/RaRe-Technologies/gensim

