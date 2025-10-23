
class CartItem {
  final String id;
  final String productId;
  final String title;
  final double unitPrice;
  final String imageUrl;
  int quantity;

  CartItem({
    required this.id,
    required this.productId,
    required this.unitPrice,
    required this.quantity,
    required this.title,
    required this.imageUrl
  });

  void add() {
    quantity++;
  }

  void subtract(){
    quantity--;
  }

  get totalPrice => unitPrice * quantity; 

  Map<String, dynamic> toJson() => {
    "id": id,
    "productId": productId,
    "unitPrice": unitPrice,
    "quantity": quantity,
    "title": title,
    "imageUrl": imageUrl
  };


}