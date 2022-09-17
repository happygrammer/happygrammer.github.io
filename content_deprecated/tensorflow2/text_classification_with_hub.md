---
title: "영화 리뷰 텍스트 분류"
date: 2020-01-15T06:34:47+03:00
draft: false
---

이글은 [text_classification_with_hub](https://www.tensorflow.org/tutorials/keras/text_classification_with_hub) 한국어 번역 문서입니다.

- [Run in Google Colab](https://colab.research.google.com/github/tensorflow/docs/blob/master/site/en/tutorials/keras/text_classification_with_hub.ipynb)
- [View source on GitHub](https://github.com/tensorflow/docs/blob/master/site/en/tutorials/keras/text_classification_with_hub.ipynb)
- [Download notebook](https://storage.googleapis.com/tensorflow_docs/docs/site/en/tutorials/keras/text_classification_with_hub.ipynb)

**노트북**은 리뷰 텍스트를 이용해 영화 리뷰을 긍정인지 부정인지를 분류하는 이진 분류를 수행합니다. 머신러닝 문제에 넓게 적용되는 중요한 예제입니다. 튜토리얼은 텐서플로우 허브와 케라스를 이용해 트랜스퍼 러닝(transfer learning)의 기본 응용 방법을 설명합니다.

- 역자주 : **트랜스퍼 러닝**은 **사전 학습 모델**(pre-trained mode)을 재사용하여 응용 모델을 구축하는 방법

[IMDB 데이터셋](https://www.tensorflow.org/api_docs/python/tf/keras/datasets/imdb) 은 5만개의 영화 리뷰([Internet Movie Database](https://www.imdb.com/))를 포함하고 있습니다. 2만 5천개 리뷰는 학습에 사용하고 나머지 2만 5천개는 테스팅에 사용합니다. 데이터는 긍정 리뷰와 부정 리뷰가 동일한 개수로 포함하고 있어 균형적입니다.

이 노트북은 [tf.keras](https://www.tensorflow.org/guide/keras)의 고수준 API를 사용해 텐서플로우 모델을 학습합니다. 그리고 [TensorFlow Hub](https://www.tensorflow.org/hub)는 라이브러리이며 트랜스퍼 러닝 수행을 위한 플랫폼입니다. 보다 개선된 텍스트 분류 튜토리얼은 [`tf.keras`](https://www.tensorflow.org/api_docs/python/tf/keras)를 사용합니다. [MLCC Text Classification Guide](https://developers.google.com/machine-learning/guides/text-classification/)확인 바랍니다.

```python
from __future__ import absolute_import, division, print_function, unicode_literals

import numpy as np

import tensorflow as tf

!pip install -q tensorflow-hub
!pip install -q tensorflow-datasets
import tensorflow_hub as hub
import tensorflow_datasets as tfds

print("Version: ", tf.__version__)
print("Eager mode: ", tf.executing_eagerly())
print("Hub version: ", hub.__version__)
print("GPU is", "available" if tf.config.experimental.list_physical_devices("GPU") else "NOT AVAILABLE")
Version:  2.0.0 Eager mode:  True Hub version:  0.7.0 GPU is available
```

### IMDB 데이터셋 다운로드

IMDB 데이터셋은 [imdb reviews](https://github.com/tensorflow/datasets/blob/master/docs/datasets.md#imdb_reviews) 또는 TensorFlow datasets](https://github.com/tensorflow/datasets)에서 이용할 수 있습니다.

```python
# Split the training set into 60% and 40%, so we'll end up with 15,000 examples
# for training, 10,000 examples for validation and 25,000 examples for testing.
train_validation_split = tfds.Split.TRAIN.subsplit([6, 4])

(train_data, validation_data), test_data = tfds.load(
    name="imdb_reviews", 
    split=(train_validation_split, tfds.Split.TEST),
    as_supervised=True)
Downloading and preparing dataset imdb_reviews (80.23 MiB) to /home/kbuilder/tensorflow_datasets/imdb_reviews/plain_text/0.1.0...

HBox(children=(IntProgress(value=1, bar_style='info', description='Dl Completed...', max=1, style=ProgressStyl…
HBox(children=(IntProgress(value=1, bar_style='info', description='Dl Size...', max=1, style=ProgressStyle(des…
(중략...)
Dataset imdb_reviews downloaded and prepared to /home/kbuilder/tensorflow_datasets/imdb_reviews/plain_text/0.1.0. Subsequent calls will reuse this data.
```

### 데이터 탐색

데이터 포맷에 대해 살펴보겠습니다. 각 예제는 영화 리뷰와 해당 영화 리뷰의 라벨입니다. 라벨은 0(부정) 또는 1(긍정)의 값입니다. 10개 예제를 출력해 보겠습니다.

```python
train_examples_batch, train_labels_batch = next(iter(train_data.batch(10)))
train_examples_batch
<tf.Tensor: id=219, shape=(10,), dtype=string, numpy=
array([b"As a lifelong fan of Dickens, I have invariably been disappointed by adaptations of his novels.<br /><br />Although his works presented an extremely accurate re-telling of human life at every level in Victorian Britain, throughout them all was a pervasive thread of humour that could be both playful or sarcastic as the narrative dictated. In a way, he was a literary caricaturist and cartoonist. He could be serious and hilarious in the same sentence. He pricked pride, lampooned arrogance,...(생략)"],
      dtype=object)>
```

10개 레벨을 출력해 보겠습니다.

```python
train_labels_batch
<tf.Tensor: id=220, shape=(10,), dtype=int64, numpy=array([1, 1, 1, 1, 1, 1, 0, 1, 1, 0])>
```

### 모델 빌드

뉴럴넷은 레이어를 쌓는 방식으로 생성하며 세가지의 주요 아키텍처를 고려해야 합니다.

- 텍스트의 표현 방식
- 모델에서 사용할 레이의 개수
- 각 레이어의 히든 유닛 개수

이 예제의 입력은 문장이며 레이블은 0 또는 1입니다. 문장을 임베딩 벡터로 나타내는 방법입니다. 여기서 사전 학습된(pre-trained) 텍스트 임베딩을 첫번째 레이어에 사용하겠습니다. 세가지 장점이 있습니다.

- 텍스트 전처리를 고민하지 않아도 됩니다.
- 전이 학습(transfer learning)의 장점이 있습니다.
- 임베딩은 고정 사이즈이며, 처리를 단순화 할 수 있습니다.

이 예제에서 사전 학습 임베딩 모델(pre-trained text embedding model)을 이용하겠습니다. 이 모델은 [TensorFlow Hub](https://www.tensorflow.org/hub) 에서 가져오며 [google/tf2-preview/gnews-swivel-20dim/1](https://tfhub.dev/google/tf2-preview/gnews-swivel-20dim/1)라 불립니다.

튜토리얼을 위한 세가지 사전 학습 모델을 테스트할 수 있습니다.

- [google/tf2-preview/gnews-swivel-20dim-with-oov/1](https://tfhub.dev/google/tf2-preview/gnews-swivel-20dim-with-oov/1) - same as [google/tf2-preview/gnews-swivel-20dim/1](https://tfhub.dev/google/tf2-preview/gnews-swivel-20dim/1), 2.5% 어휘를 OOV 버킷으로 변환합니다. 이것은 task의 어휘와 모델의 어휘가 완전히 겹치지 않을때 도움이 됩니다.
- [google/tf2-preview/nnlm-en-dim50/1](https://tfhub.dev/google/tf2-preview/nnlm-en-dim50/1) - ~1M 어휘 사이즈와 50 차원의 좀더 큰 모델.
- [google/tf2-preview/nnlm-en-dim128/1](https://tfhub.dev/google/tf2-preview/nnlm-en-dim128/1) - ~1M 어휘 사이즈와 128 차원의 훨씬 큰 모델.

텐서플로우 허브 모델을 사용해 케라스 레이어를 생성하고 몇개의 입력 예제에 대해 문장 임베딩을 하겠습니다. 입력 텍스트 길이와 상관없이 임베딩 출력 모양은 `(예제_개수, 임베딩_차원)`와 같습니다.

```python
embedding = "https://tfhub.dev/google/tf2-preview/gnews-swivel-20dim/1"
hub_layer = hub.KerasLayer(embedding, input_shape=[], 
                           dtype=tf.string, trainable=True)
hub_layer(train_examples_batch[:3])
<tf.Tensor: id=402, shape=(3, 20), dtype=float32, numpy=
array([[ 3.9819887 , -4.4838037 ,  5.177359  , -2.3643482 , -3.2938678 ,
        -3.5364532 , -2.4786978 ,  2.5525482 ,  6.688532  , -2.3076782 ,
        -1.9807833 ,  1.1315885 , -3.0339816 , -0.7604128 , -5.743445  ,
         3.4242578 ,  4.790099  , -4.03061   , -5.992149  , -1.7297493 ],
       [ 3.4232912 , -4.230874  ,  4.1488533 , -0.29553518, -6.802391  ,
        -2.5163853 , -4.4002395 ,  1.905792  ,  4.7512794 , -0.40538004,
        -4.3401685 ,  1.0361497 ,  0.9744097 ,  0.71507156, -6.2657013 ,
         0.16533905,  4.560262  , -1.3106939 , -3.1121316 , -2.1338716 ],
       [ 3.8508697 , -5.003031  ,  4.8700504 , -0.04324996, -5.893603  ,
        -5.2983093 , -4.004676  ,  4.1236343 ,  6.267754  ,  0.11632943,
        -3.5934832 ,  0.8023905 ,  0.56146765,  0.9192484 , -7.3066816 ,
         2.8202746 ,  6.2000837 , -3.5709393 , -4.564525  , -2.305622  ]],
      dtype=float32)>
```

전체 모델을 빌드 하겠습니다.:

```python
model = tf.keras.Sequential()
model.add(hub_layer)
model.add(tf.keras.layers.Dense(16, activation='relu'))
model.add(tf.keras.layers.Dense(1, activation='sigmoid'))

model.summary()
Model: "sequential"
_________________________________________________________________
Layer (type)                 Output Shape              Param #   
=================================================================
keras_layer (KerasLayer)     (None, 20)                400020    
_________________________________________________________________
dense (Dense)                (None, 16)                336       
_________________________________________________________________
dense_1 (Dense)              (None, 1)                 17        
=================================================================
Total params: 400,373
Trainable params: 400,373
Non-trainable params: 0
_________________________________________________________________
```

레이어는 순차로 쌓음으로서 분류기를 빌드합니다.:

1. 첫번째 레이어는 텐서 플로우 허브 레이어입니다. 이 레이버는 사전 학습된 저장 모델을 사용하며, 문장이 임베딩 벡터로 매핑합니다. 사전 학습딘 텍스트 임베딩 모델은 ([google/tf2-preview/gnews-swivel-20dim/1](https://tfhub.dev/google/tf2-preview/gnews-swivel-20dim/1)) 에서 이용할 수 있으며 문장은 토큰으로 나눕니다. 문장은 토큰으로 나누고, 각 토큰을 임베드 하고, 임베딩과 결합합니다. 결과적으로 차원은 (예제_개수, 임베딩_차원수).
2. 고정된 출력 벡터는 완전 연결(fully-connected) 레이어(`Dense`레이어라고도 함)이며 16개의 은닉 유닛으로 구성됩니다.
3. 마지막 레이어는 densely connected 하며, 단일 출력 노드입니다. 이 노드는 `sigmoid` 활성 함수(activation function)를 이용하며, 이 값은 플롯값이며 0와 1 사이의 값입니다. 확률 값으로 표현하며, 신뢰도 수준을 나타냅니다.

모델을 컴파일 하겠습니다.

### 손실 함수와 옵티마이저

모델은 손실 함수(loss function)와 학습을 위한 옵티마이저(optimizer)가 필요합니다. 바이너리 분류 문제 부터 모델의 출력(시그모이드 활성 함수인 싱글 유닛 레이어)은 확률값입니다., `binary_crossentropy` 손실 함수를 사용하겠습니다.

손실 함수만이 유일한 선택은 아니고, `mean_squared_error`를 선택할 수도 있습니다. 그러나 일반적으로 `binary_crossentropy` 가 확률을 좀더 낫습니다. 이 measure는 확률 분포간의 거리를 측정하고, 우리들의 경우에는 실제 분포(ground truth 분포)와 예측간의 거리를 측정합니다.

나중에 회귀적 문제(예: 집값을 예측하기 위해)에 대해서 알아 볼때, 평균 제곱 오차라고 하는 또 다른 손실 함수에 대해 알아 보겠습니다. 옵티마이저와 손실 함수를 설정해 모델을 구성하겠습니다.

```python
model.compile(optimizer='adam',
              loss='binary_crossentropy',
              metrics=['accuracy'])
```

모델을 학습합니다.

20번의 epochs(세대)를 수행하고 512 샘플을 수행하여 학습합니다. `x_train` and `y_train` 텐서에 대해 20회를 반복해 학습을 진행합니다. 검증셋으로 가져온 1만개 예제를 이용해 학습 하는 동안 모델의 손실(loss)과 정확도(accuracy)를 관찰하겠습니다.

```python
history = model.fit(train_data.shuffle(10000).batch(512),
                    epochs=20,
                    validation_data=validation_data.batch(512),
                    verbose=1)
Epoch 1/20
30/30 [==============================] - 5s 164ms/step - loss: 1.0981 - accuracy: 0.5256 - val_loss: 0.0000e+00 - val_accuracy: 0.0000e+00
Epoch 2/20
30/30 [==============================] - 4s 120ms/step - loss: 0.6794 - accuracy: 0.6119 - val_loss: 0.6480 - val_accuracy: 0.6229
Epoch 3/20
30/30 [==============================] - 4s 120ms/step - loss: 0.6282 - accuracy: 0.6476 - val_loss: 0.6175 - val_accuracy: 0.6597
Epoch 4/20
30/30 [==============================] - 4s 118ms/step - loss: 0.6009 - accuracy: 0.6776 - val_loss: 0.5915 - val_accuracy: 0.6853
Epoch 5/20
30/30 [==============================] - 4s 120ms/step - loss: 0.5692 - accuracy: 0.7059 - val_loss: 0.5619 - val_accuracy: 0.7098
Epoch 6/20
30/30 [==============================] - 4s 120ms/step - loss: 0.5344 - accuracy: 0.7359 - val_loss: 0.5273 - val_accuracy: 0.7387
Epoch 7/20
30/30 [==============================] - 4s 120ms/step - loss: 0.4947 - accuracy: 0.7701 - val_loss: 0.4917 - val_accuracy: 0.7649
Epoch 8/20
30/30 [==============================] - 4s 119ms/step - loss: 0.4540 - accuracy: 0.8007 - val_loss: 0.4592 - val_accuracy: 0.7855
Epoch 9/20
30/30 [==============================] - 4s 118ms/step - loss: 0.4149 - accuracy: 0.8235 - val_loss: 0.4301 - val_accuracy: 0.8038
Epoch 10/20
30/30 [==============================] - 4s 120ms/step - loss: 0.3797 - accuracy: 0.8441 - val_loss: 0.4045 - val_accuracy: 0.8192
Epoch 11/20
30/30 [==============================] - 4s 119ms/step - loss: 0.3505 - accuracy: 0.8627 - val_loss: 0.3815 - val_accuracy: 0.8322
Epoch 12/20
30/30 [==============================] - 4s 118ms/step - loss: 0.3224 - accuracy: 0.8755 - val_loss: 0.3620 - val_accuracy: 0.8423
Epoch 13/20
30/30 [==============================] - 4s 118ms/step - loss: 0.2968 - accuracy: 0.8873 - val_loss: 0.3459 - val_accuracy: 0.8503
Epoch 14/20
30/30 [==============================] - 4s 120ms/step - loss: 0.2717 - accuracy: 0.8997 - val_loss: 0.3343 - val_accuracy: 0.8553
Epoch 15/20
30/30 [==============================] - 4s 120ms/step - loss: 0.2548 - accuracy: 0.9087 - val_loss: 0.3232 - val_accuracy: 0.8615
Epoch 16/20
30/30 [==============================] - 4s 119ms/step - loss: 0.2333 - accuracy: 0.9168 - val_loss: 0.3138 - val_accuracy: 0.8661
Epoch 17/20
30/30 [==============================] - 4s 119ms/step - loss: 0.2169 - accuracy: 0.9227 - val_loss: 0.3076 - val_accuracy: 0.8687
Epoch 18/20
30/30 [==============================] - 4s 120ms/step - loss: 0.2046 - accuracy: 0.9280 - val_loss: 0.3046 - val_accuracy: 0.8700
Epoch 19/20
30/30 [==============================] - 4s 118ms/step - loss: 0.1898 - accuracy: 0.9344 - val_loss: 0.2990 - val_accuracy: 0.8727
Epoch 20/20
30/30 [==============================] - 4s 118ms/step - loss: 0.1804 - accuracy: 0.9403 - val_loss: 0.2963 - val_accuracy: 0.8744
```

### 모델 평가

모델을 실행해 평가를 진행하겠습니다. 평가 결과로 Loss (에러를 나타내는 숫자며, 낮은 값이 좋음)와 accuracy가 반환됩니다.

```python
results = model.evaluate(test_data.batch(512), verbose=2)

for name, value in zip(model.metrics_names, results):
  print("%s: %.3f" % (name, value))
49/49 - 3s - loss: 0.3156 - accuracy: 0.8649
loss: 0.316
accuracy: 0.865
```

꽤 나이브한 접근 방식이며 87%의 정확도를 달성했습니다. 진보된 모델은 95%에 가까운 성능을 얻을 수 있습니다.

### 더읽어보기

문자열 입력과 관련한 일반적인 방식이나 학습 과정의 loss에 대한 분석 과정을 확인 하려면 [여기](https://www.tensorflow.org/tutorials/keras/basic_text_classification)를 선택바랍니다.