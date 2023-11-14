

class ItemModel {
  final String itemDescription;
  final String itemID;
  final String itemImage;
  final String itemName;
  final String itemPrice;
  final String sellerName;
  final String sellerPhone;
  final String status;
  final int phone;

  ItemModel(
      {required this.itemDescription,
      required this.itemID,
      required this.itemImage,
      required this.itemName,
      required this.itemPrice,
      required this.sellerName,
      required this.sellerPhone,
      required this.status,
      required this.phone});

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      itemDescription: json['itemDescription'] ?? '',
      itemID: json['itemID'] ?? '',
      itemImage: json['itemImage'] ?? '',
      itemName: json['itemName'] ?? '',
      itemPrice: json['itemPrice'] ?? '',
      sellerName: json['sellerName'] ?? '',
      sellerPhone: json['sellerPhone'] ?? '',
      status: json['status'] ?? '',
      phone: json['phone'] ?? 0,
    );
  }
}