import 'dart:math';

void main() {
  // 당첨 번호
  List<int> prizeNum = [9, 19, 29, 35, 37, 38];
  // 중복없는 내 로또 번호
  List<int> myNum = [];
  // 당첨된 번호
  List<int> matchNum = [];

  var randomInt = Random().nextInt;

  // 중복없는 로또 번호 6개 발급
  while (myNum.length < 6) {
    int num = randomInt(45) + 1;
    if (!myNum.contains(num)) {
      myNum.add(num);
    }
  }

  // 당첨 번호와 비교
  for (var num in myNum) {
    if (prizeNum.contains(num)) {
      matchNum.add(num);
    }
  }

  print("발급한 로또 번호: ${myNum.toList()}");

  if (matchNum.length >= 5) {
    print('당첨 여부 : 1등');
  } else if (matchNum.length == 4) {
    print('당첨 여부 : 2등');
  } else if (matchNum.length == 3) {
    print('당첨 여부 : 3등');
  } else {
    print('당첨 여부 : 당첨 실패');
    myNum.clear();
    print('현재 발급한 로또 번호 : $myNum');
  }
}
