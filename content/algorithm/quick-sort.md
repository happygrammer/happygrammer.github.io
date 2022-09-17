---
title: "Quick Sort"
date: 2021-10-02T08:08:08+03:00
draft: true
---

알고리즘 설계 관점에서 작은 문제들을 해결하여 큰 문제를 해결하는 관점과 유사하다. 알고리즘 관련해서 가장 널리 알려진 퀵소트 알고리즘를 살펴보자. 퀵소트 알고리즘은 분할 정복(divide and conquer) 방식으로 문제를 해결하고 있다.

```
algorithm quicksort(A, lo, hi) is
    if lo < hi then
        p := pivot(A, lo, hi) // 기준원소 선택을 위한 피봇 인덱스를 정함.
        left, right := partition(A, p, lo, hi)  // 피봇 인덱스 기준으로 왼쪽, 오른쪽 배열로 분할한다
        quicksort(A, lo, left - 1) // 왼쪽 부분 배열을 정렬한다
        quicksort(A, right + 1, hi) // 오른쪽 부분 배열을 정렬한다.
```

위 알고리즘을 c언어 기반으로 적으면

```
void quicksort(int arr[], int low, int high) 
{ 
    if (low < high) 
    { 
        int pi = partition(arr, low, high); 
        quicksort(arr, low, pi - 1); 
        quicksort(arr, pi + 1, high); 
    } 
}

// Driver Code
int main() 
{ 
    int arr[] = {10, 7, 8, 9, 1, 5}; 
    int n = sizeof(arr) / sizeof(arr[0]); 
    quicksort(arr, 0, n - 1);
    return 0; 
}
```

정렬이라는 큰 문제를 해결 하기 위해 자기 자신을 호출을 해 작은 단위로 문제를 나누는 방식으로 문제를 해결하고 있다. 예를 들어 기준 원소가 5인 경우, 정리할 숫자들을 기준 원소 5를 기준으로 좌 우측으로 재배치한다.

- 4,3,[5],2,1,6,7,9,8,10 // 기준 원소를 5로 정합(아무거나 골라도됨)
- 1,2,4,3,[5],6,7,9,8,10 // 기준 원소 5를 기준으로 좌우측 배열을 재배치
- ..

병합적렬은 재귀적으로 작은 문제를 해결하고 다음 후처리를 진행하지만, 퀵 정렬은 선행 작업을하고 재귀적으로 작은 문제를 한다.
