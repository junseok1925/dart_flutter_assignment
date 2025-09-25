### 1. 점수에 맞는 등급 출력하기

```dart
void main() {
  int score = 84;

  if (score < 80) {
    print("이 학생의 점수는 $score이며, 등급은 C등급.");
  } else if (score < 90) {
    print("이 학생의 점수는 $score이며, 등급은 B등급.");
  } else if (90 <= score && 100 >= score) {
    print("이 학생의 점수는 $score이며, 등급은 A등급.");
  } else {
    print("이 학생의 점수는 $score이며, 잘못된 점수.");
  }
}
```

---

### 2. 구매자가 장바구니에 담은 상품 목록을 볼 수 있는 기능

```dart
class PriceTag {
  static Map<String, int> price = {'티셔츠': 10000, '바지': 8000, '모자': 4000};
}

void main() {
  List<String> cart = ["티셔츠", "바지", "모자", "티셔츠", "바지"];
  var price = PriceTag.price;

  int totalPrice = 0;

  //   print(price['티셔츠']);

  for (var item in cart) {
    print('cart의 항목 : $item , 해당 항목의 가격 : ${price[item]}');
    totalPrice +=  price[item]; // 오류@@!@!@!@!@!@
    print('총 가격은? : $totalPrice');
  }
}

```

- 가격표(List price)에 static 속성을 주어 공통 데이터로 사용

- `for-in` 반복문으로 장바구니(cart)에 담긴 상품 요소를 하나씩 반복하여 가져옴
  (출력 : "티셔츠", "바지", "모자", "티셔츠", "바지")

- ` print('해당 항목의 가격 : ${price[i]}');` : `i`는 장바구니(cart)에 담긴 요소이므로 가격표(List price)의 key값에 해당 요소를 넣어 value를 가져옴
  (출력 : 해당 항목의 가격 : 10000...)

#### **오류 발단**

- `totalPrice = totalPrice + price[i];` 이 부분에서
  `Error: A value of type 'num' can't be assigned to a variable of type 'int'` type에러가 발생
- 번역해보니, `main.dart:17:29: 오류: 'num' 유형의 값을 'int' 유형의 변수에 할당할 수 없습니다.` `int totalPrice = 0;` int 타입으로 선언하였으나 typeError 발생

#### **원인 분석**

- 오류 메시지를 보내고 해석해보니
- `num` -> 숫자 타입의 부모 ( `int`, `double` 포함 ) null 아님
- 문제 원인 -> `price[i]` 의 타입이 `int?` (null 가능)
- 그래서 `int` 변수에 바로 못 넣음.

근데 나는 `price[i]` 즉 static으로 선언한 `price`리스트의 value를 `int` 타입으로 선언했는데 왜 `int?`로 인식을 하는가
-> **Dart에서 Map의 `[]` 연산자는 key가 존재하지 않으면 null을 반환**하기 때문에, 컴파일러 입장에서는 `price[i]` 타입을 **`int?`** (null 가능)로 추론한..

**따라서 Dart의 `null-safety` 로 인해 key값이 이상한 것이 들어와서 value가 null이 되는 상황을 막아야함**

#### **해결 1**

```dart
class PriceTag {
  static Map<String, int> price = {'티셔츠': 10000, '바지': 8000, '모자': 4000};
}

void main() {
  List<String> cart = ["티셔츠", "바지", "모자", "티셔츠", "바지"];
  var price = PriceTag.price;

  int totalPrice = 0;

  //   print(price['티셔츠']);

  for (var item in cart) {
    print('cart의 항목 : $item , 해당 항목의 가격 : ${price[item]}');
    totalPrice +=  price[item]!; // null이 아님을 강제로 명시
  }
}
```

- `totalPrice +=  price[i]!;` -> 해당 오류 부분에 `!` null이 아님을 강제로 알림
- 하지만, `cart`에 다른 `price`에 없는 Key값이 들어가 있으면 런타임 오류 발생

#### **해결 2**

```dart
class PriceTag {
  static Map<String, int> price = {'티셔츠': 10000, '바지': 8000, '모자': 4000};
}

void main() {
  List<String> cart = ["티셔츠", "바지", "모자", "티셔츠", "바지", "이상한것"];
  var price = PriceTag.price;

  int totalPrice = 0;

  for (var item in cart) {
    int itemPrice = price[item] ?? 0; // 병합연산자 Map에 없는 요소면 0 처리
    print('cart의 항목 : $item , 해당 항목의 가격 : ${price[item]}');

    totalPrice += itemPrice;
  }
  print('총 가격은? : $totalPrice');
}


```

- `if()` 조건문을 넣어 처음부터 `null` 인지 확인 후 동작 시킴

#### **최종 해결**

```dart
class PriceTag {
  static Map<String, int> price = {'티셔츠': 10000, '바지': 8000, '모자': 4000};
}

// cart 리스트와 price Map을 받아 총 가격 계산 함수
int PriceTotal(List<String> cart, Map<String, int> priceMap) {
  // cart, priceMap : 매개변수, cart와 PriceTag.price를 가져옴
  int totalPrice = 0;

  for (var item in cart) {
    int itemPrice = priceMap[item] ?? 0; // Map에 없으면 0 처리
    print('cart의 항목 : $item, 가격 : $itemPrice');
    totalPrice += itemPrice;
  }

  return totalPrice;
}

void main() {
  List<String> cart = ["티셔츠", "바지", "모자", "티셔츠", "바지", "양말"];
  int total = PriceTotal(cart, PriceTag.price);

  print('장바구니에 $total원 어치를 담았다.');
}
```

