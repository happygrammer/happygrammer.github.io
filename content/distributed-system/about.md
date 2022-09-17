---
title: "분산처리 시스템 소개"
date: 2021-05-18T23:47:08+03:00
draft: false
---

`분산처리 시스템`은 여러 시스템 간의 동작을 일관성 있게 처리해 마치 하나의 프로세스가 하는 처리하는 것처럼 수행하는 시스템이다. 하나의 서버에 결집되어 있는 서버의 자원과 기능을 여러 서버에 분산 시켜 상호 협력함으로써 처리 성능과 신뢰성을 높이는 데 목적이 있다.



### 분산 시스템의 고전적인 문제

Failure Detection, Peer to Peer Systems, Key value store, sensor networks등이 으며, 동기화, 보안 관련 문제가 있다.



- 동기화(Synchronization)은 실재 시간 근거로 싱크를 맞추는것이며, 분산 환경에서 싱크를 맞추는 것은 쉽지 않다. 동기화를 위해 Clock Synchronization 알고리즘인 클럭 동기화 기법인 Berkely 알고리즘을 이용할 수 있음.





### 분산처리 시스템 구축 목표

개방성은 분산 처리의 중요한 목표이다. 개방성을 위해 standard rules을  제공하고자 Protocol을 이용하여 통신합니다. 이러한 표준화된 인터페이스를 지원하는 언어는  Interface Definition Language라고 한다. 이러한 인터페이스 기반의 통신은 바로 Interoperability 상호운영성이 가능해야하며, 설정이 쉬워야 한다. 분산 처리가 갖춰야할 요소는 다음과 같다.

- 신뢰성(robustness) : 서버 응답 장애가 발생하지 않도록 함
- 가용성(availability) : 서비스를 항상 제공할 수 있어야함
- 동시성(concurrency) : 많은 사용자가 동시에 요청이 오더라도 처리할 수 있어야함
- 투명성(transparent) : 내부 동작을 클라이언트에 숨겨야함
- 보안(security) : 해커의 위험으로부터 보호해야함

위 요소 중에 투명성이라는 것은 내부 동작을 클라이언트에 숨겨야 하는 것을 의미한다.

- Access : 리소스가 어떻게 접근되었는지와 데이터표현의 차이를 숨김
- Location : 리소스 위치를 숨김
- Migration : 리소스가 또다른 Location으로 Migration 되었다는 것을 숨김
- Relocation : 리소스가​ 사용간에 또다른 위치로 이동되었다는 것을 숨김
- Replication : 리소스가 Replication 되었다는 것을 숨김
- Concurrency : 리소스가 competitive 유저들에게 공유되고 있다는 것을 숨김
- Failure : 리소스의 Failure나 복구를 숨김
- Persistence : 리소스가 메모리 혹은 디스크 안에 있다는 것을 숨김  





### 투명성

투명성에 대해서 살펴보자, '투명성'은 내용이 있지만 없는 것처럼 처리하는 성질이다. 즉, 서버 내부에는 데이터의 이동, 삭제, 복사 등과 같은 동작이 존재할 수 있지만 외부에서 볼 때는 내부에서 처리 과정을 알 수 없도록 숨기는 성질을 의미한다. 분산 처리 시스템은 다음과 같은 점들에 대해 투명성을 유지할 수 있어야 한다.

- 접근  : 어떤 데이터를 접근 했는지 숨김
- 위치 : 데이터 위치가 어디에 있는지를 숨김
- 이동 : 데이터가 다른 위치로 이동되었는지를 숨김
- 복제 : 데이터가 복제되었는지를 숨김
- 실패 : 실패 상황에서 복구가 되었는지를 숨김



### 분산처리 시스템의 ACID 보장

분산 시스템에서 네트워크는 100%로 신뢰할 수 없기 때문에 이러한 상황에 대해서도 안정적인 처리가 가능하도록 DB의 ACID와 같은 성질을 제공할 수 있어야한다.

- 원자성 Atomic : 트랜잭션이 성공하거나 실패되어야한다. 부분적으로 실행 되면 안됨
- 일관성 Consistent : 트랜잭션 반영이 성공했다면 일관성 있게 상태를 유지할 수 있어야함
- 독립성 Isolated : 동시에 트랜잭션이 발생하더라도 트랙잭션 간에 성호 간섭을 주면 안됨
- 지속성 Durable : 반영된 내용은 별도 변경 요청이 없는한 영구적으로 유지될 수 있어야함



### 분산처리 시스템의 아키텍처 스타일

분산처리 시스템은 호출을 처리하는 방식에 따라 다음과 같은 아키텍처 스타일을 고려할 수 있다.

