import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shop_around_me/models/address.dart';
import 'package:shop_around_me/models/direction_details.dart';
import 'package:shop_around_me/providers/app_data.dart';

import 'package:shop_around_me/util/newkey.dart';
import 'package:shop_around_me/util/request_http.dart';

class AssistMethod {
  static Future<String> searchCordinateAddress(
      Position position, context) async {
    String placeAddress = "";

    String st1, st2, st3, st4;

    String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$apiKey";

    var response = await RequestAssistant.getRequest(url);

    if (response != "Failed") {
      // placeAddress = response["results"][3]["formatted_address"];
      st1 = response["results"][0]["address_components"][1]["long_name"];
      st2 = response["results"][0]["address_components"][2]["long_name"];
   //   st3 = response["results"][0]["address_components"][4]["long_name"];
      // st4 = response["results"][0]["address_components"][5]["long_name"];

      placeAddress = st1 + ", " + st2 ;
      Address userCurrentAddress = new Address();

      userCurrentAddress.longitude = position.longitude;
      userCurrentAddress.latitude = position.latitude;
      userCurrentAddress.placeName = placeAddress;

      Provider.of<AppData>(context, listen: false)
          .updateCurrentLocation(userCurrentAddress);
    }
    return placeAddress;
  }

  static Future<DirectionDetails> obtainPlaceDirectionsDetails(
      LatLng initailPosition, LatLng finalPosition) async {
    String directionUrl =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${initailPosition.latitude},${initailPosition.longitude}&destination=${finalPosition.latitude},${finalPosition.longitude}&mode=driving&key=$apiKey";

    var res = await RequestAssistant.getRequest(directionUrl);

    print(res);

    // if (res == 'failed') {
    //   return null;
    // }
    // DirectionDetails directionDetails = DirectionDetails();

    // directionDetails.durationText = res["routes"][0]["legs"][0]["duration"]["text"];

    // directionDetails.durationValue =   res["routes"][0]["legs"][0]["duration"]["value"];

    // directionDetails.distanceText =  res["routes"][0]["legs"][0]["distance"]["text"];

    // directionDetails.distanceValue = res["routes"][0]["legs"][0]["distance"]["value"];

    //  directionDetails.encodedPoints = res["routes"][2]["overview_polyline"]['points'];

    // return directionDetails;
  }
}
