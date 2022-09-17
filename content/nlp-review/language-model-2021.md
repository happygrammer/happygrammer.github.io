---
title: "2021년 언어 모델"
date: 2021-08-15T20:34:21+03:00
draft: true
---

전이학습 관련한 사전 학습 언어 모델(pretrained language models)를 소개하고자 한다. 언어 모델은 언어 이해와 생성 관련해 많은 성능적인 개선을 보여줬다. 사전 학습된 언어 모델은 NLP의 다운 스트림 태스크에 적용하는 것은 하나의 연구 트랜드가 되었다. 언어 모델의 발전은 컴퓨팅 파워에 비례해 발전하고 있다.



- BERT : Transformer의 양방향 인코더의 약자이며, 모든 layer에 좌우 문맥을 조절하여 사전 훈련 되도록 설계됨, QA, NER과 같은 분야 등 11개의 NLP 태스크에서 최신 성능을 보였다.
- GPT2 : 수백만의 웹페이지(40GB, 800만 페이지 이상)를 비교사 학습을 수행하였다, 초대형 트랜스포머(`15억 4천 2백만개`의 파라메터, 48개 레이어) 기반 Large 모델이다. 
- XLNet
- Roberta
- ALBERT
- StructBERT
- GPT3
- T5
- ELECTRA
- DeBERTA
