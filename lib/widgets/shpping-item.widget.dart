import 'package:arhome/models/shpping-item-to-render.model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user.provider.dart';
import '../services/shopping-cart.service.dart';

class ShoppingItemWidget extends StatefulWidget {
  final ShoppingItemToRender cartItem;

  const ShoppingItemWidget({super.key, required this.cartItem});

  @override
  _ShoppingItemWidgetState createState() => _ShoppingItemWidgetState();
}

class _ShoppingItemWidgetState extends State<ShoppingItemWidget> {
  final ShoppingCartService cartService = ShoppingCartService();
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.cartItem.quantity;
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();

    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.network(
                  widget.cartItem.item.itemImage,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.cartItem.item.itemName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Vendedor: ${widget.cartItem.item.sellerName}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Precio: S/. ${widget.cartItem.item.itemPrice}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () async {
                        // Lógica para reducir la cantidad
                        int newQuantity = quantity - 1;
                        if (newQuantity > 0) {
                          await cartService.updateCartItemQuantity(
                              userProvider.currentUser!.id!,
                              widget.cartItem.item.itemID,
                              newQuantity);
                          setState(() {
                            quantity = newQuantity;
                          });
                        } else {
                          // Eliminar el artículo del carrito si la cantidad es 0
                          // Puedes implementar esto según tus necesidades
                        }
                      },
                    ),
                    Text('$quantity'),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () async {
                        // Lógica para aumentar la cantidad
                        int newQuantity = quantity + 1;
                        await cartService.updateCartItemQuantity(
                            userProvider.currentUser!.id!,
                            widget.cartItem.item.itemID,
                            newQuantity);
                        setState(() {
                          quantity = newQuantity;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


