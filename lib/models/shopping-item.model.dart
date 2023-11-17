

class ShoppingItem {
  final String userId;
  final String itemId;
  final int quantity;

  ShoppingItem({
    required this.userId,
    required this.itemId,
    required this.quantity,
  });

  factory ShoppingItem.fromJson(Map<String, dynamic> json) {
    return ShoppingItem(
      userId: json['userId'] ?? '',
      itemId: json['itemId'] ?? '',
      quantity: json['quantity'] ?? 0,
    );
  }
}