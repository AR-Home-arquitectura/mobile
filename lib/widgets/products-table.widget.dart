import 'package:arhome/items_upload_screen.dart';
import 'package:arhome/pages/item_ui_design_widget.dart';
import 'package:arhome/items.dart';
import 'package:arhome/models/item.model.dart';
import 'package:arhome/models/user.model.dart';
import 'package:arhome/widgets/item-card.widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user.provider.dart';

// Statefull widget
class ProductsTable extends StatefulWidget {
  const ProductsTable({Key? key}) : super(key: key);

  @override
  State<ProductsTable> createState() => _ProductsTableState();
}

// Stateless widget
class _ProductsTableState extends State<ProductsTable> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "${userProvider.currentUser.email}",
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        // Upload item button
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => ItemsUploadScreen()));
            },
            icon: const Icon(
              Icons.add,
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
            return Container(
              margin: const EdgeInsets.all(20),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Dos elementos por fila
                  crossAxisSpacing: 14, // Espacio horizontal entre elementos
                  mainAxisSpacing: 16, // Espacio vertical entre elementos
                  childAspectRatio: 0.52, // Ajusta según tus preferencias
                ),
                itemCount: dataSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  ItemModel item = ItemModel.fromJson(dataSnapshot.data!.docs[index].data() as Map<String, dynamic>);
                  return ItemCard(item: item);
                },
              ),
            );
          } else {
            // Column list added
            return const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "Data is not available.",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
