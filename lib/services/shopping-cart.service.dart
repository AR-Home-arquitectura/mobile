import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:arhome/models/item.model.dart';
import '../models/shpping-item-to-render.model.dart';
import '../widgets/toast.widget.dart';

class ShoppingCartService {
  final CollectionReference cartCollection =
  FirebaseFirestore.instance.collection('shoppingCart');

  Future<void> addToCart(String userId, String itemId) async {
    try {
      final existingCartItem = await cartCollection
          .where('userId', isEqualTo: userId)
          .where('itemId', isEqualTo: itemId)
          .get();

      if (existingCartItem.docs.isNotEmpty) {
        final existingItem = existingCartItem.docs.first;
        await existingItem.reference.update({
          'quantity': (existingItem['quantity'] ?? 0) + 1,
        });
      } else {
        await cartCollection.add({
          'userId': userId,
          'itemId': itemId,
          'quantity': 1,
        });
      }

      showToast(message: 'Product added to cart.');
    } catch(e) {
      showToast(message: 'Error while adding product.');
    }
  }

  Future<List<ShoppingItemToRender>> getCartItems(String userId) async {
    final querySnapshot =
    await cartCollection.where('userId', isEqualTo: userId).get();

    final cartItems = await Future.wait(querySnapshot.docs.map((doc) async {
      final item = await getItemById(doc['itemId']);
      return ShoppingItemToRender(
        item: item,
        quantity: doc['quantity'],
      );
    }));

    return cartItems;
  }

  Future<ItemModel> getItemById(String itemId) async {
    final itemDoc = await FirebaseFirestore.instance.collection('items').doc(itemId).get();

    if (itemDoc.exists) {
      return ItemModel.fromJson(itemDoc.data() as Map<String, dynamic>);
    } else {
      throw Exception("Item with ID $itemId not found");
    }
  }

  Future<void> updateCartItemQuantity(
      String userId, String itemId, int newQuantity) async {
    try {
      final existingCartItem = await cartCollection
          .where('userId', isEqualTo: userId)
          .where('itemId', isEqualTo: itemId)
          .get();

      if (existingCartItem.docs.isNotEmpty) {
        final existingItem = existingCartItem.docs.first;
        await existingItem.reference.update({
          'quantity': newQuantity,
        });
      } else {
        throw Exception('Item not found in cart.');
      }

      showToast(message: 'Cart updated.');
    } catch (e) {
      showToast(message: 'Error updating cart.');
    }
  }
}
