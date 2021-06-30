import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewShow extends StatefulWidget {
  static const String id = "new";

  @override
  _NewShowState createState() => _NewShowState();
}

class _NewShowState extends State<NewShow> {
  int index;
  List data;
  String _mySelection;
  Future<String> loadJsonData() async {
    var jsonText = await rootBundle.loadString('json/network.json');
    setState(() {
      data = json.decode(jsonText);
    });
  }

  @override
  void initState() {
    super.initState();
    this.loadJsonData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Items"),
        ),
        body: Column(
          children: [
            DropdownButton(
              items: data.map((item) {
                return new DropdownMenuItem(
                  child: new Text(item['Network']),
                  value: item['Number'].toString(),
                );
              }).toList(),
              onChanged: (newVal) {
                setState(() {
                  _mySelection = newVal;
                });
              },
              value: _mySelection,
            ),
          ],
        )

        // Container(
        //   child: Text(data[index]['Network']),
        // );
        // })

        //  new Center(
        //   child: new
        // ),
        );
  }
}
