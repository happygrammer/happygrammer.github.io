---
title: "결합 확률 분포"
date: 2020-02-05T01:33:53+03:00
draft: false
---

랜덤 변수 $X, Y, ...,$ 는 확률 공간(probaility space)에 정의됩니다. 여기서 $X, Y$ 는 확률 분포(probability distribution)을 의미합니다.  이들 확률 분포 $X, Y$에 속한 값은 이산 집합 내에 속하거나 특정 범위 내에 속합니다. 이때 두 랜덤 변수 $X, Y$는 이변수 분포(bivariate distribution)입니다.

결합 확률 분포(joint probability distribution)는 결합 누적 분포 함수(joint [cumulative distribution function](https://en.wikipedia.org/wiki/Cumulative_distribution_function)) 또는 결합 확률 밀도 함수(joint [probability density function](https://en.wikipedia.org/wiki/Probability_density_function) )라고 부르기도 합니다. 결합 화률 분포는 두 분포를 찾는데 사용됩니다.

- 주변 분포(marginal distribution)
- 조건 확률 분포(conditional probability distribution)

결합 확률 분포의 예로 **이항 분포**와 이항 분포의 특수 케이스인 **베르누이 분포**가 있습니다.

### 이항 분포

이항 분포(Binomial distribution)는 $n$과 $p$를 사용합니다. 여기서 n은 시행 횟수 이며, 각 시행 횟수는 독립(independent experiments)입니다. 이때 n=1일때의 성공과 실패를 결과로 얻는 시행은 베르누이 시행(Bernoulli trial)이라 하며 베르누이 시행은 베르누이 분포(bernoulli distrubtion)을 따릅니다.

### 베르누이 시도와 베르누이 분포

동전을 던지면 앞면이 나올 수 있고 뒷면이 나올 수 있습니다.  동전이 앞면이면 랜덤 변수는 1이고, 뒷면이면 0입니다. 앞면(head0이든 뒷면(tail)이든 나올 확률은 1/2입니다. 여기서 앞면을 확률변수 A, 뒷면을 확률 변수 B라고 하겠습니다. 동전 던지기와 같은 베르누이 실행은 베르누이 분포를 따르므로 "어떤 확률분포 $X$가 베르누이 분포를 따른 다"고 할 수 있으며 수식으로 다음과 같이 표기합니다.


$$
X \sim \text{Bern}(x;\theta)
$$

베르 누이는 1이 나올 확률을 의미하는 $θ$ 모수(prameter)만 사용합니다. 베르누이 확률 변수 $x$가 1이 나올 확률은  $θ$이며 확률 변수 $x$가가 0이 나올 확률은 $θ-1$입니다. 이때 베르누이 확률 질량 함수(pmf: probaility mass function)은 다음과 같이 정의합니다.

$$
\text{Bern}(x;\theta) =  \begin{cases}  \theta   & \text{if }x=1, \\ 1-\theta & \text{if }x=0 \end{cases}
$$

주변 확률 밀도 함수(marginal probability distribution)는 다음과 같습니다.

$$P(A)=1/2 \quad \text{for} \quad A\in \{0, 1\};$$
$$P(B)=1/2 \quad \text{for} \quad B\in \{0, 1\}.$$

동전 던지기 실험 결과에 대한 결합 확률 밀도 함수 A와 B는 다음과 같습니다.

$$
(A=0,B=0),
(A=0,B=1),
(A=1,B=0),
(A=1,B=1).
$$

각 실험 결과는 결합 확률 밀도 함수는 다음과 같습니다.

$$P(A,B)=1/4 \quad \text{for} \quad A,B\in\{0,1\}.$$

따라서 각 동전 던지는 독립 조건이며, 결합 확률 밀도 함수는 주변 확률의 곱(product of the marginals)입니다.

$$P(A,B)=P(A)P(B) \quad \text{for} \quad A,B \in\{0,1\}.$$

결합을 표시하기 위해 쉼표를 이용합니다.
