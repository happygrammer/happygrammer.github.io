---
title: "Roberta_implementation"
date: 2020-03-29T14:55:36+03:00
draft: true
---



pytorch 이미지를 가져옵니다.

```
docker pull pytorch/pytorch
```

다운로드가 완료 되면 이미지를 확인합니다.

```
$ docker images
REPOSITORY              TAG                 IMAGE ID            CREATED             SIZE
pytorch/pytorch         latest              37b81722dadc        2 months ago        4.16GB
```

실행합니다.

```
docker run --gpus all --rm -ti --ipc=host pytorch/pytorch:latest
```





```
pip install regex requests
```



Pytorch 설치

```
pip3 install torch torchvision
```

RoberTa 로드

```
import torch
roberta = torch.hub.load('pytorch/fairseq', 'roberta.large')
roberta.eval()  # disable dropout (or leave in train mode to finetune)
```