import 'package:flutter/material.dart';
import 'package:shop_around_me/models/address.dart';

class AppData extends ChangeNotifier {
  Address currentLocation, searchLocation;

  void updateCurrentLocation(Address pickUpAddress) {
    currentLocation = pickUpAddress;
    notifyListeners();
  }

  void updateSearchLocation(Address searchAddress) {
    searchLocation = searchAddress;
    notifyListeners();
  }
}
