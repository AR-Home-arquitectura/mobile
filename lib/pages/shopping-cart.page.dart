/*class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({super.key});

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final shoppingCartService = context.watch<ShoppingCartService>();

    final List<ShoppingItemToRender> cartItems;
    cartItems = shoppingCartService.getCartItems(userProvider!.currentUser!.id!) as List<ShoppingItemToRender>;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito de Compras'),
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final cartItem = cartItems[index];
          return ShoppingItemWidget(cartItem: cartItem);
        },
      ),
    );
  }
}*/

import 'package:arhome/models/item.model.dart';
import 'package:arhome/services/shopping-cart.service.dart';
import 'package:arhome/virtual_ar_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/shpping-item-to-render.model.dart';
import '../providers/user.provider.dart';
import '../widgets/shpping-item.widget.dart';

class ShoppingCartPage extends StatefulWidget {
  ItemModel? clickedItemInfo;

  ShoppingCartPage({super.key, this.clickedItemInfo,});

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final ShoppingCartService cartService = ShoppingCartService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito de Compras'),
      ),
      body: FutureBuilder<List<ShoppingItemToRender>>(
        future: cartService.getCartItems(userProvider!.currentUser!.id!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('El carrito está vacío.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final cartItem = snapshot.data![index];
                return ShoppingItemWidget(cartItem: cartItem);
              },
            );
          }
        },
      ),
    );
  }
}
