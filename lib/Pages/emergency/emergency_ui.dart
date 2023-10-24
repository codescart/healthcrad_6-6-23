import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:healthcrad_user/BottomNavigation/bottom_navigation.dart';
import 'package:healthcrad_user/ambulance/searchlocation.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:healthcrad_user/ambulance/msgtxt.dart';

class emergency extends StatefulWidget {
  const emergency({Key? key}) : super(key: key);

  @override
  State<emergency> createState() => _emergencyState();


}
var lat;
var lan;
class _emergencyState extends State<emergency> {
// get current location from map
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

  // sending sms code
  void sending_SMS(String msg, List<String> list_receipents) async {
    String send_result = await sendSMS(message: msg, recipients: list_receipents)
        .catchError((err) {
      print(err);
    });
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNavigation()));
    Fluttertoast.showToast(
        msg: "Emergency message sent successfully",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 20.0);
    print(send_result);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar:  AppBar(
        toolbarHeight: 70,
        // backgroundColor: Colors.red,
        flexibleSpace: Container(
          // color: Colors.grey,
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 0.5, color: Colors.black26)
                )
            ),
            padding: EdgeInsets.only(top:5, left: 5, right: 5, bottom: 0),
            // height: 220,
            // width: MediaQuery.of(context).size.width/1,
            child:Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 5, right: 5),
                            // margin: EdgeInsets.only(right: 5, left: 25),
                            width:70,
                            // height: 100,
                            // color: Colors.blueGrey,
                            child: Image.asset("assets/doctor_logo.png")),
                        Container(
                          height: 50,
                          // color: Colors.red,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("HealthCrad",  style: TextStyle(fontSize: 23, color: Color(0xff000000), fontWeight: FontWeight.w700,),),
                              Text("Save More, Serve More",  style: TextStyle(fontSize: 11, color: Color(0xff000000), fontWeight: FontWeight.bold,),),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      // color: Colors.green,
                      child:Row(
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(Icons.shopping_cart_outlined, color: Color(0xff000000),size: 30,)),
                          IconButton(onPressed: (){}, icon: Icon(Icons.notifications_none_outlined, color: Color(0xff000000),size: 30,))
                        ],
                      ) ,
                    )
                  ],
                ),
                // Container(
                //   height: 40,
                //   width:MediaQuery.of(context).size.width/1.12,
                //   padding: EdgeInsets.only(left: 5, right: 5),
                //   // alignment: Alignment.bottomLeft,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(10),
                //     color: Colors.grey.shade200.withOpacity(0.5),
                //     // border: Border(
                //     //   bottom: BorderSide(width: 0.3, color: Colors.black)
                //     // )
                //   ),
                //   child:
                //   Row(
                //     children: [
                //       Icon(Icons.location_on_outlined, size: 28,color: Theme.of(context).primaryColor,),
                //       SizedBox(width: 12,),
                //       Container(
                //         width:MediaQuery.of(context).size.width/1.3,
                //         child: DropdownButtonHideUnderline(
                //           child:DropdownButton(
                //             icon: Icon(Icons.arrow_drop_down_outlined, size: 35, color: Colors.black,),
                //             hint: Text(
                //               deta.first,
                //               style: TextStyle(
                //                 fontSize: 18,
                //                 color: Theme
                //                     .of(context)
                //                     .hintColor,
                //               ),
                //             ),
                //             items: deta
                //                 .map((item) =>
                //                 DropdownMenuItem<String>(
                //                   value: item,
                //                   child: Text(
                //                     item,
                //                     style: const TextStyle(
                //                       fontSize: 18,
                //                     ),
                //                   ),
                //                 ))
                //                 .toList(),
                //             value: selectValue,
                //             onChanged: (value) {
                //               selectValue = value as String;
                //               setState(() {
                //                 selectValue;
                //               });
                //             },
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // InkWell(
                //   onTap: (){
                //     Navigator.push(context, MaterialPageRoute(builder: (context)=>doctor_search()));
                //   },
                //   child: Container(
                //     height: 45,
                //     width: MediaQuery.of(context).size.width/1.1,
                //     padding: EdgeInsets.only(left: 10, right: 10),
                //     margin: EdgeInsets.only(left: 15, right: 15),
                //     // padding: EdgeInsets.all(5),
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       boxShadow: [
                //         BoxShadow(
                //             offset: Offset(0,2),
                //             color: Colors.grey.shade600.withOpacity(0.6),
                //             spreadRadius: 0, blurRadius: 3
                //         )
                //       ],
                //       borderRadius: BorderRadius.circular(25.0),
                //     ),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Text("Search", style: TextStyle(color: Colors.black, fontSize: 18, ),),
                //         Icon(Icons.search, size: 25, color: Colors.black,)
                //       ],
                //     ),
                //   ),
                // ),
              ],
            )
        ) ,
        // backgroundColor: Theme.of(context).primaryColor,
        titleSpacing: 20,
        automaticallyImplyLeading: false,
        // title: Text(
        //   'HealthCrad',
        //   style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        // ),
        // // centerTitle: true,
        // actions: <Widget>[
        //   Stack(
        //     children: [
        //       IconButton(
        //         icon: Icon(
        //           Icons.shopping_cart,
        //           size: 20, color: Colors.white,
        //         ),
        //         onPressed: () {
        //           Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage()));
        //         },
        //       ),
        //       Positioned.directional(
        //         textDirection: Directionality.of(context),
        //         top: 8,
        //         end: 12,
        //         child: CircleAvatar(
        //           backgroundColor: Colors.red,
        //           radius: 5.5,
        //           child: Center(
        //               child: Text(
        //             '3',
        //             style: Theme.of(context).textTheme.bodyText2!.copyWith(
        //                 color: Theme.of(context).scaffoldBackgroundColor,
        //                 fontSize: 9),
        //           )),
        //         ),
        //       )
        //     ],
        //   ),
        // ],
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20, left: 15, right: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 50, width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1, color: Colors.black.withOpacity(0.5)
                    ),
                    color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Are You in Emergency !!", style:TextStyle(fontSize: 25, ),),
                    ImageIcon(AssetImage('assets/banners/siren.png',),size: 40,color: Colors.red,)
                  ],
                ),
              ),
              SizedBox(height: 50,),
              GestureDetector(
                onTap: (){
                  print(_draggedAddress);
                  print(lat);
                  print(lan);
                  print("location yaha h");
                  showDialog(context: context,
                      builder: (context)=>Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Dialog(
                          child: Container(
                            padding:EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Text("Are you sure want to send emergency message", style: TextStyle(fontSize: 15,),textAlign: TextAlign.center,),
                                SizedBox(height: 20,),
                                Row(
                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                               children: [
                                 Container(width: 100, height: 40,
                                   child: ElevatedButton(onPressed: () {
                                     Navigator.pop(context);
                                   },
                                     style: ElevatedButton.styleFrom(
                                         primary: Colors.red
                                     ),
                                     child: Text("Cancel", style: TextStyle(fontSize: 15, color: Colors.white),),),
                                 ),

                                 Container(height: 40, width: 100,
                                   child: ElevatedButton(onPressed: (){
                                     emergency_req();
                                     sending_SMS(' I am in emergency please help me\n My location is: '+_draggedAddress+"\nLatLan:"+"$lat and $lan", ['7398403620', '9140334704','9219190060', '9984115192']);
                                     },
                                       style: ElevatedButton.styleFrom(
                                           primary: Theme.of(context).primaryColor
                                       )
                                       , child: Text("Confirm",style: TextStyle(fontSize: 15),)),
                                 )
                               ],
                             )
                              ],
                             ),
                            ),
                          ),
                        ],
                      ));
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>msgtxt()));
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 150, width: 150,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    border:Border.all(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(180)
                  ),
                  child: Text("Yes", style: TextStyle(color: Colors.white, fontSize: 60,fontWeight: FontWeight.w700),),
                ),
              ),
              SizedBox(height: 30,),
              Container(
                alignment: Alignment.center,
                height: 150, width: 150,
                decoration: BoxDecoration(
                    color: Colors.red,
                    border:Border.all(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(180)
                ),
                child: Text("No", style: TextStyle(color: Colors.white, fontSize: 60,fontWeight: FontWeight.w700),),
              ),
              SizedBox(height: 30,),
              Text("Acquire user current location", style: TextStyle(fontSize: 15),),
              SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: Colors.black)
                ),
                  height: MediaQuery.of(context).size.height*0.2,
                  child: _buildBody()
              ),
            ],
          ),
        ),
      ),
    ));
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
  // code for user location and address
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


// api for send data to backend.
  emergency_req() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'user_id';
    final user_id = prefs.getString(key) ?? 0;
    print(user_id);
    print(_draggedAddress);
    print("aaaaaaaaa");
    final response = await http.post(
      Uri.parse("https://app.healthcrad.com/api/index.php/api/Mobile_app/emergency"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'user_id':"$user_id",
        'map_url':_draggedAddress,
      }),
    );
    final data = jsonDecode(response.body);
    print(data);
    if (data['error'] == "200") {
      Fluttertoast.showToast(
          msg: "Emergency request send Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xff00ff44),
          textColor: Color(0xffffffff),
          fontSize: 16.0);
      print("Emergency request sent SucessFully");
      Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavigation()));
    }
    else {
      Fluttertoast.showToast(
          msg: data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor:  Color(0xffff0000),
          textColor:  Color(0xffffffff),
          fontSize: 16.0);
    }
  }
}
