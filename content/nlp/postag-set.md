---
title: "품사와 품사 태그셋 소개"
date: 2020-01-22T00:46:58+03:00
draft: false
---

POS tagging(**part-of-speech tagging**)은 형태소 분석 결과 분류된 품사를 태깅하는 작업을 의미한다. 여기서 품사는 단어의 공통 성질을 갈래 지어 놓은 이름이다. 태깅시 사용하는 품사에 대응하는 약속은 품사 태그(POS Tag : part-of-speech tag)라 하며 이들 품사 태그의 모음을 품사 태그 셋(tag set)이라고 한다. 품사 부착 말뭉치(corpus)는 품사 태그가 부착된 말뭉치를 의미한다. 고품질의 품사 부착 말뭉치의 규모가 커지면 언어 연구 진행이 용이해진다. 이 문서에는 품사 태그셋을 소개하기에 앞서 한국어와 영어의 품사를 소개하고, 영어의 품사 태그셋과 한국어의 품사 태그셋(POS Tag Set)을 소개한다.



### 한국어와 영어의 품사

한국어에는 9품사가 있고 영어에도 9품사가 있다. 품사 수는 동일하지만 품사 구성은 다르다. 한국어에서 조사는 문법적 기능으로 다루는 경우가 있어 8품사로 보는 견해도 있다.

| 순서 | 품사명               | 한국어 | 영어 |
| ---- | -------------------- | ------ | ---- |
| 1    | 명사(noun)           | O      | O    |
| 2    | 대명사(pronoun)      | O      | O    |
| 3    | 동사(verb)           | O      | O    |
| 4    | 형용사(adjective)    | O      | O    |
| 5    | 관형사               |        |      |
| 6    | 수사                 | O      |      |
| 7    | 부사(adverb)         | O      | O    |
| 8    | 조사                 | O      |      |
| 9    | 감탄사               | O      |      |
| 10   | 관사(article)        |        | O    |
| 11   | 전치사(preposition)  |        | O    |
| 12   | 접속사(conjunction)  |        | O    |
| 13   | 감탄사(Interjection) | O      | O    |

간단히 품사별로 예시를 들어보면 아래와 같다.

- 명사 : 명사는 사람이나 사물의 이름을 나타낸 단어이다. 
  - 보통명사 : 가구, 가방, 가요, 가정 ...
  - 고유명사 : 강원도, 경기도, 경상도, 독일, 러시아, 인천공학, 캐나다, ...
  - 의존명사 : 것, 곳, 녀석, 대로, 동(건물), 중(도중), ...
  - 단위 명사 : 가지(단위), 달러, 도(온도), 미터, ...
- 대명사 : 거기, 그곳, 너희, 누구, 당신, 무엇, 어느덧, 어디, 언제, 얼마, 이곳, 이분, ...
- 수사 : 수사는 사물의 수량이나 순서를 나타내는 단어이다.
  - 하나, 둘, 셋, 백, 수천, 아홉, 오홉째, 억, ...
- 동사 : 동사는 문장 주체의 움직이나 가정을 나타낸다.
  - 감동하다, 가사하다, 걸리다, 거어가다, ....
  - 자동사 : 감동사하다, 감사하다, 근무하다, 기억나다, 긴장하다, 길어지다, 깨지다, 꺼지다, 끊어지다, 늘다, ...
  - 타동사 : 가르치다, 가리다, 가져오다, 가지다, 갈아입다, 그만두다, 그만하다, 금지하다, 넘어가다, ...
- 형용사 : 성질이나 상태는 나타낸다.
  - 본현용사 : 가깝다, 가난하다, 가늘하다, 가능하다, 가볍다, ...
  - 보조형용사 : 듯하다, 싶다.
- 관형사 : 체언이나 체언 구실을 하는 말 앞에 놓여 그 내용을 꾸며주는 단어이다.
  - 각, 그, 그런, 내(나의), 네(너의), 만(나이), 첫, 한(500명), ....
