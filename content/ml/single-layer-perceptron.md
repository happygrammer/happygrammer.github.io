---
title: "Single Layer Perceptron"
date: 2021-05-27T08:06:04+03:00
draft: true
---

입력 벡터는 두 분류로 분류하기 위한 선형 분류기이다. 이때 단층 퍼센트론을 다음과 같은 형태로 학습한다.

```
w = [-0.5, 0, 0.5]    # -0.5 ~ 0.5 사이값으로 초기화
train = [ [0, 0, 0], [0, 1, 0], [1, 0, 0], [1, 1, 1] ] # N개의 AND 학습 데이터 초기화

size_input = len(train)                            # 학습 예제 개수
for i to size_input:                               # bias 초깃값 초기화
    x_bias[i] = -1
    
th = 0       # threshold 초기화
lr = 0.05    # learning rate 초기화

for n to size_input:
    x = train[n]                                # n번째 학습 예제 읽기
    size_vec = len(x)-1                         # n번째 학습 예제 벡터 사이즈
    bv = x_bias[n]                              # n번째 학습 예제 bias 값
    for i to size_vec:                          # n번째 학습 예제 weight 조정 여부 판단
        net = w[i]*x[i] + w[0]*bv               # net값 계산
        if net >= th:                           # net값이 threshold 이상인 경우 weight 업데이트
            t = x[-1]                           # target value
            w[i] = w[i] + (lr * x[i] * (t-net)) # weight 업데이트
```

