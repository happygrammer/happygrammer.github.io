---
title: "자연어처리/머신러닝 용어집"
date: 2020-04-07T00:15:52+03:00
draft: false
---

본 문서는  자연어처리/머신러닝 용어 목록을 소개합니다.

- Auto ML(Automated machine learning)
  - 엔지니어의 도움 없이도 머신 러닝 모델을 생성할 수 있는 머신러닝 솔루션
  - "Data 처리, Feature 엔지니어링, Feature 추출, Feature 선택"의 자동화 지원
  - 관련 솔루션
    - [Google Cloud Platform - Cloud AutoML](https://cloud.google.com/automl/?hl=ko)
    - [Google Cloud Platform - AutoML NLP](https://cloud.google.com/natural-language/automl/docs/features?hl=ko)
    - [Azure - Azure Machine Learning](https://azure.microsoft.com/ko-kr/services/machine-learning/)
    - [AWS - Amazon SageMaker](https://aws.amazon.com/ko/sagemaker/?nc2=h_ql_prod_ml_sm)
- Auto Regressive
  - AR(순차적인 데이터 처리)
  - 이러한 관점에서 ELmo, GPT를 AR 계열로 볼 수 있음
- BERT 
  - 양방향 언어 모델
  - 구글 브레인이 개발한 트랜스 포머 기반의 모델. 페이스북은 RoBERTa라는 새로운 알고리즘을 개발했다.
- Bootstrapping
  - 부스팅이라고도 불림, 샘플 데이터에서 랜덤 샘플링해 학습셋을 늘리는 방법으로, 정규 분포 성질을 가정함
  - 크기가 동일한 n개의 샘플셋으로 구성함

- CTRL
  - GPT-2보다 약간 더 큰 알고리즘으로, 글 스타일을 제어 가능
- ELMo(Embeddings from Language Model)
  - 2018년에 제안된 모델, 사전 훈련 언어 모델을 이용
  - 문맥을 고려해 임베딩(Contextualized Word Embedding)
    - 순방향, 역방향 RNN의 언어 모두를 고려한 biLM(Bidirectional Language Model)을 이용함
- Fine tuning
  - 프리트레인으로 공통 도메인 학습 후 파인 튜닝을 통해 다운스트림 태스크 맞게 데이터 추가 하여 파라미터를 미세 조정해 업데이트 하는 방법
  - 출력 층에 새로운 레이어를 추가, SGD(**Stochastic gradient descent**)를 수행함
- [GPT-2](https://github.com/openai/gpt-2)
  - 대규모 언어 모델(large-scale langugage model), 단방향 언어 모델, 자연어 생성분야에 주목 받는 모델
  - 오픈AI는 800만개의 웹 페이지에서 스랩된 15억개의 매개변수를 새로운 알고리즘으로 학습(GPT보다 Parameter와 데이터양이 10배 많아짐). 이 알고리즘을 이용해,  몇 문장에서 대부분 일관성 있는 몇 단락의 산문을 작성할 수 있게 되었다.
  - 파인튜닝 없이 `Language modeling benchmark`에서 SOTA(State Of The Art) 달성
- Neural Network
  - ANN(Artificial Neural Network) : 사람의 뇌에서 영감을 얻은 알고리즘으로 이미지 인식, 신호 인식 및 데이터 마이닝, 기계번역 등에서 활용 할 수 있는 모델
  - CNN : CNN은 데이터의 특징을 추출하여 특징들의 패턴을 파악하는 구조입니다. 이 CNN 알고리즘은 Convolution과정과 Pooling과정을 통해 진행
  - RNN : RNN 알고리즘은 반복적이고 순차적인 데이터(Sequential data)학습에 특화된 인공신경망의 한 종류로써 내부의 순환구조가 들어있다는 특징이 있음
  - DNN : ANN기법의 여러문제가 해결되면서 모델 내 은닉층을 많이 늘려서 학습의 결과를 향상시키는 방법이 등장하였고 이를 DNN(Deep Neural Network)라고 합니다. 딥러닝이라 부르며, DNN은 은닉층을 2개이상 지닌 학습 방법을 뜻함

- Outlier

  - 전체 데이터 패턴에서 비정상적으로 벗어난 값

- Permutation Language Model

- Random Forest

- - `배깅`의 대표 알고리즘으로, 다수의 결정 트리로 부터 보팅 데이터 예측을 수행

- Seq2Seq
  - 하나의 도메인(한국어 문장)에서 또 다른 도메인(영어 문장)의 변환 학습 모델
  - 언어 번역, 텍스트 요약, conversational model 등에 활용 가능
- SGD(**Stochastic gradient descent**)
  - gradient descent로 이동시 마다 전체 데이터 중 일부 데이터를 사용해 사용함으로서 local optima 방지

- Transformer Network
  - NIPS에 공개된 구글의 아키텍처로 GPT, BERT 등에서 사용됨
  - 트랜스포머 블록 상단에 피드 포워드 네트워크와 하단의 멀티헤드 어텐션으로 구성됨
    - 멀티헤드 어텐션은 Scaled Dot-Product Attention(문장내의 단어 쌍의 의미 관계 파악)을 N번 수행
    - 피드 포워드 네트워크는 입력을 받아, 가중치를 적용하여 출력으로 내보내는 네트워크
- Vanishing Gradient
  - Vanishing Gradient Problem(기울기값이 사라지는 문제)는 인공신경망을 기울기값을 이용한 method(backpropagation)에서 발생하는 문제다.(sigmoid가 원인이 될 수 있음)
    - ReLu : linear함수인 sigmoid를 개선한 함수
- Voting
  - 소프트보팅(soft voting) : k개의 분류기중 가장 큰 확률 값인 레이블을 선택하는 앙상블 방법
  - 하드보팅(hard voting)  : k개의 분류기중 가장 많이 출력된 레이블을 선택하는 앙상블 방법
- XLNET
  - XLNet은 구글(Yang et al., 2019)에서 발표한 아키텍처로 일부 데이터에 대해 BERT를 앞서는 성능을 보임
  - 트랜스포머 네트워크(Vaswani et al., 2017)를 개선한 Transformer XL(eXtra-Long)의 모델로, 기존 Transformer에 비해 좀더 넓은 Context를 볼 수 있게 됨
  - RNN(문장 레벨의 Recurrency를 고려함)

