import 'package:animate_do/animate_do.dart';
import 'package:arhome/models/item.model.dart';
import 'package:flutter/material.dart';

import '../pages/item-details.page.dart';
import '../utils/human-formats.dart';


class ItemCard extends StatelessWidget {

  final ItemModel item;

  const ItemCard({
    super.key,
    required this.item
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                item.itemImage,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ));
                  }

                  return GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c)=> ItemDetailsPage(
                        clickedItemInfo: item,
                      ))),
                      child: FadeIn(child: child));
                },
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            width: 150,
            child: Text(
              item.sellerName.toUpperCase(),
              maxLines: 1,
              style: textStyle.titleSmall?.copyWith(
                color: const Color(0xFFA4A4A4),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            width: 150,
            child: Text(
              item.itemDescription,
              maxLines: 2,
              style: textStyle.titleSmall,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            width: 150,
            child: Text(
              HumanFormats.number(double.parse(item.itemPrice)),
              style: textStyle.bodyLarge,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            width: 150,
            child: Text(
              item.status,
              style: textStyle.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}