- 총 계산 부분을 함수화 후 고도화

---

### 3. 구매자가 결제해야 될 최종 금액을 확인하는 기능

```dart
class PriceTag {
  static Map<String, int> price = {'티셔츠': 10000, '바지': 8000, '모자': 4000};
}

// cart 리스트와 price Map을 받아 총 가격 계산 함수
int PriceTotal(List<String> cart, Map<String, int> priceMap) {
  // cart, priceMap : 매개변수, cart와 PriceTag.price를 가져옴

  int totalPrice = 0; // 장바구니 금액
  for (var item in cart) {
    int itemPrice = priceMap[item] ?? 0; // Map에 없으면 0 처리
    //     print('cart의 항목 : $item, 가격 : $itemPrice');
    totalPrice += itemPrice;
  }
  print('장바구니에 $totalPrice원 어치를 담았습니다.');

  //int finalPrice = 0; // 최종 금액 - 2만원 안넘을 시 err남
  int finalPrice = totalPrice; // 최종금액
  if (totalPrice > 20000) {
    int discount = totalPrice ~/ 10;
    print('할인 금액 : $discount원');
    finalPrice = totalPrice - discount;
  }
  return finalPrice; // 1. 최종 finalPrice 리턴
}

void main() {
  List<String> cart = ["티셔츠", "바지", "모자", "티셔츠", "바지", "양말"];
  int total = PriceTotal(cart, PriceTag.price); // 2. 최종 리턴된 총 금액을 total에 저장
  print('최종 결제 금액은 $total원 입니다.');
}
```

#### 오류발단

총 장바구니 금액 (`totalPrice`)이 2만원을 안 넘을 때 오류 발생
최종 금액이 0으로 나옴

#### **원인 분석**

`int finalPrice = 0;` 최종 금액이 초기값이 0으로 설정 되어 있음
만약 장바구니 금액이 2000원을 안넘을 경우`if (totalPrice > 20000)` 해당 조건문을 거치지 않아 생기는 오류라 분석

#### 해결

`int finalPrice = 0;` -> `int finalPrice = totalPrice;`
-> 최종 금액의 초기값을 총 장바구니 금액 (`totalPrice`) 으로 설정해서 조건문을 거치지 않게되면, 최종 금액을 총 장바구니 금액으로 지정

`finalPrice = totalPrice - discount;` -> `finalPrice -= discount;`
: 어차피 이제 `int finalPrice = totalPrice;` 이기 때문에

```dart
class PriceTag {
  static Map<String, int> price = {'티셔츠': 10000, '바지': 8000, '모자': 4000};
}

int priceTotal(List<String> cart, Map<String, int> priceMap) {
  int totalPrice = 0;

  for (var item in cart) {
    int itemPrice = priceMap[item] ?? 0;
    totalPrice += itemPrice;
  }
  print('장바구니에 $totalPrice원 어치를 담았습니다.');

  int finalPrice = totalPrice;
  if (totalPrice > 20000) {
    int discount = totalPrice ~/ 10; // 10으로 나누고 몫 반환 (int)
    print('할인 금액 : $discount원');
    finalPrice -= discount; // 최종 수정
  }

  return finalPrice;
}

void main() {
  List<String> cart = ["티셔츠", "바지", "모자", "티셔츠", "바지", "양말"];
  int total = priceTotal(cart, PriceTag.price);
  print('최종 결제 금액은 $total원 입니다.');
}

```

---

### 4. 가상의 복권 프로그램

1. Set 메서드 `intersection` (교집합) 함수 사용

```dart
import 'dart:math';

void main() {
  Set<int> prizeNum = {9, 19, 29, 35, 37, 38};
  Set<int> myNum = {};
  List<int> matchNum = [];

  var randomInt = Random().nextInt;

  while (myNum.length < 6) {
    int num = randomInt(45) + 1; // 1~45
    myNum.add(num);
  }

  print("발급한 로또 번호: ${myNum.toList()}");

  matchNum.addAll(myNum.intersection(prizeNum));

  if (matchNum.length >= 5) {
    print('당첨 여부 : 1등');
  } else if (matchNum.length == 4) {
    print('당첨 여부 : 2등');
  } else if (matchNum.length == 3) {
    print('당첨 여부 : 3등');
  } else {
    print('당첨 여부 : 당첨 실패');
    myNum.clear();
	print('현재 발급한 로또 번호 : ${myNum.toList()}');
  }
}

```

2. List 메서드 `contains`(포함 여부) 사용

```dart
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

```

- 요구하는 프로그램 출력 예시에 발급한 로또 번호를 `[]` 형태로 나오게 하고 있으므로 2번 코드가 맞을 꺼같다.
- 1번 코드에서는 출력 시 `print('현재 발급한 로또 번호 : ${myNum.toList()}');` toList() 메서드로 형 변환하여 출력되도록 하긴 했다.
