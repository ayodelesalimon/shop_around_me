import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_around_me/models/place_prediction.dart';
import 'package:shop_around_me/providers/app_data.dart';
import 'package:shop_around_me/util/newkey.dart';
import 'package:shop_around_me/util/request_http.dart';
import 'package:shop_around_me/widgets/divider.dart';
import 'package:shop_around_me/widgets/prediction_tile.dart';

class SearchMap extends StatefulWidget {
  @override
  _SearchMapState createState() => _SearchMapState();
}

class _SearchMapState extends State<SearchMap> {
  TextEditingController searchMapContoller = TextEditingController();
  TextEditingController searchInMapContoller = TextEditingController();
  List<PlacePredictions> placePredictionList = [];
  @override
  Widget build(BuildContext context) {
    String placeAddres =
        Provider.of<AppData>(context).currentLocation.placeName ?? "";
    searchInMapContoller.text = placeAddres;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: 250.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 15.0,
                    color: Colors.black,
                    spreadRadius: 0.5,
                    offset: Offset(0.7, 0.7),
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: searchInMapContoller,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintText: 'Address',
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 7.0,
                          horizontal: 15.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: TextFormField(
                      onChanged: (val) {
                        findPlace(val);
                      },
                      keyboardType: TextInputType.emailAddress,
                      controller: searchMapContoller,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintText: 'Search Store',
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 7.0,
                          horizontal: 15.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            (placePredictionList.length > 0
                ? Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                    child: ListView.separated(
                      itemCount: placePredictionList.length,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      separatorBuilder: (BuildContext context, int index) => DividerWidget(),
                      padding: EdgeInsets.all(5.0),
                      itemBuilder: (context, index) {
                        return PredictionTile(
                          placePredictions: placePredictionList[index],
                        );
                        
                      },
                    ),
                  )
                : Container())
          ],
        ),
      ),
    );
  }

  void findPlace(String placeName) async {
    if (placeName.length > 1) {
      String autoComplete =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&types=address&components=country:ng&key=$apiKey&sessiontoken=1234567890'";

      var res = await RequestAssistant.getRequest(autoComplete);
      if (res == "failed") {
        return;
      }
      if (res["status"] == "OK") {
        var predictions = res["predictions"];

        var placeList = (predictions as List)
            .map((e) => PlacePredictions.fromJson(e))
            .toList();
        setState(() {
          placePredictionList = placeList;
        });
      }
    }
  }
}
