---
title: "ProcessBuilder 클래스 - 운영체제 프로세스 생성"
date: 2020-01-15T06:35:19+03:00
draft: false
---

이전 버전에서는 Runtime.exec()을 이용해 프로세스를 실행할 수 있습니다. 그런데 이 방법은 [When Runtime.exec() won't](https://www.javaworld.com/article/2071275/when-runtime-exec---won-t.html)에서도 소개 됐듯이 표준 입력과 출력에 대한 제한된 버퍼 사이즈로 인해 하위 프로세스가 block 되거나 데드락이 되기도 하는 문제가 있었습니다.

자바 JDK 7 이상에서는 이러한 문제점을 해결 하고자 [Proccess Builder 클래스](https://docs.oracle.com/javase/7/docs/api/java/lang/ProcessBuilder.html)가 소개됩니다. [이 클래스](https://docs.oracle.com/javase/7/docs/api/java/lang/ProcessBuilder.html)는 `운영체제 프로세스 생성`할 때 사용합니다. Process Builder 클래스 인스턴스에는 프로세스를 제어할 때 필요한 유용한 속성을 제어합니다. 예를 들어 start() 메서드는 입력 받은 커맨드를 실행해 새로운 프로세스를 생성 합니다.

**생성자의 역할**

- **ProcessBuilder(List 커맨드):** 운영체제 명령어를 리스트 형태로 받아 명령 수행을 위한 프로세스 생성
- **ProcessBuilder(String… 커맨드):** 운영체제 명령어를 String 문자열로 입력 받아 명령 수행을 위한 프로세스 생성

예제1. ProcessBuilder(List 커맨드) 방식

```java
import java.lang.*; 
import java.io.*; 
class ProcessBuilderExample 
{ 
	public static void main(String[] arg) throws IOException 
	{ 
		// processs 목록을 생성
		List<String> list = new ArrayList<String>(); 
		list.add("/usr/bin/vi");
    list.add("/usr/bin/vi hello.txt");
		
		// 프로세스 생성
		ProcessBuilder build = new ProcessBuilder(list); 
		
		// 프로세스 빌더 인스턴스에 저장된 커맨드 확인 
		System.out.println("command: " + build.command()); 		
	} 
}
```

출력 결과

```
command: [/usr/bin/vi, /usr/bin/vi hello.txt]
```

만약 현재 작업 디렉터리를 설정하려면 build 인스턴스에 다음과 같이 세팅합니다.

```
// 디렉터리 설정
build.directory(new File("src")); 
```

예제 2. ProcessBuilder(String… 커맨드) 방식 - ProcessBuilder에 OS 명령어를 인자로 전달하는 경우

```java
ProcessBuilder processBuilder = new ProcessBuilder("/usr/bin/vi");
processBuilder.redirectOutput(ProcessBuilder.Redirect.INHERIT);
processBuilder.redirectError(ProcessBuilder.Redirect.INHERIT);
processBuilder.redirectInput(ProcessBuilder.Redirect.INHERIT);
Process p = processBuilder.start();
p.waitFor();
```

여기서 하위 프로세스가 부모 프로세스의 출력을 받아 출력 하기 위해 인자로 ProcessBuilder.Redirect.INHERIT를 전달합니다. 마찬가지로 부모 프로세스의 에러나 입력 등을 처리를 위해 redirectError, redirectInput로 `ProcessBuilder.Redirect.INHERIT` 인자를 전달합니다. 이후 프로세스를 실행합니다. waitFor() 메서드는 현재 실행한 프로세스가 종료될 때까지 블록 처리되도록 합니다.

