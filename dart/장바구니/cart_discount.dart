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
