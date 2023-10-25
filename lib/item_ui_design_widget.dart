import 'package:arhome/item_details_screen.dart';
import 'package:arhome/items.dart';
import 'package:flutter/material.dart';


class ItemUIDesignWidget extends StatefulWidget
{
  Items? itemsInfo;
  BuildContext? context;

  ItemUIDesignWidget({
    this.itemsInfo,
    this.context,
  });

  @override
  State<ItemUIDesignWidget> createState() => _ItemUIDesignWidgetState();
}




class _ItemUIDesignWidgetState extends State<ItemUIDesignWidget>
{
  @override
  Widget build(BuildContext context)
  {
    return InkWell(
      onTap: ()
      {
        //enviar al usuario a la pantalla de detalles
        Navigator.push(context, MaterialPageRoute(builder: (c)=> ItemDetailsScreen(
          clickedItemInfo: widget.itemsInfo,
        )));
      },
      splashColor: Colors.purple,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: SizedBox(
          height: 180,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [

              //image
              Image.network(
                widget.itemsInfo!.itemImage.toString(),
                width: 140,
                height: 140,
              ),

              const SizedBox(width: 4.0,),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),

                    //item name
                    Expanded(
                      child: Text(
                        widget.itemsInfo!.itemName.toString(),
                        maxLines: 2,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                    ),

                    //seller name
                    Expanded(
                      child: Text(
                        widget.itemsInfo!.sellerName.toString(),
                        maxLines: 2,
                        style: const TextStyle(
                          color: Colors.pinkAccent,
                          fontSize: 14,
                        ),
                      ),
                    ),


                    Row(
                      children: [

                        //50% de descuento
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.pink,
                          ),
                          alignment: Alignment.topLeft,
                          width: 40,
                          height: 44,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [

                                Text(
                                  "50%",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),

                                Text(
                                  "OFF",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),

                        const SizedBox(
                          width: 10,
                        ),


                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            //Precio Original
                            Row(
                              children: [
                                const Text(
                                  "Precio Original: \$",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                Text(
                                  (double.parse(widget.itemsInfo!.itemPrice!) + double.parse(widget.itemsInfo!.itemPrice!)).toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            ),

                            //nuevo precio
                            Row(
                              children: [
                                const Text(
                                  "Nuevo Precio: ",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                const Text(
                                  "\$",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.red,
                                  ),
                                ),
                                Text(
                                  widget.itemsInfo!.itemPrice.toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),

                      ],
                    ),

                    const SizedBox(
                      height: 8.0,
                    ),

                    const Divider(
                      height: 4,
                      color: Colors.white70,
                    ),

                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
