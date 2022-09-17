---
title: "NLP 데이터셋 소개(SQuAD, KoQuAD, KLUE)"
date: 2020-02-10T23:38:39+03:00
draft: false
---

### SQuAD

최근에는 기계 독해를 평가하기 위한 SQuAD(The Stanford Question Answering Dataset)와 같은 위키피디아 기반 데이터 셋이 있다. 이 데이터셋은 기계 독해 알고리즘을 객관적으로 평가할 수 있는 `벤치마크` 데이터 셋으로 알고리즘의 우수성을 평가하기 위해 리더 보드를 운영하고 있다. 전체 데이터셋의 사이이즈는 학습셋=[40MB](https://rajpurkar.github.io/SQuAD-explorer/dataset/train-v2.0.json), 개발셋=[4MB](https://rajpurkar.github.io/SQuAD-explorer/dataset/dev-v2.0.json)정도이다.

- https://rajpurkar.github.io/SQuAD-explorer/

SQuAD 2.0 데이터 셋의 구조는 다음과 같다.

```
{
  "version": "v2.0", // SQuAD 버전 정보
  "data": [
    {
      "title": "Normans", // 출처 문서의 제목
      "paragraphs": [
        {
          "qas": [
            {
              "question": "In what country is Normandy located?", // 질문
              "id": "56ddde6b9a695914005b9628",  // 질문 id
              "answers": [
                {
                  "text": "France", // 답변 텍스트
                  "answer_start": 159 // 지문에서의 답변 위치(offset 기준)
                },
                {
                  "text": "France",
                  "answer_start": 159
                }
              ],
              "is_impossible": false  // 정답이 있는 질문은 true, 없는 질문은 false
            }
          ]
        },
        {
          "context": "The Normans (Norman: Nourmands; French: Normands; Latin: Normanni) were the people who in the 10th and 11th centuries gave their name to Normandy ...."
        }
      ]
    }
  ]
}
```

실재 Dev Set v2.0에 포함된 `id=56ddde6b9a695914005b9628`의 예시는 아래와 같다.

```
{
  "version": "v2.0",
  "data": [
    {
      "title": "Normans",
      "paragraphs": [
        {
          "qas": [
            {
              "question": "In what country is Normandy located?",
              "id": "56ddde6b9a695914005b9628",
              "answers": [
                {
                  "text": "France",
                  "answer_start": 159
                },
                {
                  "text": "France",
                  "answer_start": 159
                },
                {
                  "text": "France",
                  "answer_start": 159
                },
                {
                  "text": "France",
                  "answer_start": 159
                }
              ],
              "is_impossible": false
            },
            {
              "question": "When were the Normans in Normandy?",
              "id": "56ddde6b9a695914005b9629",
              "answers": [
                {
                  "text": "10th and 11th centuries",
                  "answer_start": 94
                },
                {
                  "text": "in the 10th and 11th centuries",
                  "answer_start": 87
                },
                {
                  "text": "10th and 11th centuries",
                  "answer_start": 94
                },
                {
                  "text": "10th and 11th centuries",
                  "answer_start": 94
                }
              ],
              "is_impossible": false
            },
            {
              "question": "From which countries did the Norse originate?",
              "id": "56ddde6b9a695914005b962a",
              "answers": [
                {
                  "text": "Denmark, Iceland and Norway",
                  "answer_start": 256
                },
                {
                  "text": "Denmark, Iceland and Norway",
                  "answer_start": 256
                },
                {
                  "text": "Denmark, Iceland and Norway",
                  "answer_start": 256
                },
                {
                  "text": "Denmark, Iceland and Norway",
                  "answer_start": 256
                }
              ],
              "is_impossible": false
            },
            {
              "question": "Who was the Norse leader?",
              "id": "56ddde6b9a695914005b962b",
              "answers": [
                {
                  "text": "Rollo",
                  "answer_start": 308
                },
                {
                  "text": "Rollo",
                  "answer_start": 308
                },
                {
                  "text": "Rollo",
                  "answer_start": 308
                },
                {
                  "text": "Rollo",
                  "answer_start": 308
                }
              ],
              "is_impossible": false
            },
            {
              "question": "What century did the Normans first gain their separate identity?",
              "id": "56ddde6b9a695914005b962c",
              "answers": [
                {
                  "text": "10th century",
                  "answer_start": 671
                },
                {
                  "text": "the first half of the 10th century",
                  "answer_start": 649
                },
                {
                  "text": "10th",
                  "answer_start": 671
                },
                {
                  "text": "10th",
                  "answer_start": 671
                }
              ],
              "is_impossible": false
            },
            {
              "plausible_answers": [
                {
                  "text": "Normans",
                  "answer_start": 4
                }
              ],
              "question": "Who gave their name to Normandy in the 1000's and 1100's",
              "id": "5ad39d53604f3c001a3fe8d1",
              "answers": [],
              "is_impossible": true
            },
            {
              "plausible_answers": [
                {
                  "text": "Normandy",
                  "answer_start": 137
                }
              ],
              "question": "What is France a region of?",
              "id": "5ad39d53604f3c001a3fe8d2",
              "answers": [],
              "is_impossible": true
            },
            {
              "plausible_answers": [
                {
                  "text": "Rollo",
                  "answer_start": 308
                }
              ],
              "question": "Who did King Charles III swear fealty to?",
              "id": "5ad39d53604f3c001a3fe8d3",
              "answers": [],
              "is_impossible": true
            },
            {
              "plausible_answers": [
                {
                  "text": "10th century",
                  "answer_start": 671
                }
              ],
              "question": "When did the Frankish identity emerge?",
              "id": "5ad39d53604f3c001a3fe8d4",
              "answers": [],
              "is_impossible": true
            }
          ],
          "context": "The Normans (Norman: Nourmands; French: Normands; Latin: Normanni) were the people who in the 10th and 11th centuries gave their name to Normandy, a region in France. They were descended from Norse (\"Norman\" comes from \"Norseman\") raiders and pirates from Denmark, Iceland and Norway who, under their leader Rollo, agreed to swear fealty to King Charles III of West Francia. Through generations of assimilation and mixing with the native Frankish and Roman-Gaulish populations, their descendants would gradually merge with the Carolingian-based cultures of West Francia. The distinct cultural and ethnic identity of the Normans emerged initially in the first half of the 10th century, and it continued to evolve over the succeeding centuries."
        }
      ]
    }
  ]
}
```



### KoQuAD

KoQuAD(The Korean Question Answering Dataset)는 LG CNS가 공개한 Machine Reading Comprehension 데이터셋 이다. 현재는 koQuAD 2.0 버전이 공개 되었다. koQuAD 2.0은 질문답변 2만 쌍을 포함한 총 10만쌍 이상 규모이다. 이들 질문답변 쌍을 수집하기 위해 한국어 위키피디아 페이지 뷰 15만건과 임로 선된 5만의 문서를 수집이 되었다. 태그의 텍스트를 추출하였고 답변은 크라우드 소싱 방식으로 8만쌍이 태깅 되어 있다. 그리고 2만 쌍은 korQuAD 1.0으로 부터 변환 되었다.

- https://korquad.github.io/

실재 dev 버전의 예시는 다음과 같다.

```
{
   "version":"KorQuAD_v1.0_dev",
   "data":[
      {
         "paragraphs":[
            {
               "qas":[
                  {
                     "answers":[
                        {
                           "text":"1989년 2월 15일",
                           "answer_start":0
                        }
                     ],
                     "id":"6548850-0-0",
                     "question":"임종석이 여의도 농민 폭력 시위를 주도한 혐의로 지명수배 된 날은?"
                  },
                  {
                     "answers":[
                        {
                           "text":"임수경",
                           "answer_start":125
                        }
                     ],
                     "id":"6548850-0-1",
                     "question":"1989년 6월 30일 평양축전에 대표로 파견 된 인물은?"
                  },
                  {
                     "answers":[
                        {
                           "text":"1989년",
                           "answer_start":0
                        }
                     ],
                     "id":"6548853-0-0",
                     "question":"임종석이 여의도 농민 폭력 시위를 주도한 혐의로 지명수배된 연도는?"
                  },
                  {
                     "answers":[
                        {
                           "text":"학생회관 건물 계단",
                           "answer_start":365
                        }
                     ],
                     "id":"6548853-0-1",
                     "question":"임종석을 검거한 장소는 경희대 내 어디인가?"
                  },
                  {
                     "answers":[
                        {
                           "text":"서울지방경찰청 공안분실",
                           "answer_start":457
                        }
                     ],
                     "id":"6548853-0-2",
                     "question":"임종석이 조사를 받은 뒤 인계된 곳은 어딘가?"
                  },
                  {
                     "answers":[
                        {
                           "text":"임종석",
                           "answer_start":87
                        }
                     ],
                     "id":"6332405-0-0",
                     "question":"1989년 2월 15일 여의도 농민 폭력 시위를 주도한 혐의로 지명수배된 사람의 이름은?"
                  },
                  {
                     "answers":[
                        {
                           "text":"여의도 농민 폭력 시위",
                           "answer_start":13
                        }
                     ],
                     "id":"6332405-0-1",
                     "question":"임종석이 1989년 2월 15일에 지명수배 받은 혐의는 어떤 시위를 주도했다는 것인가?"
                  }
               ],
               "context":"1989년 2월 15일 여의도 농민 폭력 시위를 주도한 혐의(폭력행위등처벌에관한법률위반)으로 지명수배되었다. 1989년 3월 12일 서울지방검찰청 공안부는 임종석의 사전구속영장을 발부받았다. 같은 해 6월 30일 평양축전에 임수경을 대표로 파견하여 국가보안법위반 혐의가 추가되었다. 경찰은 12월 18일~20일 사이 서울 경희대학교에서 임종석이 성명 발표를 추진하고 있다는 첩보를 입수했고, 12월 18일 오전 7시 40분 경 가스총과 전자봉으로 무장한 특공조 및 대공과 직원 12명 등 22명의 사복 경찰을 승용차 8대에 나누어 경희대학교에 투입했다. 1989년 12월 18일 오전 8시 15분 경 서울청량리경찰서는 호위 학생 5명과 함께 경희대학교 학생회관 건물 계단을 내려오는 임종석을 발견, 검거해 구속을 집행했다. 임종석은 청량리경찰서에서 약 1시간 동안 조사를 받은 뒤 오전 9시 50분 경 서울 장안동의 서울지방경찰청 공안분실로 인계되었다."
            },
            {
               "qas":[
                  {
                     "answers":[
                        {
                           "text":"허영",
                           "answer_start":100
                        }
                     ],
                     "id":"6548850-1-0",
                     "question":"정부의 헌법개정안 준비 과정에 대해서 청와대 비서실이 아니라 국무회의 중심으로 이뤄졌어야 했다고 지적한 원로 헌법학자는?"
                  },
                  {
                     "answers":[
                        {
                           "text":"10차 개헌안 발표",
                           "answer_start":77
                        }
                     ],
                     "id":"6548850-1-1",
                     "question":"'행보가 비서 본연의 역할을 벗어난다', '장관들과 내각이 소외되고 대통령비서실의 권한이 너무 크다'는 의견이 제기된 대표적인 예는?"
                  },
                  {
                     "answers":[
                        {
                           "text":"제89조",
                           "answer_start":192
                        }
                     ],
                     "id":"6332405-1-0",
                     "question":"국무회의의 심의를 거쳐야 한다는 헌법 제 몇 조의 내용인가?"
                  },
                  {
                     "answers":[
                        {
                           "text":"허영",
                           "answer_start":100
                        }
                     ],
                     "id":"6332405-1-1",
                     "question":"법무부 장관을 제쳐놓고 민정수석이 개정안을 설명하는 게 이해가 안 된다고 지적한 경희대 석좌교수 이름은?"
                  }
               ],
               "context":"내각과 장관들이 소외되고 대통령비서실의 권한이 너무 크다.."
            }
         ],
         "title":"임종석"
      }
   ]
}
```



### KLUE

[KLUE](https://github.com/KLUE-benchmark/KLUE)(Korean Langauge Understanding Evaluation)는 한국어 NLP를 위한 벤치마크 데이터셋 입니다. 한국어 언어 모델를 평가할 수 있는 표준 셋 구축을 목표로 개발 됐다. KLUE 벤치마크 데이터셋은 8개의 주제로 분류된 데이터셋이다.

| 셋 주제            | 약어                                       |
| ------------------ | ------------------------------------------ |
| 주제 분류          | Topic Classification (TC)                  |
| 문장 텍스트 유사성 | Sentence Textual Similarity (STS)          |
| 자연어 추론        | Natural Language Inference (NLI)           |
| 개체명 인식        | Named Entity Recognition (NER)             |
| 관계 추출          | Relation Extraction (RE)                   |
| 의존 구문 분석     | (Part-Of-Speech) + Dependency Parsing (DP) |
| 기계독해           | Machine Reading Comprehension (MRC)        |
| 대화 상태 추적     | Dialogue State Tracking (DST)              |

이중 KLUE의 기계 독해 관련한 학습 데이터 셋은 답변이 포함된 지문(Context)과 질문(Question)과 답변(Answer)로 구성된다. 기계 독해 셋의 경우 한국어 위키피디아에서 기본적으로 수집을 하였고, 한국 경제 신문(https://www.hankyung.com/)과 ACROFAN(https://kr.acrofan.com/) 을 출처로 두고 있고, 특정 목적(학습)으로 사용이 가능한 크레이에이티브 커먼즈 라이선스( `CC BY-SA `)로 계약이 체결되었다. KLUE에서 구축한 기계 독해 벤치마크 데이터셋의 [예시](https://raw.githubusercontent.com/KLUE-benchmark/KLUE/main/klue_benchmark/klue-mrc-v1/klue-mrc-v1_dev.json)는 다음과 같다.

```
{
   "title":"노란우산공제 소득공제 계속 받는다",
   "paragraphs":[
      {
         "context":"노란우산공제 부금에 대한 소득공제 혜택이 계속 유지된다. 노란우산공제는 소기업·소상공인들을 위한 노후 퇴직 대비용 보험상품으로, 부금 한도도 월 70만원에서 100만원으로 늘어날 전망이다.5일 중소기업중앙회와 기획재정부에 따르면 국회는 지난 1일 열린 본회의에서 이 같은 내용을 담고 있는 조세특례제한법 개정안을 처리했다.정부는 지난해 8월 발표한 세제 개편안에서 노란우산공제 부금도 소득공제에서 세액공제 항목(12%)으로 바꾼다는 방침을 밝혔으나, 국회 논의 과정에서 이 상품이 소기업·소상공인들의 생활 안정과 퇴직에 필수적인 상품이라는 점을 인정받아 계속 부금에 대한 소득공제 혜택을 유지키로 결정됐다. 노란우산공제 상품 가입자는 월 5만~70만원씩 부금을 넣을 수 있고, 부금에 대해 연 300만원까지 소득공제 혜택을 받고 있다. 또 공제상품 부금에 대해서는 파산 시에도 압류 대상에서 제외된다.정부는 이달 중 시행령을 고쳐 공제부금 불입한도도 현행 월 70만원에서 100만원으로 확대할 계획으로 알려졌다. 중기중앙회 관계자는 “교육비나 의료비 연금저축 등 수많은 소득공제 항목이 세액공제 대상으로 바뀌어 혜택이 줄게 됐지만 노란우산공제의 경우는 혜택이 오히려 늘게 됐다”며 “가입 확대를 위한 노력을 더욱 배가하겠다”고 말했다.2007년 도입한 노란우산공제에는 지난해 말 현재 총 37만9000명의 소기업·소상공인들이 가입해 1조7160억원의 부금을 조성했다.",
         "qas":[ // 질문과 태깅된 답변 정보
            {
               "question":"이달 중 수정될 시행령에 나올 공제부금의 월 납부한도는 얼마인가?",
               "answers":[
                  {
                     "text":"100만원",
                     "answer_start":488
                  }
               ],
               "question_type":1,
               "is_impossible":false,
               "guid":"klue-mrc-v1_dev_01862"
            }
         ]
      }
   ],
   "news_category":"중기 의료",
   "source":"hankyung"
}
```

KLUE의 기계 독해 벤치마크셋은 SQuAD 2.0의 구조를 따르고 있지만, `news_category`와 `source`와 같이 신규 속성을 포함하고 있다.



### WikiQA Corpus

이 코퍼스는 대중적으로 이용가능한 질의 응답 쌍의 코퍼스이다. 오픈 도메인 질의 응답 연구에 사용할 수 있다.



### 참고

- [1] KLUE: Korean Language Understanding Evaluation, https://arxiv.org/pdf/2105.09680.pdf
