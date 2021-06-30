import 'package:flutter/material.dart';
import 'package:shop_around_me/network/new/model_number.dart';

class ShowNet extends StatefulWidget {
  static const id = 'ShowNetee';
  @override
  _ShowNetState createState() => _ShowNetState();
}

class _ShowNetState extends State<ShowNet> {
  Network netw = Network();
  List<String> name = ["Choose a network"];
  List<IconData> img = [
    Icons.ac_unit_outlined,
    Icons.home,
    Icons.access_time_outlined

  ];


  int num = 0;
  String imgMe;

  //List<String> images = ['images/airtel.png'];
  IconData selectIcon;
  List<String> lines = [];
  List<String> news = [];
  String selectedState = "Choose a Network";
  String selectedLGA;
  String ayo;

  @override
  void initState() {
    name = List.from(name)..addAll(netw.getStates());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (num) {
      case 0:
        
    }
    return Scaffold(
        // appBar: AppBar(
        //   actions: [
        //     Icon(Icons.info),
        //   ],
        //   title: Text("SHOW MY NETWORK"),
        //   elevation: 0.1,
        // ),
        body: SafeArea(
            child: Container(
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Show My Network',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.search),
              Icon(Icons.info),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text('Select a Network'),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                items: name.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: 
                          
                          Icon(img[1]),
                        ),
                        Text(dropDownStringItem),
                      ],
                    ),
                  );
                }).toList(),
                hint: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Icon(selectIcon ?? name.toList()[name.length]),
                    ),
                    Text(selectedState ?? name.toList()[name.length]),
                  ],
                ),
                onChanged: (value) => onSelectedState(value),
                value: selectedState,
              ),
            ),
          ),

          // DropdownButton<String>(
          //   isExpanded: true,
          //   items: lines.map((String dropDownStringItem) {
          //     return DropdownMenuItem<String>(
          //       value: dropDownStringItem,
          //       child: Container(
          //           decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(5.0)),
          //           child: Text(dropDownStringItem)),
          //     );
          //   }).toList(),
          // onChanged: (value) => print(value),
          //   onChanged: (value) => onSelectedLGA(value),
          //   value: selectedLGA,
          // ),

          // Text(ayo),
          Container(
            height: 90,
            child: ListView.builder(
                itemCount: news.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(news[index]),
                    leading: Icon(selectIcon),
                  );
                }),
          ),
        ],
      ),
    )));
  }

  void onSelectedState(String value) {
    setState(() {
      selectedLGA = "Choose ..";
      lines = [];
      selectedState = value;
      // imgMe = value;
      lines = List.from(lines)..addAll(netw.getLocalByState(value));
      //ayo = jsonEncode(lines);

      ayo = lines.map((e) => e.trim()).join(',');
      news = ayo.split(',');
      selectIcon = img[news.length];
    });
  }

  void onSelectedLGA(String value) {
    setState(() => selectedLGA = value);
  }
}
