import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_around_me/models/address.dart';
import 'package:shop_around_me/models/place_prediction.dart';
import 'package:shop_around_me/providers/app_data.dart';
import 'package:shop_around_me/util/newkey.dart';
import 'package:shop_around_me/util/request_http.dart';

class PredictionTile extends StatefulWidget {
  final PlacePredictions placePredictions;

  PredictionTile({Key key, this.placePredictions}) : super(key: key);

  @override
  _PredictionTileState createState() => _PredictionTileState();
}

class _PredictionTileState extends State<PredictionTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          getPlaceAdrress(widget.placePredictions.place_id, context);
        },
        child: Container(
          child: Column(
            children: [
              SizedBox(
                width: 20.0,
              ),
              Row(
                children: [
                  Icon(
                    Icons.add_location,
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 2.0,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          widget.placePredictions.main_text,
                          style: TextStyle(fontSize: 20.0),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          widget.placePredictions.secondary_text,
                          style: TextStyle(fontSize: 15.0),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                width: 14.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getPlaceAdrress(String placeId, context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => SimpleDialog(
        backgroundColor: Colors.white,
        children: <Widget>[
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Please Wait....",
                  style: TextStyle(color: Colors.black45),
                )
              ],
            ),
          )
        ],
      ),
    );
    String autoComplete =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey";

    var res = await RequestAssistant.getRequest(autoComplete);

    Navigator.pop(context);
    if (res == "failed") {
      return;
    }
    if (res["status"] == "OK") {
      Address address = Address();
      address.placeName = res["result"]["name"];
      address.placeId = placeId;
      address.latitude = res["result"]["geometry"]["location"]["lat"];
      address.longitude = res["result"]["geometry"]["location"]["lng"];

      Provider.of<AppData>(context, listen: false)
          .updateSearchLocation(address);

      print('this is drop of location');
      print(address.placeName);

     Navigator.pop(context, "obtainDirection");
    }
  }
}
