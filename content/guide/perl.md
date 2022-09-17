---
title: "1시간 안에 펄(Perl) 언어 익히기"
date: 2020-01-15T06:35:54+03:00
draft: false
---

본 포스팅에서 사용한 예제는 [다운로드](../perl-examples.zip) 가능하다. Perl은 고수준의 동적 타입 언어로 `csh, Pascal, BASIC-PLUS, PHP, Python` 등과 비교되는 언어다. Perl은 쉘 스크립트로 기원했기에 다른 스크립트나 다른 프로그램을 엮어 주는 글루 코드(glue code) 언어로 시스템 관리에도 적합한 언어이다. C, sed, awk 그리고 sh와 같은 언어나 프로그램들의 가장 좋은 점들을 취합한 언어이기도 하다. sed, awk, sh를 사용하여 문제를 풀기 어렵다면 Perl이 대안이 된다. 이외에도 다음과 같은 특징이 있다.

- 거의 모든 운영체제에 설치되어 있다.
- 무료이다.
- 사용하기 쉬운 언어이다.
- 텍스트 데이터 처리가 쉽다.
- OS를 위한 glue language이다. (유닉스 계열의 시스템 관리에 활용 가능)
- C언어에 삽입이 가능
- TCP/IP 네트워크 작업을 쉽게 처리할 수 있음
- 커뮤니티가 활성화 되어 있음

### Windows용 Perl 설치

Perl은 리눅스 배포판에 기본적으로 설치 된다. 윈도우즈 사용자라면 딸기 Perl을 설치한다.

http://strawberryperl.com/

### Hello World

Perl은 pl이라는 확장자를 사용한다. 1_HelloWorld.pl 파일을 만들고 hello world를 출력해보자.

**[예제]** 1_HelloWorld.pl

```perl
use strict;
use warnings;

print "Hello world";  # ; 를 붙여야함에 유의
```

명령어는 다음과 같이 입력한다.

```
perl 1_HelloWorld.pl
```

