import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class PlayBack extends StatefulWidget {
  String id;
  PlayBack({required this.id});


  @override
  _PlayBackState createState() => _PlayBackState();
}

class _PlayBackState extends State<PlayBack> {

  String apiKey = "AIzaSyBt0XXMqrIAoo-tec72ZeRgnpQF4bkm4Tw";
  String radius = "30";

  Completer<GoogleMapController> _controller = Completer();
  String _draggedAddress = "";


  CameraPosition _kGoogle = CameraPosition(
    target: LatLng(25.5878, 83.5783),
    zoom: 14,
  );

  final Set<Marker> _markers = {};
  int playspeed = 1;

  // String formatted='2023-04-11';
  @override
  void initState() {
    // TODO: implement initState
    getNearbyPolice();
    super.initState();

    // declared for loop for various locations
  }


  Uint8List? marketimages;

  // addPolyLine(List<LatLng> polylineCoordinates) {
  //   PolylineId id = PolylineId("poly");
  //   Polyline polyline = Polyline(
  //     polylineId: id,
  //     color: Colors.blue,
  //     points: polylineCoordinates,
  //     width: 6,
  //   );
  //   // polyline[id] = polyline;
  //   setState(() {});
  // }

  final Set<Polyline> _polyline = {};
// list of locations to display polylines
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};

  getDirections(driverlat, driverlon, originlat, originlong, destilat, destilong) async {



    List<LatLng> polylineCoordinates = [];

     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      apiKey,
      status == "6"? PointLatLng(driverlat, driverlon):PointLatLng(originlat, originlong),
      status=="6"? PointLatLng(originlat, originlong):PointLatLng(destilat, destilong),
      // PointLatLng(driverlat, driverlon),
      // PointLatLng(originlat, originlong),
      // PointLatLng(destilat, destilong),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude,));
      });
    } else {
    }
    addPolyLine(polylineCoordinates);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Theme.of(context).primaryColor,
      points: polylineCoordinates,
      width: 6,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  var status;

  getNearbyPolice() async {
    _markers.clear();
    polylineCoordinates.clear();

  // getNearbyPolice(String sdate, String edate, String speed, String vehiclespeed) async {
  //   Navigator.pop(context);
    GoogleMapController mapController = await _controller.future;

    BitmapDescriptor markerbitmapsp = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 20),
      "assets/banners/hospital.png",

    );
    BitmapDescriptor markerbitmapig = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 10),
      "assets/banners/patient.png",

    );
    //
    BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 15),

      "assets/banners/amb.png",

    );


    var driverlat;
    var driverlon;
    var originlat;
    var originlong;
    var destilong;
    var destilat;
    final response = await http.get(
      Uri.parse('https://app.healthcrad.com/api/index.php/api/Mobile_app/driverlatlong?bookingid='+widget.id),

    );
    final datas = jsonDecode(response.body)['data'];
    if (response.statusCode == 200) {
      driverlat = double.parse(datas["latitude"].toString());
      driverlon = double.parse(datas["logitude"].toString());
      originlat = double.parse(datas["originlatitude"].toString());
      originlong = double.parse(datas["originlongitude"].toString());
      destilat = double.parse(datas["destinationlatitude"].toString());
      destilong = double.parse(datas["destinationlogitude"].toString());
      status= datas["status"].toString();

      getDirections(driverlat,driverlon,originlat,originlong,destilat,destilong);
      setState(() {
        _markers.add(
          // added markers
            Marker(
              markerId: MarkerId('Ambulance'),
              position: LatLng(driverlat, driverlon),
              infoWindow: InfoWindow(
                title: 'Ambulance',
                snippet: 'on the way',
              ),
              icon: markerbitmap,
            ));

        _markers.add(
          // added markers
            Marker(
              markerId: MarkerId('Hospital'),
              position: LatLng(destilat, destilong),
              infoWindow: InfoWindow(
                title: 'Hospital',
                snippet: 'Complete',
              ),
              icon: markerbitmapsp,
            ));

        _markers.add(
          // added markers
            Marker(
              markerId: MarkerId('Pickup'),
              position: LatLng(originlat, originlong),
              infoWindow: InfoWindow(
                title: 'Patient Wait',
                snippet: 'now',
              ),
              icon:markerbitmapig,
            ));
      });
    } else {
    }




    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(driverlat, driverlon), zoom: 16)));


    addPolyLine(polylineCoordinates);
  }


  final CameraPosition _googlemap = CameraPosition(
      target: LatLng(
        26.921122976320326,
        80.95115617836447,
      ),
      zoom: 13.5);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   leading: IconButton(
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //     icon: Icon(Icons.arrow_back_ios_new_outlined),
        //   ),
        // ),
        floatingActionButton:InkWell(
          onTap: (){
            getNearbyPolice();
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).primaryColor
              ),
              child: Text("Refresh", style: TextStyle(color: Colors.white, fontSize: 20),)),
        ),
        // polygonLatLngs.length > 0 && _isPolygon ? _fabPolygon() : null,
        body: GoogleMap(
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            zoomGesturesEnabled: true,
            markers: _markers,
            myLocationButtonEnabled: false ,
            initialCameraPosition: _googlemap,
            polylines: Set<Polyline>.of(polylines.values),
            //_polyline,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              if (!_controller.isCompleted) {
                _controller.complete(controller);
              }
            }));
  }

  Future<Uint8List> getImages(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png)
    )!
        .buffer
        .asUint8List();
  }


}
