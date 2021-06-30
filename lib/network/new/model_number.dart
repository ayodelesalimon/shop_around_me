import 'package:shop_around_me/network/new/no_model.dart';

class Network {
  List<Map> getAll() => _networkDetails;

 

  getLocalByState(String name) => _networkDetails
      .map((map) => StateModel.fromJson(map))
      .where((item) => item.name == name)
      .map((item) => item.lines)
      .expand((i) => i)
      .toList();



  List<String> getStates() => _networkDetails
      .map((map) => StateModel.fromJson(map))
      .map((item) => item.name)
      .toList();

  List _networkDetails = [
    {
      "name": "Airtel",
      "img": "images/airtel.png",
      "lines": [
        "08024",
        "08021",
     
      ]
    },
     {
      "name": "Glo",
      "img": "images/glo.png",
      "lines": [
        "0805",
        "0807",
     
      ]
    },
     {
      "name": "MTN",
      "img": "images/mtn.png",
      "lines": [
        "0803",
        "0806",
     
      ]
    },
  ];
}
