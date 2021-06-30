import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_around_me/models/shopping.dart';
import 'package:shop_around_me/providers/shopping_list.dart';
import 'package:shop_around_me/widgets/form_shop.dart';

class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String details = '';
  String price = '';
  int pricee;

  @override
  Widget build(BuildContext context) => AlertDialog(
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Item',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 8),
              TodoFormWidget(
                onChangedPrice: (price) => setState(() {
                  pricee = int.tryParse(price);
                  print(price);
                }),
                onChangedTitle: (title) => setState(() => this.title = title),
                onChangedDescription: (description) =>
                    setState(() => this.details = description),
                onSavedTodo: addTodo,
              ),
            ],
          ),
        ),
      );
  void addTodo() {
    final isValid = _formKey.currentState.validate();

    if (!isValid) {
      return;
    } else {
      final shopList = ShoopingModel(
        title: title,
        details: details,
        price: pricee,
      );

      final provider = Provider.of<ShoppingList>(context, listen: false);
      provider.addShoppingList(shopList);

      Navigator.of(context).pop();
    }
  }
}
