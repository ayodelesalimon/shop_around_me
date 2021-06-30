import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_around_me/network/new/done.dart';
import 'package:shop_around_me/network/new/show_me.dart';
import 'package:shop_around_me/network/new_show.dart';
import 'package:shop_around_me/network/show.dart';
import 'package:shop_around_me/network/yooo.dart';
import 'package:shop_around_me/providers/shopping_list.dart';
import 'package:shop_around_me/providers/app_data.dart';
//import 'package:shop_around_me/screens/home/home.dart';
import 'package:shop_around_me/screens/shopping/cart.dart';
import 'package:shop_around_me/screens/shopping/shopping_list.dart';
import 'package:shop_around_me/tcc/home/homescreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Light Theme
  final ThemeData lightTheme = ThemeData.light().copyWith(
    // Background color of the FloatingCard
    cardColor: Colors.white,
    buttonTheme: ButtonThemeData(
      // Select here's button color
      buttonColor: Colors.black,
      textTheme: ButtonTextTheme.primary,
    ),
  );

  // Dark Theme
  final ThemeData darkTheme = ThemeData.dark().copyWith(
    // Background color of the FloatingCard
    cardColor: Colors.grey,
    buttonTheme: ButtonThemeData(
      // Select here's button color
      buttonColor: Colors.yellow,
      textTheme: ButtonTextTheme.primary,
    ),
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AppData()),
       ChangeNotifierProvider.value(value: ShoppingList()),
      ],
      child: MaterialApp(
        title: 'Google Map Place Picker Demo',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        initialRoute: Home.id,

        routes: {
          //Home.id: (context) => Home(),
          Shopping.id: (context) => Shopping(),
          Cart.id: (context) => Cart(),
          Show.id: (context) => Show(),
          NewShow.id: (context) => NewShow(),
          Addoffers.id: (context) => Addoffers(),
          ShowNet.id: (context) => ShowNet(),
          MyHomePage.id: (context) => MyHomePage(),
          Home.id: (context) => Home(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

