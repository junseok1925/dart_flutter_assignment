import 'dart:math';

// 로또 번호 생성 함수
Set<int> randomLottoNumbers(int cnt) {
  var random = Random();
  Set<int> numbers = {};

  while (numbers.length < cnt) {
    numbers.add(random.nextInt(15) + 1);
  }

  return numbers;
}

// 당첨 번호와 비교
List<int> matchNumbers(Set<int> myNum, Set<int> prizeNum) {
  return myNum.intersection(prizeNum).toList();
}

// 등수 판정
String lottoRank(int matchNum) {
  if (matchNum == 6) {
    return '1등';
  } else if (matchNum == 5) {
    return '1등';
  } else if (matchNum == 4) {
    return '2등';
  } else if (matchNum == 3) {
    return '3등';
  } else {
    return '당첨 실패';
  }
}

void main() {
  Set<int> prizeNum = {1, 2, 3, 10, 11, 13}; // 당첨번호
  int tryCnt = 0; // 시도횟수

  // 1등될때까지 반복
  while (true) {
    tryCnt++;

    Set<int> myNum = randomLottoNumbers(6);
    List<int> matchNum = matchNumbers(myNum, prizeNum);
    String result = lottoRank(matchNum.length);

    print(
      "[$tryCnt] 발급 번호: ${myNum.toList()} → 맞춘 번호: $matchNum → 결과: $result",
    );
    // "1등"이면 종료
    if (result == '1등') {
      print("1등 당첨@!@!@!@! 총 $tryCnt 번 시도했습니다.");
      break;
    }
  }
}
