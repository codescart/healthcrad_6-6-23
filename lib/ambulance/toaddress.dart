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


class toaddress extends StatefulWidget {
  final String fromadd;
  final String from_lat;
  final String from_lan;
   toaddress({ required this.fromadd, required this.from_lat, required this.from_lan});

  @override
  State<toaddress> createState() => _toaddressState();
}
var lat;
var lan;
class _toaddressState extends State<toaddress> {

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
    _defaultLatLng = LatLng(26.863565451414225, 80.92618718047001);
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
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomButton(
                    radius: 0,
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ambulance_booking(fromaddress: widget.fromadd,
                        toaddress:_draggedAddress,
                        from_lat: widget.from_lat,
                        to_lat:lat.toString().toString(),
                        to_lan: lan.toString(),
                        from_lon: widget.from_lan,)));
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>ambulance_booking(
                      //     add:_draggedAddress
                      // )));
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
    );;
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
      language: 'in',
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
