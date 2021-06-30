import 'package:flutter/material.dart';
import 'package:shop_around_me/tcc/core/config.dart';
import 'package:shop_around_me/tcc/home/button_tab.dart';


class Home extends StatefulWidget {
  static const String id = "tcchome";
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: Footer(),
          appBar: AppBar(
            actions: [
              IconButton(icon: Icon(Icons.person), onPressed: () {})],
            centerTitle: true,
            title: SizedBox(
              height: SizeConfig.toolBarHeight,
              child: Text("Image"),
            ),
          ),
          body: ListView(
            children: [
              Container(
                child: Column(
                  children: [
                    
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,

                ),
              )
            ],
          ),
          ),
    );
  }
}
