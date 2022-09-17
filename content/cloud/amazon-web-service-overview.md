---
title: "아마존 웹 서비스 개요"
date: 2021-07-17T15:11:42+03:00
draft: false
---

### AWS Ovewview

- AWS 리전 한국에는 데이터 센터가 4개로 구성되어있고, 이를 `가용 영역`이라 부름(서울 리전인 경우)
- CDN(콘텐츠 전송 네트워크) [cloud front](https://aws.amazon.com/ko/cloudfront/) 제공
- AWS 이점 - 보안, 가용성, 성능, 확장성, 유연성



### VPC(Virtual Private Computing)

- 사용자가 정의한 네트워크 공간 제공
- `NAT Gateway`는 내부 사설 IP(Private IP) 간의 Gate Way 역할., NAT Gateway에 EIP(Elastic IP)를 붙여서 외부 IP로 사용.
- InBound/OutBound

 - Web Server는 443(port)에 대해 Any Open으로 제공
 - Private subnet은 Application Server 운영, Security Group에 Application Server 확장 가능
- ​	private subnet에서 외부 소유의 private subnet을 연결할 때는 security 그룹으로 묶어서 관리 가능

 - 동일 리전의 VPC peering으로 가능
 - VPC <-> VPC 간에 Peering이 있는 경우만 상호 커넥션이 가능함

 - 서로 다른 리젼간의 커넥션도 가능
- VPC는 서로 다른 존에 존재하는 N개의 서브넷으로 구성이 가능함



### EC2

- AMI(Amazon Machine Image)

- EBS : 스토리지 서비스

- EC2 상태 : Runnig, stoppped(일정 기간 휴면한다 해도 삭제하지 않음;과금안됨), Terminated(완전히 제거된 상태; 과금안됨)

- 인스턴스 타입 : 400여 개 이상(2020년에만 100개 이상 타입이 추가됨)

   - 크게 5가지 타입 - 범용적, 컴퓨팅 유형, 메모리 최적화, 컴퓨팅 가속화 타입

- 인스턴스 크기

   - xlarge=1시간 운영 비용, 8xlarge = 8시간 운영 비용
   - 큰 인스턴스(8xlarge)보다, 작은 인스턴스(xlarge 8개)로 구성하는 것이 비용상 이점이 있음
   - 예) 작은 인스턴스 vs 큰 인스턴스

- EC2 구매 옵션

   - 온디맨드는 초 단위 용량 지불, 예약 인스턴스(1년 단위, 3년 단위 등), 스팟 인스턴스(필요시에만 잠깐 사용)

 - EC2 Auto Scaling을 이용해 변화하는 수요에 동적으로 대응하고 비용을 최적화

   (헬스 체크 후 불량 인스턴스는 신규 인스턴스로 붙임)



### DB

- Aurora
  - 기존 MariaDB, MySQL등을 Amazon Aurora로 전환가능
- 마이크로 서비스로 변화된 데이터 분석 요구
- 자체 관리 DB의 경우 설치/구성/패치/백업 관리(성능 및 가용성 이슈)
  - 완전 <관리형 DB서비스>를 이용하면, 백업&복구 등의 기본적인 기능은 AWS를 이용
- Legacy 상용 DB
  - 비싼 비용, 소유권, 솔루션에 Lock In, 잦은 감사(audit)
  - Amazon RDS : Amazon RDS, MySQL, PostgreSQL, MariaDB, SQLServer, Oracle
- 프로버저닝 기능
- `CloudWatch`를 이용해 CPU/메모리 등에 대한 모니터링 제공
- 가용성 유지를 위한 A/S 구조 지원
  - 읽기에 대해서는 read replica를 두어 부하 분산 가능
- Auto Scaling(사용량에 따라 증가)
- `Amazon Aurora`
  - Amazon에서 개발한 자체 개발한 관리 도구( *Amazon RDS* AWS Management Console 인터페이스)
  - MySQL 및 POSTgreSQL 호환
  - Primary Instnat, Stand By Instant로 운영 가능
  - 6대(replica)가 동시에 썼을때 모두 Write가 성공한 경우 Write된것으로 확인(?퍼포먼스 악화 시키는 요인?)
    - replica instnat를 리전을 확장하더라도, 논리적으로 그룹핑하여 사용 가능.
  - Account 권한만 있으면 기존 DB를 가져다가 사용할 수 있음.



### Storage

- Storage Back&Restore / Archive(장기보관) / Data Lakes(AI/ML 기반, Data Raw) 
- 서버리스 : 서버가 없는 것처럼 보이지만 실재 서버가 있는 방식으로 서버 구성
  - AWS는 서버리스더라도 Storage는 영구적으로 쓸 수 있도록 제공
  - 온프라미스 to 클라우드로 마이그레이션
- 스토리지 타입
  - 블록스토리지, 파일스토리지(NAS)형태, 오브젝트 스토리지
- EBS(Elastic 블록스토리지)
  - 데이터 손실 방지 위해 볼륨 복제
- EBS 볼륨 타입
  - 일반적인 목적 - 일반적인 SSD 이용.
  - I/O가 많은 DB 애플리케이션  등
  - 빅데이터, 분석
  - 파일, 미디어
- EBS IO 볼륨 타입에 따라 io1, io2 등이 있음.
  - EBS Multi Attach
    - 하나의 EBS를 여러 인스턴스에 붙일 수 있고. 최근부터 지원
- EFS (NAS로 생각할 수 있음)
- 자주 안쓰는 것은 infrequency access 스토리지로 구성(Policy Rule에 따라 N일 이상 접근안 한 경우 이동)
