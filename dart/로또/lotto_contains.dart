import 'dart:math';

void main() {
  Set<int> prizeNum = {9, 19, 29, 35, 37, 38};
  List<int> myNum = [];
  List<int> matchNum = [];

  var randomInt = Random().nextInt;

  while (myNum.length < 6) {
    int num = randomInt(45) + 1;
    if (!myNum.contains(num)) {
      myNum.add(num);
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
