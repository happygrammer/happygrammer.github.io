---
title: "File Handler"
date: 2020-03-22T21:13:45+03:00
draft: true
---

`네티`는 고성능의 안정적인 서버 & 클라이언트 개발을 지원하는 자바 기반 프레임워크입니다. 메이즌 설정은 아래와 같습니다.

```
<dependency>
  <groupId>io.netty</groupId>
  <artifactId>netty-all</artifactId>
  <version>4.1.48.Final</version>
</dependency>
```



### 네티의 버퍼 라이프 사이클의 관리 방식

네티의 버퍼 라이프사이클은 `레퍼런스 카운팅`을 통해 관리되고 있다. 더이상 참조 하는 곳이 없다면 GC가 된다. "refCnt: 0, decrement: 1"와 같은 에러가 발생하는 이유는 로그에 남은 예외는 그 카운터 값이 0이 되었는데 다시 한 번 data.release() 릴리즈를 시도했을 경우 발생한다. 이미 0이 되어 반환 되었는데 다시 한 번 릴리즈 하였으므로 예외가 발생하게 된 것이다.

https://netty.io/wiki/reference-counted-objects.html



### 파일 업로드

파일 업로드 테스트 위한 클라이언트 코드는 아래와 같습니다.

```
<!DOCTYPE html>
<html>
<head></head>
<body>
  <form method="POST" action="http://localhost:8080/" enctype="multipart/form-data">
    <input type="file" name="uploadedFile" />
    <input type="submit" value="Upload" />
  </form>
</body>
</html>
```

php에 설정된 파일 정보를 확인 하려면 다음과 같이 작성합니다.

```
<?php echo php_ini_loaded_file(); ?>
```

출력 결과

```
; Whether to allow HTTP file uploads.
file_uploads = On
 
; Temporary directory for HTTP uploaded files.
; Will use system default if not set.
;upload_tmp_dir = 
 
; Maximum allowed size for uploaded files.
upload_max_filesize = 16M
 
; Maximum number of files that can be uploaded via a single request
max_file_uploads = 20
 
; Maximum size of POST data that PHP will accept.
post_max_size = 20M
 
max_input_time = 60
memory_limit = 128M
max_execution_time = 30
```



### 업로드 파일 예제

```
package simul.server;

import io.netty.buffer.ByteBuf;
import io.netty.buffer.Unpooled;
import io.netty.channel.ChannelFutureListener;
import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.SimpleChannelInboundHandler;
import io.netty.handler.codec.http.DefaultFullHttpResponse;
import io.netty.handler.codec.http.FullHttpResponse;
import io.netty.handler.codec.http.HttpContent;
import io.netty.handler.codec.http.HttpHeaderNames;
import io.netty.handler.codec.http.HttpObject;
import io.netty.handler.codec.http.HttpRequest;
import io.netty.handler.codec.http.HttpResponseStatus;
import io.netty.handler.codec.http.LastHttpContent;
import io.netty.handler.codec.http.multipart.DefaultHttpDataFactory;
import io.netty.handler.codec.http.multipart.FileUpload;
import io.netty.handler.codec.http.multipart.HttpDataFactory;
import io.netty.handler.codec.http.multipart.HttpPostRequestDecoder;
import io.netty.handler.codec.http.multipart.InterfaceHttpData;
import io.netty.util.CharsetUtil;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URI;
import java.nio.channels.FileChannel;

import static io.netty.handler.codec.http.HttpMethod.POST;
import static io.netty.handler.codec.http.HttpResponseStatus.CREATED;
import static io.netty.handler.codec.http.HttpResponseStatus.METHOD_NOT_ALLOWED;
import static io.netty.handler.codec.http.HttpVersion.HTTP_1_1;

/**
 * Upload a file to the setup path
 */
public class MyHttpUploadServerHandler extends SimpleChannelInboundHandler < HttpObject > {

    private static final HttpDataFactory factory = new DefaultHttpDataFactory(true); // Factory that writes to disk
    private static final String FILE_UPLOAD_LOCN = "/my/uploads/directory";
    private HttpRequest httpRequest;
    private HttpPostRequestDecoder httpDecoder;

    @Override
    protected void channelRead0(final ChannelHandlerContext ctx, final HttpObject httpObject) throws Exception {
        if (httpObject instanceof HttpRequest) {
            httpRequest = (HttpRequest) httpObject;
            final URI uri = new URI(httpRequest.uri());

            System.out.println("Got URI " + uri);
            if (httpRequest.method() == POST) {
                httpDecoder = new HttpPostRequestDecoder(factory, httpRequest);
                httpDecoder.setDiscardThreshold(0);
            } else {
                sendResponse(ctx, METHOD_NOT_ALLOWED, null);
            }
        }
        if (httpDecoder != null) {
            if (httpObject instanceof HttpContent) {
                final HttpContent chunk = (HttpContent) httpObject;
                httpDecoder.offer(chunk);
                readChunk(ctx);

                if (chunk instanceof LastHttpContent) {
                    resetPostRequestDecoder();
                }
            }
        }
    }

    private void readChunk(ChannelHandlerContext ctx) throws IOException {
        while (httpDecoder.hasNext()) {
            InterfaceHttpData data = httpDecoder.next();
            if (data != null) {
                try {
                    switch (data.getHttpDataType()) {
                        case Attribute:
                            break;
                        case FileUpload:
                            final FileUpload fileUpload = (FileUpload) data;
                            final File file = new File(FILE_UPLOAD_LOCN + fileUpload.getFilename());
                            if (!file.exists()) {
                                file.createNewFile();
                            }
                            System.out.println("Created file " + file);
                            try (FileChannel inputChannel = new FileInputStream(fileUpload.getFile()).getChannel(); FileChannel outputChannel = new FileOutputStream(file).getChannel()) {
                                outputChannel.transferFrom(inputChannel, 0, inputChannel.size());
                                sendResponse(ctx, CREATED, "file name: " + file.getAbsolutePath());
                            }
                            break;
                        default:
                            break;
                    }
                } finally {
                    // data.release();
                }
            }
        }
    }

    private static void sendResponse(ChannelHandlerContext ctx, HttpResponseStatus status, String message) {
        final FullHttpResponse response;
        String msgDesc = message;
        if (message == null) {
            msgDesc = "Failure: " + status;
        }
        msgDesc += " \r\n";
        final ByteBuf buffer = Unpooled.copiedBuffer(msgDesc, CharsetUtil.UTF_8);
        if (status.code() >= HttpResponseStatus.BAD_REQUEST.code()) {
            response = new DefaultFullHttpResponse(HTTP_1_1, status, buffer);
        } else {
            response = new DefaultFullHttpResponse(HTTP_1_1, status, buffer);
        }
        response.headers().set(HttpHeaderNames.CONTENT_TYPE, "text/plain; charset=UTF-8");
        ctx.writeAndFlush(response).addListener(ChannelFutureListener.CLOSE);
    }

    private void resetPostRequestDecoder() {
        httpRequest = null;
        httpDecoder.destroy();
        httpDecoder = null;
    }

    @Override
    public void exceptionCaught(ChannelHandlerContext ctx, Throwable cause) throws Exception {
        System.out.println(cause);
        ctx.channel().close();
    }

    @Override
    public void channelInactive(ChannelHandlerContext ctx) throws Exception {
        if (httpDecoder != null) {
            httpDecoder.cleanFiles();
        }
    }

}
```

