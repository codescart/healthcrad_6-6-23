import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:healthcrad_user/Components/custom_button.dart';
import 'package:healthcrad_user/ambulance/ambulance_booking.dart';
import 'package:healthcrad_user/ambulance/searchlocation.dart';
import 'package:lottie/lottie.dart';

class add_address extends StatefulWidget {
  final String toadd;
  final String tolat;
  final String tolan;
  add_address({required this.toadd, required this.tolat, required this.tolan});

  @override
  State<add_address> createState() => _add_addressState();
}
var lat;
var lan;

final customTheme = ThemeData(
  primarySwatch: Colors.blue,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.blue,
    brightness: Brightness.dark,
    accentColor: Colors.redAccent,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4.00)),
    ),
    contentPadding: EdgeInsets.symmetric(
      vertical: 12.50,
      horizontal: 10.00,
    ),
  ),
);


class _add_addressState extends State<add_address> {

  Completer<GoogleMapController> _googleMapController = Completer();
  CameraPosition? _cameraPosition;
  late LatLng _defaultLatLng;
  late LatLng _draggedLatlng;
  String _draggedAddress = "";

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() {
    _defaultLatLng = LatLng(27.30719348056138, 81.12317457050531);
    _draggedLatlng = _defaultLatLng;
    _cameraPosition = CameraPosition(
        target: _defaultLatLng,
        zoom: 13.5
    );
    _gotoUserCurrentPosition();
  }
  Mode _mode = Mode.overlay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.chevron_left)),
        centerTitle: true,
        title: Text(
          "Add Address",
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        textTheme: Theme.of(context).textTheme,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                    height: MediaQuery.of(context).size.height*0.7,
                    child: _buildBody()
                ),
                Positioned(
                  top: 10,
                  child: InkWell(
                    onTap: (){
                      _handlePressButton();
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>doctor_search()));
                    },
                    child: Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width/1.1,
                      padding: EdgeInsets.only(left: 10, right: 10),
                      margin: EdgeInsets.only(left: 15, right: 15),
                      // padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0,2),
                              color: Colors.grey.shade600.withOpacity(0.6),
                              spreadRadius: 0, blurRadius: 3
                          )
                        ],
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Search", style: TextStyle(color: Colors.black, fontSize: 18, ),),
                          Icon(Icons.search, size: 25, color: Colors.black,)
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 22),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 19,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Text(
                            _draggedAddress,
                            maxLines: 3,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomButton(
                    radius: 0,
                    onTap: () {
                      print(lat);
                      print(lan);
                      print(_draggedAddress);
                      print("lat lan yaha hai");
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ambulance_booking(
                        fromaddress:_draggedAddress,
                        toaddress: widget.toadd,
                        from_lat:lat.toString(),
                        from_lon:lan.toString(),
                        to_lat: widget.tolat, to_lan: widget.tolan,
                      )));
                    },
                    label: "Save address",
                    color: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildBody() {
    return Stack(
        children : [
          _getMap(),
          _getCustomPin(),
        ]
    );
  }

  Widget _getMap() {
    return GoogleMap(
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      zoomGesturesEnabled: true,
      myLocationButtonEnabled: false,
      initialCameraPosition: _cameraPosition!, //initialize camera position for map
      mapType: MapType.normal,
      onCameraIdle: () {
        _getAddress(_draggedLatlng);
      },
      onCameraMove: (cameraPosition) {
        _draggedLatlng = cameraPosition.target;
      },
      onMapCreated: (GoogleMapController controller) {
        if (!_googleMapController.isCompleted) {
          _googleMapController.complete(controller);
        }
      },
    );
  }

  Widget _getCustomPin() {
    return Center(
      child: Container(
        width: 150,
        child: Lottie.asset("assets/pin.json"),
      ),
    );
  }

  Future _getAddress(LatLng position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark address = placemarks[0]; // get only first and closest address
    String addresStr = "${address.street}, ${address.locality}, ${address.administrativeArea}, ${address.country}";
    setState(() {
      lat=position.latitude;
      lan=position.longitude;
      _draggedAddress = addresStr;
    });
  }

  //get user's current location and set the map's camera to that location
  Future _gotoUserCurrentPosition() async {
    Position currentPosition = await _determineUserCurrentPosition();
    _gotoSpecificPosition(LatLng(currentPosition.latitude, currentPosition.longitude));
    print("aaaaaaaaaaaaassssssssssssssssss");
    lat=currentPosition.latitude.toString();
    lan=currentPosition.longitude.toString();
    print(currentPosition.latitude);
    print(currentPosition.latitude);
  }

  //go to specific position by latlng
  Future _gotoSpecificPosition(LatLng position) async {
    GoogleMapController mapController = await _googleMapController.future;
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: position,
            zoom: 13.5
        )
    ));
    //every time that we dragged pin , it will list down the address here
    await _getAddress(position);
  }

  Future _determineUserCurrentPosition() async {
    LocationPermission locationPermission;
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    //check if user enable service for location permission
    if(!isLocationServiceEnabled) {
      print("user don't enable location permission");
    }

    locationPermission = await Geolocator.checkPermission();

    //check if user denied location and retry requesting for permission
    if(locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if(locationPermission == LocationPermission.denied) {
        print("user denied location permission");
      }
    }

    //check if user denied permission forever
    if(locationPermission == LocationPermission.deniedForever) {
      print("user denied permission forever");
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
  }

  Future<void> _handlePressButton() async {
    void onError(PlacesAutocompleteResponse response) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.errorMessage ?? 'Unknown error'),
        ),
      );
    }

    // show input autocomplete with selected mode
    // then get the Prediction selected
    final p = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      onError: onError,
      mode: _mode,
      language: 'fr',
      components: [Component(Component.country, 'in')],
      // TODO: Since we supports Flutter >= 2.8.0
      // ignore: deprecated_member_use
      resultTextStyle: Theme.of(context).textTheme.subtitle1,
    );

    await displayPrediction(p, ScaffoldMessenger.of(context));
  }
  Future<void> displayPrediction(Prediction? p, ScaffoldMessengerState messengerState) async {
    if (p == null) {
      return;
    }
    // get detail (lat/lng)
    final _places = GoogleMapsPlaces(
      apiKey: kGoogleApiKey,
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );

    final detail = await _places.getDetailsByPlaceId(p.placeId!);
    final geometry = detail.result.geometry!;
    final let = geometry.location.lat;
    final lgn = geometry.location.lng;
    setState(() {
      lat = let;
      lan = lgn;
      _draggedAddress='${p.description}';
    });
    print(lat);
    print(lan);
    print("pani puri yaha hai");
    // messengerState.showSnackBar(
    //   SnackBar(
    //     content: Text('${p.description} - $lat/$lan'),
    //   ),
    // );
  }
}