- 레이어(Layered) 아키텍처 : OS7과 비슷, 하위 레이어의 컴포넌트를 호출해 처리하는 방식
- 객체 기반(Object-based) 아키텍처 :  RPC 기반으로 원격 컴포넌트 간에 호출을 통해 구성하는 방식
- 데이터 중심(Data-centered) 아키텍처 : 파일 시스템을 공유해 처리하는 방식이다. 웹 애플리케이션에서 사용
- 이벤트 기반(Event-based) 아키텍처 : 이벤트가 게시(publish) 되면 미들웨어는 이벤트를 구독(subscribe)



### 분산처리 시스템의 구성

분산 처리 시스템은 서버 간의 결합을 통해 동작하는 시스템이다. 이들 서버 구성에 따라 다음과 같은 서버 아키텍처를 구성할 수 있다.

- 클러스터링 컴퓨팅 : 같은 네트워크 내에서 단일 마스터 노드가 존재하며 병렬 처리를 수행
- 그리드 컴퓨팅 : 다른 네트워크 간에 공동 작업을 처리를 수행해 대규모 연산을 처리함

클러스터 컴퓨팅 시스템은 동종의 SW, HW를 성능 향상을 위해 연결하는 관점이다. 동종의 컴퓨터를 성능향상을 위해 연결. Master Node과 계산 Node로 나뉘어진다. 그리드 컴퓨팅(Gird Computing System)은 다른 종류(heterogeneous)의 SW, HW를 연결하는 시스템이다. 컴퓨터의 연산능력, 데이터, 첨단 실험 장비 등 여러 장비를 인터넷을 통해 공유하려는 새로운 분산컴퓨팅 모델 컴퓨터의 처리능력을 한 곳으로 모아 가장 중요한 업무에 집중사용할 수 있게 해주는 기술을 말한다. 고속 네트워크로 연결된 다수의 컴퓨터 시스템이 사용자에게 통합된 가상의 컴퓨팅서비스를 제공하는 개념으로 분산컴퓨팅(distributed computing)이라고도 불린다. 그리드(GRID)란 세계적으로 연구가 진행 중인 차세대 인터넷망으로, 현재의 인터넷 방식인 월드와이드웹(WWW)과 달리 컴퓨터의 처리능력을 한 곳으로 집중시킬 수 있는 인터넷망이다. virtual organization하다는 특징이다.



### 분산 처리 시스템의 통신 방식 ###

애플리케이션 간에는 미들웨어를 이용해 커뮤니케이션 할 수 있으며, 동일한 프로그래밍 인터페이스임

1. MOM (message-oriented middleware)
2. RPC(remote procedure calls)방식
   - remote method invocation 이 대표적



### 그리드 컴퓨팅 시스템의 계층 ###

그리드 컴퓨팅 시스템은 다른 종류의 시스템과의 협력(collaboration)을 위해 `virtual organization` 형태를 고려한다. 그리드 컴퓨팅 시스템의 아키텍쳐는 다음과 같다.

- fabric Layer : 가장 낮은 계층, 특정 사이트에서 로컬리소스에 대한 인터페이스를 제공한다.

- connectivity Layer : 프로토콜 간의 커뮤니케이션을 담당한다.

- resource Layer : 이 계층은 configuration 정보들을 제공하고, access control에 대한 역할
- collective Layer : multiple resource에 접근하고 다룬다. 리소스를 발견하고, 할당(allocation), multiple resource에 대한 scheduling, data replication 역할
- application Layer : 마지막으로 Application Layer는 Virtual organization내에 applications들로 구성된다. grid computing 환경을 구축하기 위해 사용

분산처리시스템은 독립 컴포넌트 들이 EAI(enterprise application integration)관점으로 서로 통신한다.



### Transaction Proceessing Systems 

Transaction 시스템인 DB는 분산된 트랜잭션 (distributed transaction)을 수행할 수 있다. remote server들에 대하여 procedure call을 하게 되면 캡슐화(encapsulated)한 상태로 호출하게 된다. 이러한 원격 호출 방법을 `transactional RPC`라고 한다. 여기서 Transaction의 원시적(primitive) 동작은 5가지이다.

`Transaction`의 Primitive 예

- BEGIN-TRANSACTION     
- END_TRANSACTION      
- ABORT_TRANSACTION  
- READ      
- WRITE

각 Primitive들은 4가지 요건을 충족해야 한다.

- Atomic : completely or not. (All or Nothing)
- Consistent : 변화가 되지 않아야한다.
- Isolated : 동시에 transaction이 발생하더라도 서로 간섭하지 않아야한다.
- Durable : transaction commits후 영구적으로 반영되어야한다.
