import 'package:flutter/material.dart';
import 'package:shop_around_me/models/shopping.dart';
//add the model class to the list

class ShoppingList extends ChangeNotifier {


  int ser = 50;
  List<ShoopingModel> shopList = [
    ShoopingModel(
      title: "Bread",
      details: "I will buy",
      price: 10,
    ),
    
  ];
  List<ShoopingModel> get shops =>
      shopList.where((shopModel) => shopList.length == 0).toList();

  /// The current total price of all items.
  int get totalPrice =>
      shopList.fold(0, (total, current) => total + current.price + ser);

  // add to shoppinng list
  addShoppingList(ShoopingModel shopModel) {
    shopList.add(shopModel);
    notifyListeners();
  }

//remove from shopping list
  removeShoppingList(int index) {
    shopList.removeAt(index);
    notifyListeners();
  }

//update shopping list
  updateShoppingList(
      ShoopingModel shopModel, String title, String details, int price) {
    shopModel.title = title;
    shopModel.details = details;
    shopModel.price = price;
    notifyListeners();
  }

  
}
