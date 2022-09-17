---
title: "Meena 논문, 리서치 리뷰"
date: 2020-02-14T01:10:05+03:00
draft: false
---

이 문서는 [Meena 논문](https://arxiv.org/abs/2001.09977)의  연구 결과를 되짚어 보기 위한 리서치 리뷰 문서이며 새로운 연구 결과를 포함하고 있지 않습니다.

Meena는 멀티턴 도메인 챗봇. `end-to-end` 방식의 데이터 학습 진행. public 도메인인 소셜 미디어 대화를 대상으로 하였음. 341 GB의 텍스트를 학습하였고 `26억(2.6 billions) ` 파라메터를 사용한 뉴럴넷입니다. 다음 토큰의 perplexity가 최소화 되도록 학습됨.

```
낮은 perplexity는 샘플에 대해 잘 설명할 수 있는 확률분포를 가졌음을 의미함
```

`OpenAI GPT-2`에 비해 1.7배 모델이 크고, 8.5배의 학습 데이터를 사용하였습니다.

- 참고로 GPT-2는 40G의 사이즈(8백만 웹페이지)



### Sensibleness and Specificity Average (SSA)

챗봇 품질의 사람 평가 기준이 복잡하고 일관성이 결여 되는 경향이 있습니다. 그래서 `Sensibleness and Specificity Average (SSA)`라고 하는 새로운 `사람 평가 지표`를 설계했습니다.



#### Meena의 SSA 점수

아래 결과는 Meena가 SSA 점수에 있어 기존 최신 챗봇에 비해 성능상의 큰 차이가 있음을 보이고 있고, SSA 점수에 있어 사람의 성능에 좁혀지고 있음을 보이고 있습니다

![](https://1.bp.blogspot.com/-ziInMSwWjhw/Xi9uCT3FnBI/AAAAAAAAFOM/-gk3XI9tH7AwLjPZdxoTd8GSHux_7kPyACEwYBhgL/s640/image2.png)

-  end-tp-end 훈련시 Meena는 SSA (72% 멀티턴 평가)를 기록함. 여기서 복잡성을 최적화 할 수 있다면 86%의 사람 수준까지 도달할 수 있음을 시사합니다.
- Meena의 풀버전(필터링 매커니즘과 튜닝된 디코딩 포함)은 79%의 SSA를 달성했습니다.
  - 기존 챗봇보다 23%더 높은 점수를 받은 것입니다.



#### sensible과 specific

sensible 구체적이지는 않지만 말이 되는지를 의미하며, 답변이 혼란스럽거나 구체적이지 않으면 0(doest not make sense)가 됨. specific은 대답히 구체적인지를 평가하는 척도가 되며, 좀더 섬세하게 이해가 있는지를 평가하는 척도입니다.

```
sensible : "나는 유재석을 좋아해 " => "잘 모르겠어"(구체적이지 않음)
specific : "나는 유재석을 좋아해 " => "나도 유재석이 좋더라"(구체적임)
```



### Introduction

we present Meena, a generative chatbot model that was trained end-to-end on 40B words mined and filtered from public domain social media conversations. With Meena, we push the limits of the end-to-end approach and show that a largescale low-perplexity model can be a good conversationalist.



### Meena 모델 학습 설정

Meena는 s**eq2seq model** (Sutskever et al., 2014; Bahdanau et al., 2015)을 이용했습니다. 이 모델은 진화된 트랜스 포머Evolved Transformer (So et al., 2019)를 메인 아키텍처로 이용했습니다. 모델은 멀티 턴 대화를 학습하였고, 입력 시퀀스는 최대 7까지의 맥락을 고려하고 있습니다. 출력 시퀀스는 답변이 됩니다.

- 26억 파라메터
- 최대 7턴을 고려하였으며, 입려 시퀀스와 출력 시퀀스의 Pair로 학습셋을 구성(입력 시퀀스=7턴의 대화, 출력 시퀀스=답변)
- 전체 페어는 8어 6천 7백만개
- tokenization: 8K(20^3) BPE with sentencepiece(Sennrich et al., 2016).



### Meena chatbot

Meena chatbot은 end-to-end 대화 모델이며 2개의 카테고리로 나뉩니다.

- (1) complex models with human-designed components
- (2) 큰 뉴럴넷 모델(end-to-end 모델)은 일반 학습 프레임워크에 가까움. End-to-end은 유망하나 한계가 있음 (Gao et al., 2019a)

An open question has been: in order to reach a point where a model can carry out high-quality, multi-turn conversations with humans, could we simply take an end-to-end model and make it bigger—by adding more training data and increasing its parameter count—or is it necessary to combine such a model with other components? In this section we describe the Meena model, the largest end-to-end model to enter the field so far. We believe it answers the open research question, by showing that a large end-toend model can generate almost humanlike chat responses in an open-domain setting. In this section, we will describe the training data, architecture, and decoding algorithm. We will also provide a few sample conversations that Meena has had with humans.



## 논문 링크

[https://arxiv.org/abs/2001.09977](https://arxiv.org/abs/2001.09977?fbclid=IwAR2-Ob6mlon0hqInSINRMmHDyo9Sigr4Y7rvlZFgaq-iuHOGP5k5NHPIUf4)