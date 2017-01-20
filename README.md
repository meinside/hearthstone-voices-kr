# hearthstone-voices-kr

하스스톤 카드 음성 (한국어) 파일명별 정리

* 최종 추출일: 2017-01-17

## 정리한 방법

추출된 하스스톤의 카드 음성 파일들을

`0_fill_txt.rb` 스크립트를 통해

재생 - 듣기 - 받아적기하여 .sqlite 파일에 저장함.

이후 .sqlite 파일을 직접 수정한 뒤 `1_sqlite_to_csv.rb` 파일로 .csv 파일을 생성하거나,

.csv 파일을 직접 수정한 뒤 `1_csv_to_sqlite.rb` 파일로 .sqlite 파일을 생성함.

## 음성 추출 방법

[이 가이드](http://www.inven.co.kr/board/powerbbs.php?come_idx=3559&l=6846) 참고하여

### Unity Assets Bundle Extractor 다운로드,

[요기](https://7daystodie.com/forums/showthread.php?22675-Unity-Assets-Bundle-Extractor)에 있는 파일 다운, 설치하여 실행,

### 해당 하스스톤 파일 추출,

추출하여 나온 .wav 파일들을 ffmpeg 등을 이용, 원하는 포맷으로 변환.

(내 경우엔 .m4a로)

## 정리된 DB를 이용, 추출된 음성파일에 활용

### 파일명 변환하기

`2_rename_voices.rb` 파일을 이용해 알아보기 쉬운 파일명으로 변환 가능.

먼저 .m4a로 변환된 파일들을 `sounds` 폴더에 복사해둔 뒤,

`2_rename_voices.rb`를 실행하면

`sounds_renamed` 폴더에 알아보기 쉬운 파일명으로 복사됨.

### 음성 검색, 조회 등에 사용하기

생성된 .sqlite 및 .csv 파일을 개발에 활용.

## TODOs

- [ ] 빠진 카드 확장팩 구분, 카드명 채워넣기
- [ ] 오타 수정
- [ ] 새 확장팩/모험 있을 때마다 추가

## 도움!

빠진 카드명 등을 직접 .sqlite 또는 .csv에 채워넣어 주시면 반영하겠습니다.

