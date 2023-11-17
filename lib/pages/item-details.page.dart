import 'dart:ffi';

import 'package:arhome/models/item.model.dart';
import 'package:arhome/services/shopping-cart.service.dart';
import 'package:arhome/virtual_ar_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user.provider.dart';

class ItemDetailsPage extends StatefulWidget
{
  ItemModel? clickedItemInfo;

  ItemDetailsPage({super.key, this.clickedItemInfo,});

  @override
  State<ItemDetailsPage> createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage>
{


  @override
  Widget build(BuildContext context)
  {
    final userProvider = context.watch<UserProvider>();
    final ShoppingCartService cartService = ShoppingCartService();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          widget.clickedItemInfo!.itemName.toString(),
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.orange,
        onPressed: () async {
            final userId = userProvider.currentUser?.id;
            final itemId = widget.clickedItemInfo?.itemID;

            if (userId != null && itemId != null) {
                await cartService.addToCart(userId, itemId);
            }
        },
        label: const Text(
          "AGREGAR AL CARRITO",
        ),
        icon: const Icon(
          Icons.shopping_cart,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 400,
                child: Align(
                  alignment: Alignment.center,
                  child: Image.network(
                    widget.clickedItemInfo!.itemImage.toString(),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text(
                    widget.clickedItemInfo!.itemName.toString(),
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white70,
                    ),
                  ),
                  const Spacer(),
                  FloatingActionButton.extended(
                    backgroundColor: Colors.pinkAccent,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (c) => VirtualARViewScreen(
                            clickedItemImageLink: widget.clickedItemInfo!.itemImage.toString(),
                          ),
                        ),
                      );
                    },
                    label: const Text("Vista AR", style: TextStyle(color: Colors.white),),
                    icon: const Icon(
                      Icons.mobile_screen_share_rounded,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 6.0),
                child: Text(
                  widget.clickedItemInfo!.itemDescription.toString(),
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    color: Colors.white54,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "S/. ${widget.clickedItemInfo!.itemPrice}",
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.white70,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8.0, right: 310.0),
                child: Divider(
                  height: 1,
                  thickness: 2,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
