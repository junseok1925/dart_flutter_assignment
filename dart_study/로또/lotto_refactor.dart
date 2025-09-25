import 'dart:math';

// 랜덤 로또 번호를 생성하는 함수
Set<int> randomLottoNumbers(int cnt) {
  var random = Random();
  Set<int> numbers = {};
  while (numbers.length < cnt) {
    numbers.add(random.nextInt(45) + 1);
  }
  return numbers;
}

// 당첨번호와 랜덤 로또 번호를 비교해서 맞춘 번호를 반환하는 함수
List<int> matchNumbers(Set<int> myNum, Set<int> prizeNum) {
  return myNum
      .intersection(prizeNum)
      .toList(); // intersection : Map() 메서드, 교집합을 구함
}

// matchNumbers 함수 결과에 따라 맞춘 번호 갯수대로 등수(랭크)를 반환하는 함수
String lottoRank(List<int> matchNum) {
  switch (matchNum.length) {
    case 6:
    case 5:
      return '1등';
    case 4:
      return '2등';
    case 3:
      return '3등';
    default:
      return '당첨 실패';
  }
}

void main() {
  // 당첨 번호
  Set<int> prizeNum = {9, 19, 29, 35, 37, 38};
  // 중복없는 랜덤 번호 randomLottoNumbers 함수 매개변수에 '6'(인자) 전달
  Set<int> myNum = randomLottoNumbers(6);

  print("발급한 로또 번호: ${myNum.toList()}");

  List<int> matchNum = matchNumbers(myNum, prizeNum);
  print("맞춘 번호: $matchNum");

  String rank = lottoRank(matchNum);
  print("당첨 여부 : $rank");

  // 당첨 실패 시 발급한 로또 초기화
  if (rank == '당첨 실패') {
    myNum.clear();
    print("현재 발급한 로또 번호 : ${myNum.toList()}");
  }
}
