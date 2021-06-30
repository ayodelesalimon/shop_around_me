import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_around_me/models/shopping.dart';
import 'package:shop_around_me/providers/shopping_list.dart';

class Cart extends StatefulWidget {
  final ShoopingModel shopModel;
  static String id = 'cart';

  const Cart({
    Key key,
    this.shopModel,
  }) : super(key: key);
  @override
  _CartState createState() => _CartState(this.shopModel);
}

class _CartState extends State<Cart> {
  var index;
  final ShoopingModel shopModel;
  _CartState(this.shopModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cart"),),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Consumer<ShoppingList>(
                builder: (context, shop, child) {
                  return 
                  shop.shopList.length == 0 ? Center(child: Text("No Item in Cart"),)
                 : ListView.builder(
                      itemCount: shop.shopList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: ListTile(
                              leading: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  Provider.of<ShoppingList>(context,
                                          listen: false)
                                      .removeShoppingList(index);
                                },
                              ),
                              title: Text(shop.shopList[index].title),
                              subtitle: Text(shop.shopList[index].details),
                              trailing: Text(
                                  "\$${shop.shopList[index].price.toInt()}")),
                        );
                      });
                },
              ),
            ),
            Divider(height: 4, color: Colors.black),
            CartTotal(),
          ],
        ),
      ),
    );
  }
}

class CartTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var hugeStyle =
        Theme.of(context).textTheme.headline1.copyWith(fontSize: 48);

    return SizedBox(
      height: 200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Another way to listen to a model's change is to include
            // the Consumer widget. This widget will automatically listen
            // to CartModel and rerun its builder on every change.
            //
            // The important thing is that it will not rebuild
            // the rest of the widgets in this build method.
            Consumer<ShoppingList>(
                builder: (context, cart, child) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            'Total: \$${context.select((ShoppingList s) => s.totalPrice)}',
                            style: hugeStyle),
                        Text("Servie charge: \$50"),
                      ],
                    )),
            SizedBox(height: 10),
            TextButton(

              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Buying not supported yet.')));

              },
              style: TextButton.styleFrom(primary: Colors.black, backgroundColor: Colors.green, padding: EdgeInsets.all(10)),
              child: Text('Place Order Now'),
            ),
          ],
        ),
      ),
    );
  }
}
