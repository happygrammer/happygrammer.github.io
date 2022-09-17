---
title: "Precision과 Recall의 이해"
date: 2022-04-10T20:02:08+09:00
draft: true
---

### 적합 문서

검색엔진의 성능은 `적합 문서`(relevant document)를 잘 찾는 능력이다. 적합 문서를 잘 찾으려면 적합성을 고려해야 한다. 적항성은 사용자 적합성과 주제 적합성을 고려한다. 사용자 적합성은 사용자에게 맞는 적합한 문서를 찾았는지에 대한 것이다. 예를 들어 질의에 맞는 문서를 찾았지만, 사용자에게 올바른 답변을 줄 수 없는 문서라면 사용자 적합성이 없다고 본다. 주제 적합성은 사용자 질의에 맞는 적합한 문서를 찾았는지에 대한 것이다. 단순 `grep`과 같은 키워드 일치 만으로 문서를 찾았다면 관련 문서는 찾았지만, 사용자 주제에 맞지 않는 문서가 검색될 수 있다.

### 평가

적합 문서를 얼마 잘 찾을 수 있는지를 객관적으로 측정하기 위해 `평가(evaluation)`를 고려한다. 검색 엔진은 이진 분류(binary classification) 관점에서 평가를 한다. 평가의 측도 정밀도(precision)와 재현율(recall)을 이용한다. 정밀도는 검색된 문서 중에 실재 적합 문서의 비율을 의미한다.

$$
precision=\frac{actual값이 TRUE인 개수}{predicted값이 TRUE인 개수}
$$

정밀도는 검색된 문서 중에 실재 적합한 문서의 비율을 찾는다. 재현율은 전체 적합 문서 중에 검색된 문서 중에 적합 문서의 비율을 의미한다. 재현율을 계산할 수 있다는 것은 모든 적합 문서의 개수가 몇 개인지를 안다는 것을 의미한다. 다른 관점에서 재현율을 계산하려면 적합 문서 개수와 적합 문서의 대상을 모두 알 수 있어야 하므로, 소규모 컬렉션에 대해 사용될 수 있다.

$$
recall=\frac{predicted값이 TRUE인 개수}{actual값이 TRUE인 개수}
$$

웹 검색엔진에 대해서 수십억 이상의 문서들에 대해서 적합 문서를 모두 알 수 없기 때문에 보통 [TREC](https://trec.nist.gov/data.html)과 같은 평가셋을 이용한다.



### confusion matrix

통계적 분류 관점에서 정밀도과 재현율을 정의하기 위해 먼저 confusion matrix를 정의한다.

|            |              | PREDICTION         | PREDICTION         |
| ---------- | ------------ | ------------------ | ------------------ |
|            |              | TRUE(class)        | FALSE(class)       |
| **ACTUAL** | TRUE(class)  | a (True Positive)  | b (False Negative) |
| **ACTUAL** | FALSE(class) | c (False Positive) | d (True Negative)  |

precision은 모델의 출력이 TRUE라고 판정한 결과 중에 실재 결과도 TRUE라고 판정한 예제의 비율이다.

$$
precision=\frac{a}{a + c}
$$

recall은 실재 TRUE라고 판정한 결과 중에서 모델의 출력이 TRUE라고 판정한 예제의 비율이다.

$$
recall=\frac{a}{a + b}
$$

정밀도(precision)가 높다는 것은 모델의 정확도가 높아진다고 볼 수 있다. 재현율(recall)이 높다는 것은 모델의 정답 커버리지가 높다고 볼 수 있다.정확률(accuracy)은 다음과 같다.


$$
accuracy=\frac{a + d}{a + b + c + d}
$$
