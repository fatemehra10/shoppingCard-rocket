import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Shopping card",
      home: new ShoppingList(
        products:<Products>[
          Products(name: "Eggs"),
          Products(name: "Potato"),
          Products(name: "Tomato"),
          Products(name: "Chocolate")
        ]
      ),
    );
  }

}

class Products{
  final String name ;
  Products({required this.name});
}
class ShoppingList extends StatefulWidget{
  final List<Products> products;
  ShoppingList({required this.products});
  @override
  State<StatefulWidget> createState() {
    return ShoppingListState();
  }
}
class ShoppingListState extends State<ShoppingList>{
  Set<Products> shoppingCart = new Set<Products>();

  void handlerCardChanged(Products product , bool inCart){
    setState(() {

      if(inCart){
        shoppingCart.remove(product);
      }
      else
        shoppingCart.add(product);
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Shopping card"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: new ListView(
        padding: EdgeInsets.symmetric(vertical: 8),
        children:
          widget.products.map((Products products) {
            return ShoppingListItem(
                products: products,
              onCartChanged: handlerCardChanged,
              inCart: shoppingCart.contains(products),

            );
          }).toList(),
      ),
    );
  }

}
class ShoppingListItem extends StatelessWidget {
  final Products products;
  final onCartChanged;
  final bool inCart;
  const ShoppingListItem({Key? key , required this.products , required this.inCart , this.onCartChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      leading: new CircleAvatar(
        backgroundColor: inCart ? Colors.black54 : Colors.lightBlueAccent,
        child: new Text(products.name[0], style: TextStyle(color: Colors.white)),
      ),
      title: new Text(products.name ,style: inCart ? TextStyle(decoration: TextDecoration.lineThrough):null,),
      onTap: () => onCartChanged(products , inCart),
    );
  }
}
