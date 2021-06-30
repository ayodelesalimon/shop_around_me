import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_around_me/models/shopping.dart';
import 'package:shop_around_me/providers/shopping_list.dart';
import 'package:shop_around_me/widgets/form_shop.dart';

class EditShop extends StatefulWidget {
  final ShoopingModel shopModel;

  const EditShop({Key key, @required this.shopModel}) : super(key: key);
  @override
  _EditShopState createState() => _EditShopState();
}

class _EditShopState extends State<EditShop> {
  final _formKey = GlobalKey<FormState>();
  int pricee;
  String title;
  String description;
  String price;
  @override
  void initState() {
    super.initState();
    price = widget.shopModel.price.toString();
    title = widget.shopModel.title;
    description = widget.shopModel.details;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Item'),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.delete),
        //     onPressed: () {
        //       final provider =
        //           Provider.of<ShoppingList>(context, listen: false);
        //       int index;
        //       provider.removeShoppingList(index);

        //       Navigator.of(context).pop();
        //     },
        //   )
        // ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: TodoFormWidget(
            price: price,
            title: title,
            description: description,
            onChangedPrice: (price) => setState(() {
               pricee = int.tryParse(price);
              print(pricee);
            }),
            onChangedTitle: (title) => setState(() => this.title = title),
            onChangedDescription: (description) =>
                setState(() => this.description = description),
            onSavedTodo: saveTodo,
          ),
        ),
      ),
    );
  }

  void saveTodo() {
    final isValid = _formKey.currentState.validate();

    if (!isValid) {
      return;
    } else {
      final provider = Provider.of<ShoppingList>(context, listen: false);

      provider.updateShoppingList(widget.shopModel, title, description, pricee);

      Navigator.of(context).pop();
    }
  }
}
