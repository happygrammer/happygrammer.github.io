---
title: "못난 코드 알아보기"
date: 2022-09-08T13:33:15+09:00
draft: false
---

훌륭한 코드를 작성하고 싶다면 코드를 잘 쓰려고 노력하는데 그치지 말고 잘못 작성된 코드를 알아보는 감각을 키우는 노력이 필요하다. 바이올린과 같은 현악기는 연주자가 줄을 팅겨 보면서 음높이를 조절한다. 음높이를 조절할때는 음감을 이용하여 조율한다. 악보를 외우고 숙달하면 숙달된 바이올리니스트의 시늉을 하면서 한두 곡 정도는 연주가 가능할 수 있지만 모든 연주를 그렇게 할수는 없다. 올바른 코드를 작성하려면 잘못 작성된 코드를 먼저 알아보는 감각이 필요하다.

어떻게 하면 못난 코드를 *알아볼까?* 쉽고 간단한 방법이 있다.  `셀프 코드 리뷰`를 진행해 보는 것이다. 실재 코드 리뷰를 진행 하듯이 코드의 주석과 코드의 내용을 한 줄 한줄 소리내어 읽어 보면서 의도를 이해할 수 있는지를 체크 한다. 의미를 바로바로 이해할 수 없다면 못난 *코드이다.* 못난 코드라도 코드의 의도가 분명해지도록 리팩토링을 하면 훌륭한 코드가 될 수 있다. 어느 누가 작성한 코드이든 이 기준을 적용할 수 있다. 유명한 개발자가 작성한 코드라 할지라도 주눅들 필요 없이 위 기준을 적용하면 된다. 다음은 JUnit 프레임워크의 [Assert 클래스](https://github.com/junit-team/junit4/blob/main/src/main/java/org/junit/Assert.java) 코드이다.

```
package org.junit;

import org.hamcrest.Matcher;
import org.hamcrest.MatcherAssert;
import org.junit.function.ThrowingRunnable;
import org.junit.internal.ArrayComparisonFailure;
import org.junit.internal.ExactComparisonCriteria;
import org.junit.internal.InexactComparisonCriteria;

/**
 * A set of assertion methods useful for writing tests. Only failed assertions
 * are recorded. These methods can be used directly:
 * <code>Assert.assertEquals(...)</code>, however, they read better if they
 * are referenced through static import:
 *
 * <pre>
 * import static org.junit.Assert.*;
 *    ...
 *    assertEquals(...);
 * </pre>
 *
 * @see AssertionError
 * @since 4.0
 */
public class Assert {
    /**
     * Protect constructor since it is a static only class
     */
    protected Assert() {
    }

    /**
     * Asserts that a condition is true. If it isn't it throws an
     * {@link AssertionError} with the given message.
     *
     * @param message the identifying message for the {@link AssertionError} (<code>null</code>
     * okay)
     * @param condition condition to be checked
     */
    public static void assertTrue(String message, boolean condition) {
        if (!condition) {
            fail(message);
        }
    }

    /**
     * Asserts that a condition is true. If it isn't it throws an
     * {@link AssertionError} without a message.
     *
     * @param condition condition to be checked
     */
    public static void assertTrue(boolean condition) {
        assertTrue(null, condition);
    }

    /**
     * Asserts that a condition is false. If it isn't it throws an
     * {@link AssertionError} with the given message.
     *
     * @param message the identifying message for the {@link AssertionError} (<code>null</code>
     * okay)
     * @param condition condition to be checked
     */
    public static void assertFalse(String message, boolean condition) {
        assertTrue(message, !condition);
    }
    ...
}
    
```

위 코드의 주석과 내용을 *소리 내어* 읽어보고 설명해 보자. 눈으로 읽었을 때 의미가 금방 들어오지 않았지만 소리 내어 *읽었을 때* 내용과 흐름을 좀더 쉽게 알 수 있게 되었다. 이 코드는 많은 사용자층을 보유하고 있는 Junit 프로젝트의 핵심 메소드 중 하나이다. 많은 사용자들이 Junit의 기능을 직관적으로 사용할 수 있으려면 기능 제공을 넘어 기능을 쉽게 파악할 수 있게 해야한다. 위 코드는 읽기 편하고 내용을 쉽게 파악할 수 있어 좋은 코드이다. `셀프 코드 리뷰`라는 과정을 통해 못난 코드를 알아볼 수 있다. 장황한 코드 보다 의미가 분명한 코드를 작성하는 것이 기본이다. 기본을 지키면 적어도 못난 코드를 피할 수 있다.

