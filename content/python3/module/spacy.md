---
title: "Spacy"
date: 2021-08-15T07:06:52+03:00
draft: true
---

### Spacy



#### install

```
python3 -m spacy download en_core_web_sm
```



#### code

```
import spacy

nlp = spacy.load("en_core_web_sm")
  
message\
=\
'''
I can't live. If living is without you. I can't live. I can't give anymore.
I can't L.I.V.E. If living is without you.. I can't give. I can't give anymore
'''

doc = nlp(message)
#to print sentences
for sent in doc.sents:
  print(sent)
```



#### 실행결과

```
I can't live.
If living is without you.
I can't live.
I can't give anymore.

I can't L.I.V.E.
If living is without you..
I can't give.
I can't give anymore
```





```
ner("노무현 대통령은 청와대에 사는 청와대인 이다.")
ner("신나는 노래 틀어줘")
ner("아이유가 대통령 빌딩에 들어갔다.")
```