이 저장소 프로젝트는 **[Visual Studio Code](https://code.visualstudio.com/)** 프로젝트이므로 VSCode에서 프로젝트 불러온 후 빌드(Ctrl+Shift+b)하면 Perl의 실행 결과를 바로 콘솔 창에서 확인할 수 있다.

### 기본 타입

Persl에서 일반 변수들은 스칼라(scala) 변수라고 부른다. 일반 변수들의 타입은 undef, number(int, float), string가 될 수 있다. 특이한 점으로 Perl은 Boolean 타입이 없다.

**[예제]** 2_BasicTypes.pl

```perl
# Scala 변수 : undef, number(int, float), string, 참조 변수
my $undef = undef;
print $undef; # 빈 문자열(" ")을 출력함

my $undef2; # implicit undef 선언
print $undef2;

my $num = 100;
print $num; # "100"을 출력함

my $string = "hello\r\n";
print $string; # "hello"를 출력함

# Boolean 타입 : Boolean 타입은 없으며 undef, number 0, string "" string "0" 인지를 if 조건 문에서 검사해야함
```

### 배열 타입

배열 타입은 Python에서 list, PHP에서는 Array에 해당하는 타입이다. 변수의 요소는 숫자, 문자열이 올 수 있다. 다소 특이한 점은 배열 변수명 앞에는 “@“를 붙여 선언한다.

**[예제]** 3_ArrayTypes.pl

```perl
# 배열 타입 : Python의 list, PHP의 array에 해당하는 타입
my @array = (
	"one",
	"two",
	"three", # trailing 컴마 허용
);
print "배열 요소는 ".(scalar @array)."개\r\n"; # "배열 요소는 3개"
print "배열 요소는 @array\r\n"; # "배열 요소는 one two three"
print $array[0]; # "one"
print $array[1]; # "two"
print $array[2]; # "three"
```

### 해쉬 타입

해쉬 타입은 Python에서 Dict, PHP에서는 Array에 해당하는 타입이다. 해쉬 변수명의 접두어에는 “%“가 붙는다.

**[예제]** 4_HashTypes.pl

```perl
# 해쉬 타입 : Python의 Dict, PHP의 array에 해당하는 타입
my %hashValues = (
	"1"   => "One",
	"2" => "Two",
	"3"   => "Trhee",
);

print $hashValues{"One"};   # "One"
print $hashValues{"Two"};   # "Two"
print $hashValues{"Trhee"};   # "Trhee"
```

### 중첩 구조 처리

배열 특정 인덱스에 다른 배열을 할당하려 할때 스칼라 변수로 취급되어 배열 요소 개수가 할당된다.

**[예제]** 5_NestedStructure.pl

```perl
my @outer = ("Sun", "Mercury", "Venus", undef, "Mars");
my @inner = ("Earth", "Moon");

$outer[3] = @inner; # @inner는 scala 변수로 취급되어 2가 할당됨
print $outer[3]; # "2"

$outer[3] = "Earth"; # Earth가 할당됨
print $outer[3]; # "Earth"
```

### 참조

일반 변수에는 다른 변수를 할당 받아 참조 변수 역할을 할 수 있다. C 포인터처럼 참조 주소를 출력하거나 참조 값 출력이 가능하다.

**[예제]** 6_References.pl

```perl
my $hello    = "Hello";
my $helloRef = \$hello;

print $hello."\r\n";         # "Hello" => 할달됭 값 출력
print $helloRef."\r\n";      # "SCALAR(0x2525dd0)" => 참조 주소 출력
print ${ $helloRef }."\r\n"; # "Hello" => 참조하는 값 출력
print $$helloRef # "Hello" => 참조하는 값 출력
```

### if 조건문

PHP 조건문과 선언 형태가 동일하다.

**[예제]** 7_If.pl

```perl
my $abc = "abcdefg";
my $strlen = length $abc;

if($strlen >= 3) {
	print "'", $abc, "'는 3글자 이상";
} elsif(1 <= $strlen && $strlen < 3) {
	print "'", $abc, "'는 1~2글자";
} else {
	print "'", $abc, "'는 1글자 이하";
}
```

### 루프 - while, foreach, for 문

C나 PHP의 루프문 선언 스타일과 비슷하다. Array를 순회할때 for문 보다는 foreach문이 편리할 때가 많다.

**[예제]** 8_Loop.pl

```perl
my @array = (
	"one",
	"two",
	"three"
);

my $i = 0;
while($i < scalar @array) {
	print $i, ": ", $array[$i]; # 0: one1: two2: three
	$i++;
}

print "\n";

foreach my $i ( 0 .. $#array ) {
	print $i, ": ", $array[$i]; # 0: one1: two2: three
}

print "\n";

for(my $i = 0; $i < scalar @array; $i++) {
	print $i, ": ", $array[$i]; # 0: one1: two2: three
}
```

**[보충]** foreach 스타일 for문

perl은 foreach 스타일 for문도 지원한다.

```perl
for my $i (0..9) {
  print "$i\n";
}
```

**[보충]** until문과 do while 문

상대적으로 잘 사용하지 않는 루프지만 **until**문과 **do while**문도 지원한다.

```perl
$count = 1;
until ($count > 10) {
  print "Countup is: $count\n";
  $count++;
}
$count = 10;
do {
  print "Countdown is: $count\n";
  $count--;
} while ($count > 0)
```

### Array 함수

Array는 여러 문자열, 숫자 등을 담을 수 있는 자료형이다. Perl은 Array 자료형 지원 분 아니라 Array의 요소를 다룰 수 있는 함수를 지원한다.

**[예제]** 9_ArrayFunctions.pl

```perl
my @array = (
	"one",
	"two",
	"three"
);

print join(", ", @array); # one, two, three => Array 요소를 , 로 구분해 합치기
print "\r\n";
print reverse(@array); # threetwoone => Array 요소를 뒤집기
print "\r\n";
print join(", ", reverse(@array)); # three, two, one => Array 요소를 뒤집어 , 로 구분해 합치기
```

**[참고]** Array 동작과 관련한 함수

- [pop](https://perldoc.perl.org/functions/pop.html) - 마지막 요소를 제거해 반환
- [push](https://perldoc.perl.org/functions/push.html) - 하나의 요소를 추가
- [shift](https://perldoc.perl.org/functions/shift.html) - 첫번째 요소를 제거해 반환
- [splice](https://perldoc.perl.org/functions/splice.html) - 특정 위치에 요소를 추가하거나 삭제
- [unshift](https://perldoc.perl.org/functions/unshift.html) - 리스트 시작에 여러 요소를 추가하여 시프트

### 정규식

match 동작을 수행하기 위해 “=~ m/“를 사용했다. replace 동작 수행은 “=~ s/“를 사용한다.

**[예제]** 10_Regex.pl

```perl
# Match 처리
my $string = "Hello world";
if($string =~ m/(\w+)\s+(\w+)/) { # success 
	print "success";
}

# Replace 처리
my $string = "One Two Three";
$string =~ s/Two/2/;
print $string; # "One 2 Three"
```

**[보충]** 정규식 매칭

| 표현식 | 의미                                  |
| :----- | :------------------------------------ |
| ^      | 문자열 시작                           |
| $      | 문자열 끝을 의미                      |
| .      | 새로운 라인을 제외한 모든 문자를 의미 |
| *      | 0번 이상 매칭                         |
| +      | 1번 이상 매칭                         |
| ?      | 0 또는 1번 매칭                       |
| \|     | 대체                                  |
| ( )    | 그룹핑                                |
| [ ]    | 문자열 셋                             |
| { }    | 반복                                  |
| \      | 특수 문자 앞에 둠                     |

**[보충]** 정규식 반복

| 표현식      | 의미                                |
| :---------- | :---------------------------------- |
| a+          | 1개 이상 반복된 것과 매칭           |
| a?          | 0개 또는 1개 반복된 것과 매칭       |
| a{m}        | 정확히 m개 반복된 것과 매칭         |
| a{m,}       | 최소 m개 반복된 것과 매칭           |
| a{m,n}      | 최소 m개 ~ n개까지 반복된 것과 매칭 |
| repetition? | 가장 짧게 반복된 것과 매칭          |
| a*          | 0개 이상 반복된 것과 매칭           |

### BEGIN 블럭

BEGIN 블록은 파싱되는 순간 바로 실행된다.

**[예제11]** 11_Begin.pl

```perl
use strict;
use warnings;

print "하나";

BEGIN {
    print "둘";
}

print "셋";
# 둘하나셋
```

### 객체지향 프로그래밍

Perl에서 클래스 역할을 하는 것은 바로 패키지(package)이다. 패키지는 네임스페이스의 역할을 하며 서브 메서드를 선언할 수 있다. 패키지 선언은 다음과 같다.

```perl
package Hello;
```

패키지가 초기화될때 생성자(constructor)는 다음과 같은 형태로 선언한다.

```perl
sub new {

    my $this = {};  # 익명 해쉬를 생성하고 자신(Hello 패키지)을 가르키게함.

    bless $this;       # Hello 패키지와 연결

    return $this;     # Hello 패키지를 참조

};
```

Hello 패키지를 선언해 hello 객체를 생성하고 Hello World를 출력해보자.

**[예제]** 12_Class.pl

```perl
package Hello;

use strict;
use warnings;

# 생성자
sub new {
    my ($class, %args) = @_;
    return bless { %args }, $class;
}

# Hello 클래스의 메서드
sub helloWorld {
    my ($self) = @_;
    print $self->{data1}." ";
    print $self->{data2};
}

my $helloObject = Hello->new( data1 => 'hello',
                      data2 => 'world' );
$helloObject->helloWorld(); # hello world
```

**[보충]** Perl 모듈 파일(pm)과 호출

Perl 모듈은 *.pm 파일로 정의할 수 있다. *.pm 파일의 형식은 일반 Perl 코드와 동일하다. SomeMoudle.pm로 정의한 모듈 파일을 호출하려면 상단에 다음과 같이 선언해준다.

```perl
require SomeModule;
require "SomeModule.pm";
```

**[보충]** 서브루틴 선언과 호출

Perl에서 함수를 서브루틴이라 부른다. 서부르틴의 선언과 호출은 다음과 같다.

```perl
# Subroutine 정의
sub say_hello {
   print "Hello, World!\n";
}

# Subroutine 호출
say_hello();
```

일반적인 함수와 달리 서브루틴에 매개변수 선언 부분이 없고 $args 배열이 매개변수 역할을 대신한다.

```perl
# subroutine 정의
sub calc_average {
    # 인자 개수 할당
    $total_args = scalar(@_);
    $sum = 0;
    # 인자 값을 합함
    foreach $arg (@_){
    	$sum += $arg;
    }
    # 평균 출력
    $average = $sum / $total_args;
    print "Average of list [ @_ ] is: $average\n";
}

# subroutine 호출
calc_average(10, 20, 30); 
```

### 시스템 콜

시스템 콜을 통해 프로그램을 엮어 주는 글루 코드 작성이 가능하다. 먼저는 system 콜을 통해 외부 명령어 “perl 1_HelloWorld.pl"를 실행하도록 했다. 이어서 명령어 실행 결과를 변수에 담아 출력 하도록 했다.

**[예제]** 13_SystemCall.pl

```perl
my $rc = system "perl", "1_Helloworld.pl"; # Hello World
print $rc; # 0 => 프로세스의 status word를 출력함

my $result = qx("ping localhost"); # 명령어 실행 결과를 변수에 저장
print $result; # 캡쳐 결과 출력
```

### 시스템 관리 작업

시스템 관리 작업에 응용할 수 있다. 예를 들어 현재 디렉터리의 파일목록 출력하는 작업은 다음과 같다. 비록 파일을 합치거나 후속 처리는 하지 않았지만 시스템 관리용 스크립트를 추가해 작업을 자동화하는 것이 가능하다.

**[예제]** 14_Dir.pl

```perl
#!/usr/bin/perl
use strict;
use warnings;

opendir(dirHandle, "." ) or die "$!\n";
my @items = readdir(dirHandle);  # @items에 파일 목록 할당
closedir dirHandle;

foreach (@items) {
    next if $_ =~ /^\.\.?$/; # . or .. 이면 Skip
    next unless (-f $_);     # 디렉터리 이면 Skip
    print $_, "\n"; # 파일명 이면 출력
}
```

Perl의 정규식 처리 등은 Python으로도 훌륭히 처리되므로 알고리즘 개발에는 활용은 어려울 것으로 예상한다. 다만 시스템 관리 작업이 sh 쉡 스크립트보다 쉽기 때문에 쉘 스크립트를 대체할 수 있을 것이다.

### 더 읽어 볼만한 글

- Perl 공식 문서 [https://perldoc.perl.org](https://perldoc.perl.org/)
- Perl 배우기 https://www.learn-perl.org/en/Welcome
- Teach Yourself Perl 5 in 21 days http://wwwacs.gantep.edu.tr/docs/perl-ebook/
- Object-Oriented Programming in Perl http://wwwacs.gantep.edu.tr/docs/perl-ebook/ch19.htm