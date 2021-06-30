import 'dart:async';

import "package:flutter/material.dart";
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'package:shop_around_me/providers/app_data.dart';
import 'package:shop_around_me/screens/search.dart';
import 'package:shop_around_me/screens/shopping/shopping_list.dart';
import 'package:shop_around_me/util/http_method.dart';
import 'package:shop_around_me/widgets/divider.dart';
import 'package:shop_around_me/widgets/drawer.dart';

class Home extends StatefulWidget {
  static const String id = "home";
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GoogleMapController mapController;
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GlobalKey<ScaffoldState> scaffoldDrawer = GlobalKey<ScaffoldState>();

  Set<Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];

  Position currentPosition;
  String address = "yu";
  var geolocator = Geolocator();
  double bottomPaddingMap = 0;

  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition =
        CameraPosition(target: latPosition, zoom: 14);
    mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    String address =
        await AssistMethod.searchCordinateAddress(position, context);

    print(address);
  }

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _controllerGoogleMap.complete(controller);

    setState(() {
      bottomPaddingMap = 280.0;
    });
    locatePosition();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          key: scaffoldDrawer,
          // appBar: AppBar(
          //   title: Text('Maps Sample App'),
          //   backgroundColor: Colors.green[700],
          // ),
          drawer: DrawerWidget(),
          body: Stack(
            children: [
              GoogleMap(
                polylines: polylines,
                padding: EdgeInsets.only(bottom: bottomPaddingMap),
                mapType: MapType.normal,
                myLocationButtonEnabled: true,
                onMapCreated: _onMapCreated,
                myLocationEnabled: true,
                zoomGesturesEnabled: true,
                zoomControlsEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),
              ),

              //drawer

              Positioned(
                top: 25.0,
                left: 22.0,
                child: GestureDetector(
                  onTap: () {
                    scaffoldDrawer.currentState.openDrawer();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black,
                              blurRadius: 6.0,
                              spreadRadius: 0.5,
                              offset: Offset(0.7, 0.7)),
                        ]),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.menu,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0.0,
                right: 0.0,
                bottom: 0.0,
                child: Container(
                  height: Provider.of<AppData>(context).searchLocation != null
                      ? 320
                      : 280,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 6.0),
                        Text(
                          "Hi, There, ",
                          style: TextStyle(fontSize: 25.0),
                        ),
                        Text(
                          "Wanna Shop ? ",
                          style: TextStyle(fontSize: 20.0),
                        ),
                        SizedBox(height: 20.0),
                        GestureDetector(
                          onTap: () async {
                            var res = await Navigator.push(
                              context,
                              PageRouteBuilder(
                                  pageBuilder: (context, _, __) => SearchMap()),
                            );

                            if (res != null) {
                              await getPlaceDirection();
                            }
                          },
                          child: Container(
                            height: 50.0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.search,
                                    color: Colors.yellowAccent,
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text('Search Store'),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 15.0,
                                  color: Colors.black54,
                                  spreadRadius: 0.5,
                                  offset: Offset(0.7, 0.7),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.home,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 12.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(Provider.of<AppData>(context)
                                            .currentLocation !=
                                        null
                                    ? Provider.of<AppData>(context)
                                        .currentLocation
                                        .placeName
                                    : "Add Home"),
                                SizedBox(
                                  height: 4.0,
                                ),
                                Text(
                                  " Your living home address",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12.0),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.work,
                              color: Colors.grey,
                            ),
                            DividerWidget(),
                            SizedBox(
                              width: 12.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(Provider.of<AppData>(context)
                                            .searchLocation !=
                                        null
                                    ? Provider.of<AppData>(context)
                                        .searchLocation
                                        .placeName
                                    : "Store Address"),
                                SizedBox(
                                  height: 4.0,
                                ),
                                Text(
                                  " Your office address",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12.0),
                                ),
                              ],
                            )
                          ],
                        ),
                        Provider.of<AppData>(context).searchLocation != null
                            ? Expanded(
                                child: Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, Shopping.id);
                                    },
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: Colors.greenAccent),
                                      child: Center(
                                        child: Text(
                                          "Shop Now",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 16.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Text("")
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getPlaceDirection() async {
    var intialPos =
        Provider.of<AppData>(context, listen: false).currentLocation;
    var finalPos = Provider.of<AppData>(context, listen: false).searchLocation;

    var pickUpLagLat = LatLng(intialPos.latitude, intialPos.longitude);
    var serchUpLagLat = LatLng(finalPos.latitude, finalPos.longitude);

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

    var details = await AssistMethod.obtainPlaceDirectionsDetails(
        pickUpLagLat, serchUpLagLat);

    // Navigator.pop(context);

    // print("this is endcoded");
    // print(details.encodedPoints);

    // PolylinePoints polyLinePoints = PolylinePoints();
    // List<PointLatLng> decodePolyline =
    //     polyLinePoints.decodePolyline(details.encodedPoints);
    // polylines.clear();
    // if (decodePolyline.isNotEmpty) {
    //   decodePolyline.forEach((PointLatLng pointLatLng) {
    //     polylineCoordinates
    //         .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
    //   });
    // }

    // polylines.clear();
    // setState(() {
    //   Polyline polyline = Polyline(
    //       polylineId: PolylineId("PolylineID"),
    //       jointType: JointType.round,
    //       points: polylineCoordinates,
    //       width: 5,
    //       startCap: Cap.roundCap,
    //       endCap: Cap.roundCap,
    //       geodesic: true);

    //   polylines.add(polyline);
    // });
  }
}
