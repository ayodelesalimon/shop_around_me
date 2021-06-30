import 'package:flutter/material.dart';
import 'package:shop_around_me/network/number.dart';

class Show extends StatefulWidget {
  static const String id = "show";
  @override
  _ShowState createState() => _ShowState();
}

class _ShowState extends State<Show> {
  List<NetworkDetails> network = NetworkDetails.people();
  List<DropdownMenuItem<NetworkDetails>> dropdownMenuItems;
  NetworkDetails selectedNetworkDetails;

  @override
void initState() {
  dropdownMenuItems = buildDropdownMenuItems(network);
  selectedNetworkDetails = dropdownMenuItems[0].value;
  super.initState();
}
 
List<DropdownMenuItem<NetworkDetails>> buildDropdownMenuItems(List companies) {
  List<DropdownMenuItem<NetworkDetails>> items = [];
  for (NetworkDetails networkk in network) {
    items.add(
      DropdownMenuItem(
        value: networkk,
        child: Text(networkk.networkName),
      ),
    );
  }
  return items;
}
onChangeDropdownItem(NetworkDetails selectedNetworkDetail) {
  setState(() {
    selectedNetworkDetails = selectedNetworkDetail;
  });
}
  String dropdownValue = "First";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Select a Network"),
              SizedBox(
                height: 20.0,
              ),
              DropdownButton(
                value: selectedNetworkDetails,
                items: dropdownMenuItems,
                onChanged: onChangeDropdownItem,
              ),
              SizedBox(
                height: 20.0,
              ),
              
              Text('Selected: ${selectedNetworkDetails.number.length}'),
            ],
          ),
        ),
      ),
    
    );
  }
}
