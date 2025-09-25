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
  List<String> cart = ["티셔츠", "바지", "모자", "티셔츠", "바지"];
  int total = PriceTotal(cart, PriceTag.price);

  print('장바구니에 $total원 어치를 담았다.');
}
