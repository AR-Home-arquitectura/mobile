import 'package:arhome/items_upload_screen.dart';
import 'package:arhome/models/item.model.dart';
import 'package:arhome/pages/shopping-cart.page.dart';
import 'package:arhome/widgets/item-card.widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user.provider.dart';
import '../utils/roles.enum.dart';

class ProductsTable extends StatefulWidget {
  const ProductsTable({Key? key}) : super(key: key);

  @override
  State<ProductsTable> createState() => _ProductsTableState();
}

class _ProductsTableState extends State<ProductsTable> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A171B),
        automaticallyImplyLeading: false,
        title: Image.asset(
          'assets/images/arhome-icon.png',
          width: 120,
          fit: BoxFit.contain,
        ),
        actions: [
          userProvider.currentUser?.role == Roles.OWNER ? IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => ItemsUploadScreen()));
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ) : const SizedBox.shrink(),
          IconButton(
            onPressed: () {
              // AGREGAR ROUTER
            },
            icon: const Icon(
              Icons.notifications_active_outlined,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => ShoppingCartPage()));
            },
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("items")
            .orderBy("publishedDate", descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot dataSnapshot) {
          if (dataSnapshot.hasData) {
            return ListView.builder(
              itemCount: (dataSnapshot.data!.docs.length / 2).ceil(),
              itemBuilder: (context, index) {
                int firstItemIndex = index * 2;
                int secondItemIndex = firstItemIndex + 1;

                return Row(
                  children: [
                    Expanded(
                      child: firstItemIndex < dataSnapshot.data!.docs.length
                          ? ItemCard(item: ItemModel.fromJson(dataSnapshot.data!.docs[firstItemIndex].data() as Map<String, dynamic>))
                          : SizedBox.shrink(),
                    ),
                    Expanded(
                      child: secondItemIndex < dataSnapshot.data!.docs.length
                          ? ItemCard(item: ItemModel.fromJson(dataSnapshot.data!.docs[secondItemIndex].data() as Map<String, dynamic>))
                          : SizedBox.shrink(),
                    ),
                  ],
                );
              },
            );
          } else {
            return const Center(
              child: Text(
                "Data is not available.",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.grey,
                ),
              ),
            );
          }
        },
      ),

    );
  }
}
