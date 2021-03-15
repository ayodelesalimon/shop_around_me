import 'package:flutter/material.dart';

class ShoppingList extends StatefulWidget {
    static const   String id = "shopping";
  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  @override
  Widget build(BuildContext context) {
  
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text("Shooping list Yeah."),
        ),
      ),
    );
  }
}