- 부사 : 용언이나 문장을 꾸며주는 단어이다. 부사는 용언인 동사나 형용사, 명사, 관형사, 부사를 꾸며 준다.
  - 가까이, 가끔, 가득, 가만히, 각각, 각자, 간단히, 굉장히, 그리고, 금방, 다행히, 단순히, 대체로, 더욱, ...
- 감탄사 : 말하는 사람의 느낌이나 놀람을 나타내는 단어이다.
  - 그래, 그럼, 글쎄, 아, 아니, 아니요, 아이고, 안녕, 야, 어머, 여보, 여보세요, 예, 와, 응, 자, ...



한국어의 품사는 문장 내 역할에 따라 `체언`, `관계언`, `용언`, `수식언`, `독립언`으로 나뉜다.

| 순서 | 품사명 | 역할 기준 |
| ---- | ------ | --------- |
| 1    | 명사   | 체언      |
| 2    | 대명사 | 체언      |
| 3    | 수사   | 체언      |
| 4    | 조사   | 관계언    |
| 5    | 동사   | 용언      |
| 6    | 형용사 | 용언      |
| 7    | 관형사 | 수식언    |
| 8    | 부사   | 수식언    |
| 9    | 감탄사 | 독립언    |

`체언`은 주어나 목적어 등으로 쓰이는 단어를 체언이라 한다. 체언은 명사, 대명사, 수사 세가지가 있으며 형태 변화가 없는 특징이 있다. `용언`은 문장의 주어를 서술하는 기능 말이다. `용언`은 크게 동사와 형용사로 나뉜다. 용언은 문장에서 서술어로 쓰이지만, 문장 쓰임에 따라 형태가 바뀔 수 있다. 용언의 어간에 다양한 어미를 붙여 문법적 기능을 바꿀 수 있다. 예를 들어 기본형 `먹다`에서 `먹-`은 어간이고 `-다`는 어미이다. 어간인 `먹-`은 고정된 상태에서 어미를 변경해 문법적의미를 더해줄 수 있다. (예) 먹+다, 먹+고, 먹+으니, 먹+었다, 먹+겠다.  `수식언`은 다른 말을 수식하는 기능을 가진 단어이다. 수식어에는 관형사와 부사가 있다. `관계언`은 다른 말과의 관계를 표시하는 역할을 한다. 관계언으로 조사가 있다. 독립어에는 감탄사가 있다. `감탄사`는 문장 속의 다른 성분에 얽메이지 않고 독립성이 있다. 감탄사는 용언과 달리 형태가 변하지 않고, 조사가 붙지 않는다. 예를 들어 감정 감탄사 어머나, 아이고, 아뿔사에 조사를 붙이면 어색해진다. 단어의 형태의 변경 유무는 두가지로 구분된다.



- 단어 형태가 변함 : 용언, 서술격 조사
- 단어 형태가 변하지 않음 : 체언, 수식언, 독립언, 관계언



### 영어의 품사 태그셋

