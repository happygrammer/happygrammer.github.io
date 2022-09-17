---
title: "언어 모델"
date: 2020-01-30T08:10:33+03:00
draft: false
---

**언어 모델**(language model)은 단어 시퀀스(word sequence)를 이용한 확률 모델입니다. 언어 모델은 기계 번역, 음성 인식, 오타 교정(spell correction), 손글씨 인식(handwriting recognition),  문서 요약, 질의 응답 생성 등과 같이 최종 출력인 단어 시퀀스를 예측하는 태스크에 사용됩니다.



### 확률 언어 모델

확률 언어 모델(probabilistic langugage model)은 하나의 단어(w) 앞에 나온 n개의 단어 시퀀스(word sequence)을 고려해 다음에 나올 단어를 예측하는 확률 모델입니다. n개의 단어가 연속해서 나는 단어 시퀀스의 확률 P(w1,w2,w3,...,wn)는 다음과 같습니다. 

```
P(W)=P(w1,w2,w3,...,wn)
```

즉, n개의 단어를 하나의 시퀀스로 보고  단어 시퀀스들의 결합 확률을 계산해 언어 모델을 만듭니다. 확률 언어 모델의 대표적인 예는 n-gram 모델이 있습니다.

