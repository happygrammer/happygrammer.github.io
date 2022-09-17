---
title: "텐서플로우 2 입문자용 튜토리얼"
date: 2020-01-15T06:29:13+03:00
draft: false
---

텐서플로우 튜토리얼(https://www.tensorflow.org/tutorials/quickstart/beginner) 한국어 번역 문서입니다.

### 텐서플로우 2 입문 튜토리얼

- [Google Colab에서 실행](https://colab.research.google.com/github/tensorflow/docs/blob/master/site/en/tutorials/quickstart/beginner.ipynb)
- [GitHub 소스 보기](https://github.com/tensorflow/docs/blob/master/site/en/tutorials/quickstart/beginner.ipynb)
- [노트북 다운로드](https://storage.googleapis.com/tensorflow_docs/docs/site/en/tutorials/quickstart/beginner.ipynb)

### [케라스](https://www.tensorflow.org/guide/keras/overview)를 사용한 짧은 소개

1. 이미지를 분류하는 뉴럴 네트워크(neural network)를 빌드합니다.
2. 빌드된 뉴럴 네트워크를 이용해 학습(Train)을 진행합니다.
3. 마지막으로, 모델의 정확도(accuracy)를 평가합니다.

[Google Colaboratory](https://colab.research.google.com/notebooks/welcome.ipynb)에 노트북 파일이 있습니다. 이 사이트는 파이썬 노트북 파이을 브라우저에서 바로 실행해 볼 수 있어 텐서플로우를 이해하는데 도움을 줍니다. 튜토리얼을 진행해 보겠습니다.

1. Colab에서 파이썬 런타임에 접속합니다. 메뉴바의 오른쪽에 위치한 `CONNECT`을 선택합니다.
2. 메뉴에서 `Runtime > Run all`을 선택합니다.

### 텐서플로우 패키지 설치와 임포트

텐서플로우 2 패키지를 다운로드 받고 설치를 진행하고, 텐서플로우를 프로그램으로 임포트합니다.

```
from __future__ import absolute_import, division, print_function, unicode_literals

# Install TensorFlow

import tensorflow as tf
```

### 데이터 준비

[MNIST dataset ](http://yann.lecun.com/exdb/mnist/)로드하고 정수형(integers)을 실수형 포인트 숫자(floating-point numbers)로 변환한 예제를 준비합니다.

```
mnist = tf.keras.datasets.mnist

(x_train, y_train), (x_test, y_test) = mnist.load_data()
x_train, x_test = x_train / 255.0, x_test / 255.0
```

### 모델 빌드

레이어를 쌓음으로서 [`tf.keras.Sequential`](https://www.tensorflow.org/api_docs/python/tf/keras/Sequential) 모델을 빌드합니다. 옵티마이저와 손실 함수(loss function)을 선택합니다.

```
model = tf.keras.models.Sequential([
  tf.keras.layers.Flatten(input_shape=(28, 28)),
  tf.keras.layers.Dense(128, activation='relu'),
  tf.keras.layers.Dropout(0.2),
  tf.keras.layers.Dense(10, activation='softmax')
])

model.compile(optimizer='adam',
              loss='sparse_categorical_crossentropy',
              metrics=['accuracy'])
```

### 모델 학습과 평가

모델 학습과 평가를 진행합니다.

```
model.fit(x_train, y_train, epochs=5)

model.evaluate(x_test,  y_test, verbose=2)
Train on 60000 samples
Epoch 1/5
60000/60000 [==============================] - 5s 89us/sample - loss: 0.2990 - accuracy: 0.9134
Epoch 2/5
60000/60000 [==============================] - 4s 66us/sample - loss: 0.1419 - accuracy: 0.9582
Epoch 3/5
60000/60000 [==============================] - 4s 66us/sample - loss: 0.1074 - accuracy: 0.9677
Epoch 4/5
60000/60000 [==============================] - 4s 67us/sample - loss: 0.0883 - accuracy: 0.9729
Epoch 5/5
60000/60000 [==============================] - 4s 67us/sample - loss: 0.0746 - accuracy: 0.9771
10000/1 - 1s - loss: 0.0392 - accuracy: 0.9781

[0.07525769539596514, 0.9781]
```

이미지 분류기(image classifier)는 98% 정확도 까지 학습되었습니다. 보다 자세한 내용은 [텐서플로우 튜토리얼](https://www.tensorflow.org/tutorials/)에서 확인 할 수 있습니다.