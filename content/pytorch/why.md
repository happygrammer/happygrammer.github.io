---
title: "파이토치를 사용하는 이유"
date: 2022-01-22T08:40:47+09:00
draft: true
---

- Theano, Tensorflow를 케라스가 래핑함



구글에서 만든 'Tensorflow'가 나왔다. 페이스북과 엔비디와 같은 회사가 'Pytorch'를 만들게 되었다.



Pytorch 장점

- Tensorflow 보다 대세
- Numpy하고 비슷한 문법
- 문서화가 좋음
- 난이도는 쉽지만 자유도는 Tensorflow를 포함한다.

기존의 장점을 벤치마킹해서 나왔기에 Tensorflow의 TPU나 텐서보드도 이용할수 있다.

- 구글 TPU 지원도 가능해짐.
- TF보다 많은 소스 코드
- 텐서보드 존재

단점으로는, TF에 비해 낮은 상용화 지원이 있지만, 조만간 극복할 수 있을 것이라 기대됨.

- NIPS, CVPR과 같은 VISION 학회에서 Pytorch 사용율 증가중



### Pytorch 설치

conda 명령어를 이용해서 pytorch 명령어를 이용한다. GPU를 이용하는 경우는 cuda설치 이후 진행이 피요하다. ipython

```
import torch
torch.__version__
```

위 명령어를 이용해 확인할 수 있다. Pytorch

```
impoty torch
a = torch.FloatTensorf([[1,2],[3, 4]])
b = torch.FloatTensorf([[1,2],[3, 4]])
c = torch.matmul(a, b)
print(c)
```



### 학습

가상의 함수(ground-truth)를 통해 데이터셋을 만들고 우리의 함수(예:신경망)은 데이터로 부터 학습해(모방한) 가상의 함수를 만들게 된다. 예를 들어 Tabular Dataset을 보도록 하자. 입력에 대해서 n차원 백터의 n개의 데이터를 학습해 f 함수를 만들고, 입력에대해서 m차원의 벡터를 출력할 수 있게 된다.



### Tensor

가장 많이 사용하는 Tensorflow Float 텐서를 사용한다.

```
import torch
ft = torch.FloatTensor([[1,2],[3, 4]])
```

자료형에 따라 LongTensor, ByteTensor 등이 있다. 사이즈만 정해서 처리하는 방식도 존재한다.

```
x = torch.FloatTensor(5, 2)
```



### Numpy와 Torch간의 호환

```
x = torch.from_numpy(x)
```



### Tensor Type 캐스팅



### Shape

```
print(x.size())
```



### Inplace Operation

mul_ 스코어를 붙여서 만든다. a와 b를 곱하서 a값 자체를 바꿔버린다. 속도 이점은 있으나, 메모리 할당 절약 용으로 사용

```
print(a.mul_(b))
```



### Sum, Mean

그외 Dimension Reducing 연산자로 Sum, Mean이 있다.

```
x.sum() // 모두 더한 scalar 값
x.mean() // 평균 scalar 값
```



### Broadcasting

똑갈은 모양의 tensor들을 연산하였지만, Broadcast라는 기능을 통해, 다른 모양 텐서라고 해도 연산이 가능하도록 한다.

