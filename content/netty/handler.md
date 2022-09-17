---
title: "Netty 채널 소개와 채널 핸들러"
date: 2020-03-22T10:10:24+03:00
draft: false
---

채널은 IO 동작(파일, 소켓)을 수행할 수 있는 연결 상태를 의미합니다. Netty에서는 채널 핸들러를 이용해 관심사 분리를 수행합니다.



#### 채널 핸들러 종류

| 종류             |                                                              |
| ---------------- | ------------------------------------------------------------ |
| Inbound Handler  | 입력 데이터(in bound)에 대한 변경 상태를 감시하고 처리하는 역할을 하는 핸들러 |
| Outbound Handler | 출력 데이터(out bound)에 대한 동작을 가로채 처리하는 역할을 하는 핸들러 |



### ChannelInboundHandler 메소드

| 종류                     | 설명                                                         |
| ------------------------ | ------------------------------------------------------------ |
| channelRegistered(...)   | 채널이 이벤트 루프에 등록됐을때 호출됨                       |
| channelUnregistered(...) | 채널이 생성 됐지만, 이벤트 루프에 등록되지 않았을때 호출됨   |
| channelActive(...)       | 채널이 활성화 됐을때(peer와 연결됐을때) 호출됨. 채널이 활성화 됐다는 의미는 데이터를 받거나 보낼 수 있는 상태를 의미함 |
| channelInactive(...)     | 채널이 remote peer와 연결할 수 없을때                        |
| channelReadComplete(...) | 채널 읽기 동작시 채널이 완료 되었을때 한번 호출됨.           |
| channelRead(...)         | inbound buffer에서 읽을 값이 있을 경우 호출                  |
| userEventTriggered(...)  | 유저가 커스텀 객체에 연결해 트리거된 이벤트가 있을때 호출됨. |



#### 서버 비즈니스 코드 개발

netty는 callback과 future라는 컨셉을 이용한다. 이 때문에 이벤트 타입(event types)에 따라 다르게 반응합니다.

```
@Sharable                                                                  #1
public class EchoServerHandler extends ChannelInboundHandlerAdapter {
      @Override  #2
      public void channelRead(ChannelHandlerContext ctx, Object msg) {
           System.out.println(ìServer received: ì + msg);
           ctx.write(msg)                                                 
      }
      @Override #3
      public void channelReadComplete(ChannelHandlerContext ctx) {
           ctx.writeAndFlush(Unpooled.EMPTY_BUFFER)
                   .addListener(ChannelFutureListener.CLOSE);             
			}
      @Override  #4
      public void exceptionCaught(ChannelHandlerContext ctx,Throwable cause) {
					cause.printStracktrace();
					ctx.close();
			}
}
```

`#1`에서 @Sharable 어노테이션은 여러 채널에서 Handler를 공유 할 수 있음을 나타냅니다. `#2`는 메시지가 들어올때마다 호출되는 메소드입니다. `#3`은 channelRead 메소드가 처리 완료 되었다는 것을 핸들러에게 통보 처리를 하고 있습니다. #4는 읽기 작업중 오류가 발생 했을때 호출 됩니다. 참고할 만한 전체 예시는 [HttpHelloWorldServerHandler.java](https://github.com/netty/netty/blob/4.0/example/src/main/java/io/netty/example/http/helloworld/HttpHelloWorldServerHandler.java) 내용을 참고 합니다.





#### 서버 로직 개발

```
@Sharable                                                                  #1
public class EchoClientHandler extends SimpleChannelInboundHandlerAdapter<ByteBuf> {


			@Override
	  public void channelActive(ChannelHandlerContext ctx) {
	      ctx.write(Unpooled.copiedBuffer(ìNetty rocks!ì, CharsetUtil.UTF_8);   #2
	  }
	  @Override
	  public void channelRead0(ChannelHandlerContext ctx, ByteBuf in) {
	      System.out.println(ìClient received: ì + ByteBufUtil
	      .hexDump(in.readBytes(in.readableBytes())));                          #3
	  }
	  @Override
	  public void exceptionCaught(ChannelHandlerContext ctx,Throwable cause) {    #4
	    cause.printStracktrace();
	  	ctx.close();
	  }

}
```



