---
title: "시맨틱 롤 레이블링 소개"
date: 2021-11-23T21:21:55+09:00
draft: false
---

`시맨틱 롤 레이블링`은 NLP 처리의 과정 중 하나이다. 시맨틱 롤 레이블링은 다른 말로 shallow semantic parsing, slot-filling, 의미역 결정과 같은 말로도 불린다. NLU를 하기 전의 가장 기본적인 접근은 형태소 분석과 구문 분석이다. 기본적인 처리가 끝나면 시맨틱 롤 레이블을 수행할 수 있다.



### 시맨틱 롤 레이블링 역사

SRL은 필모어([Charles J. Fillmore](https://en.wikipedia.org/wiki/Charles_J._Fillmore)) 연구자에 의해 제안된 방법이다. 초창기 연구에서는 predicate에 해당하는 역할을 찾으려는 시도들이 있었다. 이후 프레임 넷을 이용한  SRL이라는 방식으로 확장이 되었다.



### 시맨틱 롤의 종류

시맨틱 롤(role)이라는 것은 우리 말로 의미역(semantic role)이라고 볼 수 있다. 한국어에서 의미역은 크게 두가지 관점에서 볼수 있다.

1. 행위주(Agent) : 행위를 수행하는 주체
2. 피동주(Patient) : 행위에 영향 받는 대상

가수 `싸이는 뉴욕 타임 스퀘어에서 춤을 췄다`라는 문장이 있다고 해보자. `가수 싸이`는 행위주(agent)가 되고 여기서 중요 동사(predicate)는 `춤을 췄다`이다. 이를 시맨틱 롤 레이블링을 처리하면 다음과 같다.

```
[PERSON:가수 싸이]는 [LOCATION:뉴욕 타임 스퀘어]에서 [V:춤을 췄다].
```



단어는 주어, 동사, 목적어의 역할을 가질 수 있고, 주어는 행위주, 목적어는 주로 피동주가 된다. 행위주인지 피동주인지와 같이 역할 관점에서 분석을 수행하여 의미 태깅을 하는 과정을 시맨틱 롤 레이블링이라고 한다.

### 프레임넷의 렉시컬 유닛

프레임 넷은 하나의 단어에 대해서 문장내에 어떤 의미로 쓰였는지를 태깅한 데이터로 구성된다.  역할의 틀에 해당하는 대표어는 Frame이라 부르고, 다양한 역할의 형태를 Lexical Unit이라 부른다. 예를 들어 `Chatting` 프레임은 다음과 같은  레시컬 유닛(Lexical Unit)를 포함하고 있다.

```
badinage.n, banter.n, chat.n, chat.v, chit-chat.n, colloquy.n, conversation.n, converse.v, gab.v, gossip.n, gossip.v, joke.v, shoot the breeze.v, speak.v, talk.v, yak.v
```

담소를 의미하는 Chat(명사)일 수 있지만 농담을 수행하는 동사 joke.v 행위를 의미할 수 도 있다. 다음은 프레임넷의 `Chatting` 프레임에 대한 레시컬 유닛 인덱스 페이지이다.

<img src="../srl.png" style="width:80%;" alt="시맨틱 롤 레이블링">



### BERT 모델 기반의 시맨틱 롤 레이블링

BERT 모델 기반의 시맨틱 롤 레이블링이 가능하다. BER 모델 기반의 출력 결과를 확인하려면 ipynb파일을 만들고 모델에 입력을 전달해 주면 출력을 확인할 수 있다.

[실행예]

```
$ pip install allennlp==2.1.0 allennlp-models==2.1.0
echo '{"sentence": "Neuro-linguistic programming is a psychological approach that involves analyzing strategies used by successful individuals and applying them to reach a personal goal."}' | \
    allennlp predict https://storage.googleapis.com/allennlp-public-models/structured-prediction-srl-bert.2020.12.15.tar.gz -

```

자세한 사용법은 allennlp[[3]](https://pypi.org/project/allennlp-models/) 사이트를 참고한다. 시맨틱 롤 레이블링은 더 확장해 개체명 인식이나 질의 응답 태스크와 연관해 활용할 수 있다.



### 관련 자료

- [1] [Frame Net](https://framenet.icsi.berkeley.edu/fndrupal/about)
- [2] [Frame Index](https://framenet.icsi.berkeley.edu/fndrupal/frameIndex)
- [3] [allennlp](https://pypi.org/project/allennlp-models/)
- [4] [alllennlp SRL github](https://github.com/allenai/allennlp-models/tree/main/allennlp_models/structured_prediction)
