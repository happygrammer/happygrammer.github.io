---
title: "TDD 테스트"
date: 2018-06-02T23:11:59+03:00
draft: true
---

개발과정중 검증을 통해 코드에 대한 신뢰를 확보할 수 있는 궁극의 방법이다.



### 단위테스트의 목적 ###

단위테스트는, 특정 모듈이 의도되로 동작하는지 검증하는 절차이다. 이러한 목적 달성을 위해, 모든 함수에 대한 테스트 케이스를 작성할 수 있다.

단위테스트를 하는 목적은, 코드에 대한 신뢰를 높이고, 잠정적 리스크를 줄임으로서 유지보수에 대한 개발 시간을 줄이기 위해서 이다.



### 단위테스트를 방해하는 이유 ###

단위테스트를 작성을 어렵게 하는 요인들이 있다.

- 의존관계 
  - 객체지향프로그램의 경우 객체간의 의존관계들이 존재한다. 
- 모든 테스트 케이스 파악 불가
  - 또한, 개발자가 개발한 코드에 대해 여기저기 얽혀 있는 모든 테스트 케이스에 대해 파악할 수 없기 때문이다. 
- 나쁜 가독성
  - 또하나, 단위테스트를 어렵게 하는 요인으로, 텍스트가 어렵게 작성된 가독성이 나쁜 메소드나 클래스, 변수로 인해서 발생한다.



### 단위테스트 방법 ###

테스트케이스는 특정 요구사항에 대응하기 위해 사용하는 테스트 시나리오에 의한 테스트 방법이다. 테스트 케이스스는 시나리오와 테스트단계, 그리고 예상되는 결과와 실재 출력결과등을 작성한다.  Junit에서는, 이러한 TestCase 작성을 통한 테스트 방법을 지원하고 있다. 테스트를 위해 'TestCase' 클래스를 상속받고, 메소드명의 접두어에 'test' + '메소드명'을 적고, 테스트 케이스에 속한 함수를 작성할 수 있다. 아래 예는 int 배열에 대한 테스트 케이스 작성의 예이다. 아래 코드에서, int 배열 초기화에 대한 테스트 메소드로  testInteger1부터 testInteger3까지 작성하였는데, 초기화 방법으로, testInteger1이 개인적으로 가독성이 좋다고 생각한다.


	package junit.testcase;
	
	import static org.junit.Assert.fail;
	
	import org.junit.Assert;
	import org.junit.Test;
	
	import junit.framework.TestCase;
	
	public class ex1_ArrayTestCase extends TestCase {


​		

		@Override
		protected void setUp() throws Exception {
			// TODO Auto-generated method stub
			
		}
		
		public void testInteger1() throws Exception {		
			int[] result = {1,2,3};
			Assert.assertArrayEquals(new int[] {1,2,3}, result);
		}
		
		public void testInteger2() throws Exception {		
			int[] result = new int[]{1,2,3};
			Assert.assertArrayEquals(new int[] {1,2,3}, result);
		}
		
		public void testInteger3() throws Exception {		
			int[] result = new int[3];		
			result[0]=1;
			result[1]=2;
			result[2]=3;
			
			Assert.assertArrayEquals(new int[] {1,2,3}, result);
		}
	
	}

### 컨트롤러에 대한 테스트 ###

Spring Test MVC
[https://github.com/spring-projects/spring-test-mvc](https://github.com/spring-projects/spring-test-mvc)

메소드에 대한 단위 테스트 외에도, MVC 프레임워크에서, Controller를 테스트를 진행이 필요할때가 있다. 이러한 경우에는 'Spring MVC Test'와 같은 라이브러리를 이용하여 Mock 객체를 이용하여 Spring MVC 테스트를 할 수 있다.




### 애자일과 TDD ###

애자일 선언문에 보면, 작동하는 S/W를 고객에게 자주 보여주라는 원칙이 있다(2~4주 간격 혹은 더 짧은 기간). 결과물을 가지고, 고객에게 신뢰를 전달한다. Agile은 고객에게 신뢰를 전달하는 방법이다. 이러한 고객과 신뢰를 구축하기 위해 Agile Practice를 수행하며, 이 단계중 하나로 TDD가 있다. 

TDD는 `테스트 주도 개발(Test Driven Development)`이라 하며 코드를 작성한후에, 테스트를 통과하는 코드를 추가해서 개발을 진행하는 방법이다. TDD는 코드의 오류 파악을 용이하게 하며, 개발 단계에서 코드를 검증하기 때문에, 산출물에 대한 신뢰를 확보할 수 있으며, 테스트에 대한 부담을 줄 일 수 있다.