영어에서 사용하는 품사 태그셋으로 [펜 트리뱅크 태그셋](https://www.ling.upenn.edu/courses/Fall_2003/ling001/penn_treebank_pos.html)(**Penn Treebank tagset**)이 널리 알려져 있다. 펜 트리뱅크 태그셋은 NLTK 라이브러에서 품사 태깅시 사용한다. NLTK에서 사용하는 품사는 마지막 열에 사용 유무를 별도 표기해 두었다.

| 순서 | 품사 태그 | 설명                                   | 예시                                    | NLTK |
| ---- | --------- | -------------------------------------- | --------------------------------------- | ---- |
| 1    | CC        | coordinating conjunction               | and                                     | O    |
| 2    | CD        | cardinal number                        | 1, third                                | O    |
| 3    | DT        | determiner                             | the                                     | O    |
| 4    | EX        | existential there                      | there is                                | O    |
| 5    | FW        | foreign word                           | les                                     | O    |
| 6    | IN        | preposition, subordinating conjunction | in, of, like                            | O    |
| 7    | IN/that   | that as subordinator                   | that                                    |      |
| 8    | JJ        | adjective                              | green                                   | O    |
| 9    | JJR       | adjective, comparative                 | greener                                 | O    |
| 10   | JJS       | adjective, superlative                 | greenest                                | O    |
| 11   | LS        | list marker                            | 1)                                      | O    |
| 12   | MD        | modal                                  | could, will                             | O    |
| 13   | NN        | noun, singular or mass                 | table                                   | O    |
| 14   | NNS       | noun plural                            | tables                                  | O    |
| 15   | NP        | proper noun, singular                  | John                                    | O    |
| 16   | NPS       | proper noun, plural                    | Vikings                                 | O    |
| 17   | PDT       | predeterminer                          | both the boys                           | O    |
| 18   | POS       | possessive ending                      | friend’s                                | O    |
| 19   | PP        | personal pronoun                       | I, he, it                               | O    |
| 20   | PP$       | possessive pronoun                     | my, his                                 | O    |
| 21   | RB        | adverb                                 | however, usually, naturally, here, good | O    |
| 22   | RBR       | adverb, comparative                    | better                                  | O    |
| 23   | RBS       | adverb, superlative                    | best                                    | O    |
| 24   | RP        | particle                               | give up                                 | O    |
| 25   | SENT      | Sentence-break punctuation             | . ! ?                                   |      |
| 26   | SYM       | Symbol                                 | / [ = *                                 |      |
| 27   | TO        | infinitive ‘to’                        | togo                                    | O    |
| 28   | UH        | interjection                           | uhhuhhuhh                               | O    |
| 29   | VB        | verb be, base form                     | be                                      | O    |
| 30   | VBD       | verb be, past tense                    | was, were                               | O    |
| 31   | VBG       | verb be, gerund/present participle     | being                                   | O    |
| 32   | VBN       | verb be, past participle               | been                                    | O    |
| 33   | VBP       | verb be, sing. present, non-3d         | am, are                                 | O    |
| 34   | VBZ       | verb be, 3rd person sing. present      | is                                      | O    |
| 35   | VH        | verb have, base form                   | have                                    |      |
| 36   | VHD       | verb have, past tense                  | had                                     |      |
| 37   | VHG       | verb have, gerund/present participle   | having                                  |      |
| 38   | VHN       | verb have, past participle             | had                                     |      |
| 39   | VHP       | verb have, sing. present, non-3d       | have                                    |      |
| 40   | VHZ       | verb have, 3rd person sing. present    | has                                     |      |
| 41   | VV        | verb, base form                        | take                                    |      |
| 42   | VVD       | verb, past tense                       | took                                    |      |
| 43   | VVG       | verb, gerund/present participle        | taking                                  |      |
| 44   | VVN       | verb, past participle                  | taken                                   |      |
| 45   | VVP       | verb, sing. present, non-3d            | take                                    |      |
| 46   | VVZ       | verb, 3rd person sing. present         | takes                                   |      |
| 47   | WDT       | wh-determiner                          | which                                   | O    |
| 48   | WP        | wh-pronoun                             | who, what                               | O    |
| 49   | WP$       | possessive wh-pronoun                  | whose                                   | O    |
| 50   | WRB       | wh-abverb                              | where, when                             | O    |
| 51   | #         | #                                      | #                                       |      |
| 52   | $         | $                                      | $                                       |      |
| 53   | “         | Quotation marks                        | ‘ “                                     |      |
| 54   | ````      | Opening quotation marks                | ‘ “                                     |      |
| 55   | (         | Opening brackets                       | ( {                                     |      |
| 56   | )         | Closing brackets                       | ) }                                     |      |
| 57   | ,         | Comma                                  | ,                                       |      |
| 58   | :         | Punctuation                            | – ; : — …                               |      |



### 한국어의 품사 태그셋

널리 알려진 세종 품사 태그 셋과 mecab 품사 태그셋의 정리는 다음과 같다.

| 품사        | 세종 품사 태그 | 설명                                                         | Me cab 품사 태그 | 설명                              |
| ----------- | -------------- | ------------------------------------------------------------ | ---------------- | --------------------------------- |
| 체언        | NNG            | 일반 명사                                                    | NNG              | 일반 명사                         |
|             | NNP            | 고유 명사                                                    | NNP              | 고유 명사                         |
|             | NNB            | 의존 명사                                                    | NNB<br/>NNBC     | 의존 명사<br/>단위 명사           |
|             | NR             | 수사                                                         | NR               | 수사                              |
|             | NP             | 대명사                                                       | NP               | 대명사                            |
| 용언        | VV             | 동사                                                         | VV               | 동사                              |
|             | VA             | 형용사                                                       | VA               | 형용사                            |
|             | VX             | 보조 용언                                                    | VX               | 보조 용언                         |
|             | VCP            | 긍정 지정사                                                  | VCP              | 긍정 지정사                       |
|             | VCN            | 부정 지정사                                                  | VCN              | 부정 지정사                       |
| 관형사      | MM             | 관형사                                                       | MM               | 관형사                            |
| 부사        | MAG            | 일반 부사                                                    | MAG              | 일반 부사                         |
|             | MAJ            | 접속 부사                                                    | MAJ              | 접속 부사                         |
| 감탄사      | IC             | 감탄사                                                       | IC               | 감탄사                            |
| 조사        | JKS            | 주격 조사                                                    | JKS              | 주격 조사                         |
|             | JKC            | 보격 조사                                                    | JKC              | 보격 조사                         |
|             | JKG            | 관형격 조사                                                  | JKG              | 관형격 조사                       |
|             | JKO            | 목적격 조사                                                  | JKO              | 목적격 조사                       |
|             | JKB            | 부사격 조사                                                  | JKB              | 부사격 조사                       |
|             | JKV            | 호격 조사                                                    | JKV              | 호격 조사                         |
|             | JKQ            | 인용격 조사                                                  | JKQ              | 인용격 조사                       |
|             | JX             | 보조사                                                       | JX               | 보조사                            |
|             | JC             | 접속 조사                                                    | JC               | 접속 조사                         |
| 선어말 어미 | EP             | 선어말 어미                                                  | EP               | 선어말 어미                       |
| 어말 어미   | EF             | 종결 어미                                                    | EF               | 종결 어미                         |
|             | EC             | 연결 어미                                                    | EC               | 연결 어미                         |
|             | ETN            | 명사형 전성 어미                                             | ETN              | 명사형 전성 어미                  |
|             | ETM            | 관형형 전성 어미                                             | ETM              | 관형형 전성 어미                  |
| 접두사      | XPN            | 체언 접두사                                                  | XPN              | 체언 접두사                       |
| 접미사      | XSN            | 명사 파생 접미사                                             | XSN              | 명사 파생 접미사                  |
|             | XSV            | 동사 파생 접미사                                             | XSV              | 동사 파생 접미사                  |
|             | XSA            | 형용사 파생 접미사                                           | XSA              | 형용사 파생 접미사                |
| 어근        | XR             | 어근                                                         | XR               | 어근                              |
| 부호        | SF             | 마침표, 물음표, 느낌표                                       | SF               | 마침표, 물음표, 느낌표            |
|             | SE             | 줄임표                                                       | SE               | 줄임표 …                          |
|             | SS             | 따옴표, 괄호표, 줄표                                         | SSO<br/>SSCSY    | 여는 괄호 (, [<br/>닫는 괄호 ), ] |
|             | SP             | 쉼표, 가운뎃점, 콜론, 빗금                                   | SC               | 구분자 , · / :                    |
|             | SO<br/>SW      | 붙임표 (물결, 숨김, 빠짐)<br/>기타기호 (논리 수학 기호, 화폐기호) | SY               |                                   |
| 기타        | SL             | 외국어                                                       | SL               | 외국어                            |
|             | SH             | 한자                                                         | SH               | 한자                              |
|             | SN             | 숫자                                                         | SN               | 숫자                              |



