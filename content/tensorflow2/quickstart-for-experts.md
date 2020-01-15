---
title: "전문가용 텐서플로우 2 튜토리얼"
date: 2020-01-15T06:32:43+03:00
draft: false
---

텐서플로우 튜토리얼(https://www.tensorflow.org/tutorials/quickstart/advanced) 한국어 번역 문서입니다.

### 전문가용 텐서플로우 2 튜토리얼

[Google Colaboratory](https://colab.research.google.com/notebooks/welcome.ipynb)에 노트북 파일이 있습니다. 이 사이트는 파이썬 노트북 파이을 브라우저에서 바로 실행해 볼 수 있어 텐서플로우를 이해하는데 도움을 줍니다. 튜토리얼을 진행해 보겠습니다.

1. Colab에서 파이썬 런타임에 접속합니다. 메뉴바의 오른쪽에 위치한 `CONNECT`을 선택합니다.
2. 메뉴에서 `Runtime > Run all`을 선택합니다.

### 텐서플로우 패키지 설치와 임포트

텐서플로우 2 패키지를 다운로드 받고 설치를 진행하고, 텐서플로우를 프로그램으로 임포트합니다.

```
from __future__ import absolute_import, division, print_function, unicode_literals

import tensorflow as tf

from tensorflow.keras.layers import Dense, Flatten, Conv2D
from tensorflow.keras import Model
```

### 데이터 준비

[MNIST dataset ](http://yann.lecun.com/exdb/mnist/)로드하고 예제를 준비합니다.

```
mnist = tf.keras.datasets.mnist

(x_train, y_train), (x_test, y_test) = mnist.load_data()
x_train, x_test = x_train / 255.0, x_test / 255.0

# Add a channels dimension
x_train = x_train[..., tf.newaxis]
x_test = x_test[..., tf.newaxis]
Downloading data from https://storage.googleapis.com/tensorflow/tf-keras-datasets/mnist.npz
11493376/11490434 [==============================] - 0s 0us/step
```

[`tf.data`](https://www.tensorflow.org/api_docs/python/tf/data) 를 사용해 하이퍼파라메터를 설정합니다. 셔플(shuffle) 횟수와 배치 사이즈(batch size)를 설정합니다.

- 역자주 : `하이퍼파라메터` 는 학습에 필요한 파라메터 값입니다.
- 역자주 : `배치 사이즈`는 한번의 학습에 사용하는 `데이터 개수`입니다.

```
train_ds = tf.data.Dataset.from_tensor_slices(
    (x_train, y_train)).shuffle(10000).batch(32)

test_ds = tf.data.Dataset.from_tensor_slices((x_test, y_test)).batch(32)
```

### 모델 빌드

[`tf.keras`](https://www.tensorflow.org/api_docs/python/tf/keras) 모델을 빌드합니다. 이때 케라스 모델 서브클래싱 API([model subclassing API](https://www.tensorflow.org/guide/keras#model_subclassing))를 사용합니다.

```
class MyModel(Model):
  def __init__(self):
    super(MyModel, self).__init__()
    self.conv1 = Conv2D(32, 3, activation='relu')
    self.flatten = Flatten()
    self.d1 = Dense(128, activation='relu')
    self.d2 = Dense(10, activation='softmax')

  def call(self, x):
    x = self.conv1(x)
    x = self.flatten(x)
    x = self.d1(x)
    return self.d2(x)

# Create an instance of the model
model = MyModel()
```

최적화 함수를 선택합니다.

```
loss_object = tf.keras.losses.SparseCategoricalCrossentropy()

optimizer = tf.keras.optimizers.Adam()
```

loss 와 모델의 accuracy를 측정 되도록 측정이 epochs가 반복될 수 있도록 누적될 수 있게하고 전체적인 결과를 출려할 수 있게 설정합니다.

```
train_loss = tf.keras.metrics.Mean(name='train_loss')
train_accuracy = tf.keras.metrics.SparseCategoricalAccuracy(name='train_accuracy')

test_loss = tf.keras.metrics.Mean(name='test_loss')
test_accuracy = tf.keras.metrics.SparseCategoricalAccuracy(name='test_accuracy')
```

### 모델 학습과 평가

모델 학습을 위해 [`tf.GradientTape`](https://www.tensorflow.org/api_docs/python/tf/GradientTape)를 사용합니다.

```
@tf.function
def train_step(images, labels):
  with tf.GradientTape() as tape:
    predictions = model(images)
    loss = loss_object(labels, predictions)
  gradients = tape.gradient(loss, model.trainable_variables)
  optimizer.apply_gradients(zip(gradients, model.trainable_variables))

  train_loss(loss)
  train_accuracy(labels, predictions)
```

모델을 테스트 합니다.

```
@tf.function
def test_step(images, labels):
  predictions = model(images)
  t_loss = loss_object(labels, predictions)

  test_loss(t_loss)
  test_accuracy(labels, predictions)
EPOCHS = 5

for epoch in range(EPOCHS):
  # Reset the metrics at the start of the next epoch
  train_loss.reset_states()
  train_accuracy.reset_states()
  test_loss.reset_states()
  test_accuracy.reset_states()

  for images, labels in train_ds:
    train_step(images, labels)

  for test_images, test_labels in test_ds:
    test_step(test_images, test_labels)

  template = 'Epoch {}, Loss: {}, Accuracy: {}, Test Loss: {}, Test Accuracy: {}'
  print(template.format(epoch+1,
                        train_loss.result(),
                        train_accuracy.result()*100,
                        test_loss.result(),
                        test_accuracy.result()*100))
```