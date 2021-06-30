import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_around_me/models/shopping.dart';
import 'package:shop_around_me/providers/shopping_list.dart';
import 'package:shop_around_me/screens/shopping/cart.dart';
import 'package:shop_around_me/screens/shopping/edit_shop.dart';
import 'package:shop_around_me/widgets/add_item.dart';
import 'package:shop_around_me/widgets/drawer.dart';

class Shopping extends StatefulWidget {
  final ShoopingModel shopModel;
  static const String id = "shopping";

  const Shopping({Key key, this.shopModel}) : super(key: key);
  @override
  _ShoppingState createState() => _ShoppingState(this.shopModel);
}

class _ShoppingState extends State<Shopping> {
  final ShoopingModel shopModel;
  String codeDialog;
  String valueText;

  _ShoppingState(this.shopModel);
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShoppingList>(context);
    final shopL = provider.shopList;
    return SafeArea(
      child: Scaffold(
        drawer: DrawerWidget(),
        appBar: AppBar(
          actions: [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Container(
                height: 150.0,
                width: 30,
                color: Colors.transparent,
                child: Stack(
                  children: [
                    IconButton(
                        icon: Icon(Icons.shopping_cart),
                        onPressed: () {
                          Navigator.pushNamed(context, Cart.id);
                        }),
                    shopL.length == 0
                        ? Container()
                        : Positioned(
                            child: Stack(
                            children: [
                              Icon(
                                Icons.brightness_1,
                                size: 20.0,
                                color: Colors.green[800],
                              ),
                              Positioned(
                                  top: 3.0,
                                  right: 4.0,
                                  child: Center(
                                    child: Text(
                                      '${shopL.length.toString()}',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 11.0),
                                    ),
                                  ))
                            ],
                          ))

                    //
                  ],
                ),
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => showDialog(
            context: context,
            builder: (context) => AddItem(),
            barrierDismissible: false,
          ),
          child: Icon(Icons.add),
        ),
        //add a consumer widget with provider as the data
        body: Container(
          child: Stack(
            children: [
              Consumer<ShoppingList>(builder: (context, shop, child) {
                return shopL.isEmpty
                    ? Center(
                        child: Text("No ShopList"),
                      )
                    : ListView.builder(
                        itemCount: shop.shopList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: GestureDetector(
                              onTap: () {
                                editTodo(context, shop.shopList[index]);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Card(
                                  
                                  shadowColor: Colors.black,
                                  semanticContainer: true,
                                  elevation: 5.0,
                                  child: ListTile(
                                      // leading: IconButton(
                                      //   icon: Icon(Icons.delete),
                                      //   onPressed: () {
                                      //     Provider.of<ShoppingList>(context,
                                      //             listen: false)
                                      //         .removeShoppingList(index);
                                      //   },
                                      // ),
                                      title: Text(shop.shopList[index].title),
                                      subtitle: Text(shop.shopList[index].details),
                                      trailing: Text(
                                          "\$${shop.shopList[index].price}")),
                                ),
                              ),
                            ),
                          );
                        });
              }),
              // provider.shopList.length != 0
              //     ? Positioned(
              //         bottom: 80,
              //         right: MediaQuery.of(context).size.width / 2.5,
              //         // top: MediaQuery.of(context).size.height / 2,
              //         child: ElevatedButton(
              //           style: ButtonStyle(
              //             backgroundColor:
              //                 MaterialStateProperty.all(Colors.green),
              //           ),
              //           onPressed: null,
              //           child: Text(
              //             'Check Out',
              //             style: TextStyle(color: Colors.white),
              //           ),
              //         ),
              //       )
              //     : Text(""),
            ],
          ),
        ),
      ),
    );
  }

  void editTodo(BuildContext context, ShoopingModel shopList) =>
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EditShop(shopModel: shopList),
        ),
      );
}
