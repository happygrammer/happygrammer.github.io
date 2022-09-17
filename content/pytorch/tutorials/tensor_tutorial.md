---
title: "PYTORCH 소개"
date: 2020-01-16T22:09:54+03:00
draft: false
---

파이썬 기반의 과학 컴퓨팅 패키지이로 두가지 특징이 있습니다.

- GPU 파워를 사용해 `Numpy`를 대체 합니다.
- 딥러닝 연구 플랫폼이며 유연함과 속도를 제공합니다.



### 텐서

텐서는 NummPy’s ndarrays와 비슷합니다. GPU를 사용해 계산을 가속화할 수 있게 하였습니다.

```
from __future__ import print_function
import torch
```

NOTE

초기화 하지 않은 매트릭스를 선언했고, 사용 되기 전에 알려지지 않은 값을 포함합니다. 초기화 되지 않은 매트릭가 생성되면,  초기화 값된 메트리스가 메모리에 할당됩니다.



#### 빈텐서 생성

[empty](https://pytorch.org/docs/stable/torch.html#torch.empty) 메서드를 이용해 5x3 매트릭스를 구축합니다. 초기화 되어 있지 않습니다.:

```
x = torch.empty(5, 3)
print(x)
```

출력:

```
tensor([[0., 0., 0.],
        [0., 0., 0.],
        [0., 0., 0.],
        [0., 0., 0.],
        [0., 0., 0.]])
```



#### rand 메서드

[rand 메서드](https://pytorch.org/docs/stable/torch.html#torch.rand)를 이용해 랜덤값으로 초기화된 매트릭스 x를 구축합니다:

```
x = torch.rand(5, 3)
print(x)
```

출력:

```
tensor([[0.9298, 0.9713, 0.3894],
        [0.2156, 0.1115, 0.8487],
        [0.3558, 0.0675, 0.3990],
        [0.3137, 0.1254, 0.8180],
        [0.9860, 0.7645, 0.5177]])
```

0으로 채워진 매트릭스를 구축합니다. [dtype(Data Type)](https://pytorch.org/docs/stable/tensor_attributes.html#torch.torch.dtype)은 long입니다.:

- 역자 주 : dtype은 크게 숫자형과 문자형으로 나뉩니다.
  - 숫자형은 bool 자료형(booleans, bool), 정수형 (integers, int), 부호 없는 정수형 (unsigned integers , uint), 부동소수형 (floating point, float), 복소수형 (complex)가 있습니다.
  - 문자형은 string뿐입니다.

```
x = torch.zeros(5, 3, dtype=torch.long)
print(x)
```

출력:

```
tensor([[0, 0, 0],
        [0, 0, 0],
        [0, 0, 0],
        [0, 0, 0],
        [0, 0, 0]])
```

데이터로 부터 직접 텐서를 구축합니다.

```
x = torch.tensor([5.5, 3])
print(x)
```

출력:

```
tensor([5.5000, 3.0000])
```

또는 기존 텐서를 기초로 텐서를 생성합니다. 이들 메서드는 입력 텐서의 프로퍼티를 다시 사용할 수 있습니다. 예. dtype, 사용자에게 받은 새 값을 이용하지 않는 경우.

```
x = x.new_ones(5, 3, dtype=torch.double)      # new_* methods take in sizes
print(x)

x = torch.randn_like(x, dtype=torch.float)    # override dtype!
print(x)                                      # result has the same size
```

출력:

```
tensor([[1., 1., 1.],
        [1., 1., 1.],
        [1., 1., 1.],
        [1., 1., 1.],
        [1., 1., 1.]], dtype=torch.float64)
tensor([[ 2.0873,  0.5724,  3.2169],
        [ 1.3758, -0.1102,  0.8472],
        [-0.1259, -0.8689, -2.2761],
        [-1.5009, -1.1049, -0.4815],
        [ 0.8847, -1.1887,  1.3296]])
```

사이즈 얻기:

```
print(x.size())
```

출력:

```
torch.Size([5, 3])
```

주의

`torch.Size` 는 튜플입니다. 그래서 모든 튜플 연산자를 지원합니다.



### Operations

[연산자](https://pytorch.org/docs/master/torch.html)를 위한 여러 구문이 있습니다. 다음 예제에서 더하기 연산을 살펴 보겠습니다.

#### 더하기 연산 문법

```
y = torch.rand(5, 3)
print(x + y)
```

출력:

```
tensor([[ 2.2760,  0.8943,  3.6728],
        [ 1.4825,  0.1061,  1.6137],
        [ 0.4420, -0.8375, -1.5139],
        [-0.8007, -0.8512, -0.1808],
        [ 0.9704, -0.9864,  2.2123]])
```

#### 더하기 연산 문법2

```
print(torch.add(x, y))
```

출력:

```
tensor([[ 2.2760,  0.8943,  3.6728],
        [ 1.4825,  0.1061,  1.6137],
        [ 0.4420, -0.8375, -1.5139],
        [-0.8007, -0.8512, -0.1808],
        [ 0.9704, -0.9864,  2.2123]])
```

#### 인자로 출력 텐서를 전달

인자로 출력 텐서를 전달할 수 있습니다.

```
result = torch.empty(5, 3)
torch.add(x, y, out=result)
print(result)
```

출력:

```
tensor([[ 2.2760,  0.8943,  3.6728],
        [ 1.4825,  0.1061,  1.6137],
        [ 0.4420, -0.8375, -1.5139],
        [-0.8007, -0.8512, -0.1808],
        [ 0.9704, -0.9864,  2.2123]])
```

#### In-place 연산자

In-place 연산자로, 모든 연산자 마지막에는 '_'가 붙습니다. 

```
# adds x to y
y.add_(x)
print(y)
```

출력:

```
tensor([[ 2.2760,  0.8943,  3.6728],
        [ 1.4825,  0.1061,  1.6137],
        [ 0.4420, -0.8375, -1.5139],
        [-0.8007, -0.8512, -0.1808],
        [ 0.9704, -0.9864,  2.2123]])
```

NOTE

모든 연산자는 연산자명 마지막에 '__'가 붙습니다. 예) x.copy_(y)`, `x.t_() 여러분은 표준 NumPy를 이용 할 수 있습니다.

```
print(x[:, 1])
```

출력:

```
tensor([ 0.5724, -0.1102, -0.8689, -1.1049, -1.1887])
```

#### torch.view로 resize

리사이징:  텐서를 resize/reshape 하려면 ,  `torch.view`를 이용합니다.

```
x = torch.randn(4, 4)
y = x.view(16)
z = x.view(-1, 8)  # -1이라고 입력하면 8차원인 행이 몇개가 필요한지를 자동으로 계산한다. 자동으로 계산해 2가됨
print(x.size(), y.size(), z.size())
```

출력:

```
torch.Size([4, 4]) torch.Size([16]) torch.Size([2, 8])
```

하나의 텐서 요소를 가진다면,  `.item()` 를 사용해 Python 숫자 값을 얻습니다. 예를 들어 loss 값을 추출할 때 .item()를 사용할 수 있습니다.

```
x = torch.randn(1)
print(x)
print(x.item())
```

출력:

```
tensor([-0.3354])
-0.33543476462364197
```

**나중에 읽기:**

100개 이상의 텐서 연산자가 있습니다. transposing, indexing, slicing, mathematical operations, linear algebra, random numbers 등을 포함합니다. [문서](https://pytorch.org/docs/torch).



### NumPy 브릿지

Torch Tensor을 NumPy 배열로 변경이 가능합니다. 

Torch Tensor 와 NumPy 배열은 기본 메모리 위치를 공유해(Torch 텐서가 CPU에 처리된다면), 하나를 변경하면 다른 것도 변경이 됩니다.



#### Torch 텐서 to NumPy 배열로 변환

```
a = torch.ones(5)
print(a)
```

출력:

```
tensor([1., 1., 1., 1., 1.])
```

이때 numpy()라는 메서드를 호출하면 즉시 텐서에서 Numpy 배열로 변환 된다는 것을 확인할 수 있습니다.

```
b = a.numpy()
print(b)
```

출력:

```
[1. 1. 1. 1. 1.]
```

어떻게 numpy 배열의 값이 변경되었는지 확인하겠습니다.

```
a.add_(1)
print(a)
print(b)
```

출력:

```
tensor([2., 2., 2., 2., 2.])
[2. 2. 2. 2. 2.]
```



#### NumPy 배열을 Torch 텐서로 변환

Torch Tensor가 np 배열을 자동으로 변경할 때 `from_numpy`를 이용합니다.

```
import numpy as np
a = np.ones(5)
b = torch.from_numpy(a)
np.add(a, 1, out=a)
print(a)
print(b)
```

출력:

```
[2. 2. 2. 2. 2.]
tensor([2., 2., 2., 2., 2.], dtype=torch.float64)
```

CPU위에서 동작하는 텐서는  [CharTensor](https://pytorch.org/docs/stable/tensors.html)를 제외합니다. CharTensor는 Numpy로 변경하는 역할을합니다.



### CUDA 텐서

#### .to 메서드

텐서는 .to 메서드를 사용해 어떤 장치로도 이동될 수 있습니다.

```
# let us run this cell only if CUDA is available
# We will use ``torch.device`` objects to move tensors in and out of GPU
if torch.cuda.is_available():
    device = torch.device("cuda")          # a CUDA device object
    y = torch.ones_like(x, device=device)  # directly create a tensor on GPU
    x = x.to(device)                       # or just use strings ``.to("cuda")``
    z = x + y
    print(z)
    print(z.to("cpu", torch.double))       # ``.to`` can also change dtype together!
```

출력:

```
tensor([0.6646], device='cuda:0')
tensor([0.6646], dtype=torch.float64)
```

**Total running time of the script:** ( 0 minutes 6.798 seconds)

