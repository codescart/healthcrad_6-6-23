import 'dart:convert';
import 'dart:math';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:healthcrad_user/BottomNavigation/Medicine/my_cart.dart';
import 'package:healthcrad_user/BottomNavigation/bottom_navigation.dart';
import 'package:healthcrad_user/ambulance/ambulance_confirm.dart';
import 'package:healthcrad_user/ambulance/toaddress.dart';
import 'package:http/http.dart' as http;
import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:healthcrad_user/Components/custom_button.dart';
import 'package:healthcrad_user/Components/entry_field.dart';
import 'package:healthcrad_user/ambulance/fromaddress.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ambulance_booking extends StatefulWidget {
  final String fromaddress;
  final String toaddress;
  final String from_lat;
  final String from_lon;
  final String to_lan;
  final String to_lat;
  ambulance_booking({required this.fromaddress, required this.toaddress, required this.from_lat, required this.to_lan, required this.from_lon, required this.to_lat});
  @override
  State<ambulance_booking> createState() => _ambulance_bookingState();
}



class _ambulance_bookingState extends State<ambulance_booking> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _addressfrom = TextEditingController();
  final TextEditingController _addressto = TextEditingController();

  // var _selectedRadio;
  String _distanceResult = '';


  @override
  void initState() {
    super.initState();
    _calculateDistance();
  }
  var selectedIndex;
  var dist;
  var total_cost;
  var price;
   var ddd;//price per kilometer
  void _calculateDistance() async {
    double latitude1 = double.parse(widget.from_lat);
    double longitude1 = double.parse(widget.from_lon);
    double latitude2 = double.parse(widget.to_lat);
    double longitude2 = double.parse(widget.to_lan);
    print(latitude1);
    print(longitude1);
    print(latitude2);
    print(longitude2);
    // double distanceInMeters = await Geolocator.distanceBetween(
  //     latitude1,
  //     longitude1,
  //     latitude2,
  //     longitude2,
  //   );
  //  double dist=(distanceInMeters/1000);
  // var myy=dist.toStringAsFixed(1);
  //   setState(() {
  //     _distanceResult = '$myy';
  //   });
      final response = await http.get(
        Uri.parse(
            "https://app.healthcrad.com/api/getdistance.php?flat=$latitude1&flong=$longitude1&slat=$latitude2&slong=$longitude2"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      final data = jsonDecode(response.body);
      print(data);
      print(data['Totaldistance']);
      if (data['error'] == '200') {
        setState(() {
          ddd= data["km"];
        });
      }
      else{
        print("function nahi chala");
      }


    LatLng currentLetLang =  LatLng(latitude1, longitude1);
    LatLng destinationletlang =  LatLng(latitude2, longitude2);
    // setState(() {
    //   calculateDistance( currentLetLang,  destinationletlang);
    // });
  }

var value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        toolbarHeight: MediaQuery.of(context).size.height*0.09,
        flexibleSpace: Container(

           child:Column(
              children: [
                SizedBox(height:MediaQuery.of(context).size.height*0.04,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 5, right: 5),
                            width:70,
                            child: Image.asset("assets/doctor_logo.png")),
                        Container(
                          height: 50,
                          // color: Colors.red,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("Health",  style: TextStyle(fontSize: 21.5, color: Color(0xff084fa1), fontWeight: FontWeight.w700,),),
                                  Text("CRAD",  style: TextStyle(fontSize: 20.5, color:Theme.of(context).primaryColor, fontWeight: FontWeight.w700,),),
                                ],
                              ),
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
                          IconButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>CartPage()));
                          }, icon: Icon(Icons.shopping_cart_outlined, color: Color(0xff000000),size: 30,)),
                          // IconButton(onPressed: (){}, icon: Icon(Icons.notifications_none_outlined, color: Color(0xff000000),size: 30,))
                        ],
                      ) ,
                    )
                  ],
                ),
              ],
            )
        ) ,
        titleSpacing: 20,
        automaticallyImplyLeading: false,
      ),
      body: FadedSlideAnimation(
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                Container(
                  margin: EdgeInsets.only( left: 10, right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).backgroundColor,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width/1.23,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: (){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>add_address(toadd:_addressto.text, tolat:widget.to_lat, tolan:widget.to_lan,)));
                              },
                              child: Container(
                                // height: 40,
                                // padding: EdgeInsets.only( top: 8, right: 0),
                                // width: MediaQuery.of(context).size.width/1.4,
                                child: TextField(
                                  onChanged: (e){
                                    setState(() {
                                      _calculateDistance();
                                    });
                                  },
                                  enabled: false,
                                  maxLines: 2,
                                  style: TextStyle(fontSize: 13),
                                  textAlign: TextAlign.center,
                                  textAlignVertical: TextAlignVertical.center,
                                  controller: _addressfrom..value..text= widget.fromaddress,
                                  cursorColor: Theme.of(context).primaryColor,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor:Color(0xff0000ffff),
                                      // fillColor: Colors.blueGrey,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      contentPadding: EdgeInsets.only(top: 0,bottom: 0),
                                      hintText:"From",
                                      hintStyle: TextStyle(color: Color(0xff000000), fontSize: 20)
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              child: Text(" -"*30, style: TextStyle(color: Color(0xff808080)),overflow: TextOverflow.ellipsis,),
                            ),
                            InkWell(
                              onTap: (){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>toaddress(
                                    fromadd:_addressfrom.text,
                                    from_lat:widget.from_lat,
                                  from_lan:widget.from_lon
                                )));
                              },
                              child: Container(
                                child: TextField(
                                  onChanged: (e){
                                    setState(() {
                                      _calculateDistance();
                                    });
                                  },
                                  enabled: false,
                                  maxLines: 2,
                                  style: TextStyle(fontSize: 13,),
                                  textAlign: TextAlign.center,
                                  controller: _addressto..text=widget.toaddress,
                                  cursorColor: Theme.of(context).primaryColor,
                                  decoration: InputDecoration(
                                       filled: true,
                                      fillColor:Color(0xff0000ffff),
                                      // fillColor: Colors.blueGrey,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      contentPadding: EdgeInsets.only(top: 0,bottom: 0),
                                      hintText:"To",
                                      hintStyle: TextStyle(color: Color(0xff000000), fontSize: 20)
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width/9,
                        child: IconButton(onPressed: (){
                          if(_addressfrom.text== widget.fromaddress && _addressto.text==widget.toaddress){
                            _addressfrom..text=widget.toaddress;
                            _addressto..text=widget.fromaddress;
                          }
                          else if(_addressfrom.text==widget.toaddress && _addressto.text==widget.fromaddress){
                            _addressfrom..text= widget.fromaddress;
                            _addressto..text=widget.toaddress;

                          }
                        },
                            icon: Icon(Icons.arrow_circle_down_outlined,size: 40, )),
                      )
                    ],
                  ),
                ),
                Divider(thickness: 1.5, color:Theme.of(context).primaryColor,),
                Padding(padding: EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 10),
                 child: Column(
                   children: [
                     Text("Select Ambulance Type", style: TextStyle(fontSize: 20, color:  Color(0xff000000)),),
                     SizedBox(height: 10,),
                     FutureBuilder<List<Album>>(
                         future: bow(),
                       builder: (context, snapshot) {
                         if (snapshot.hasError) print(snapshot.error);
                         return snapshot.hasData
                             ?GridView.count(
                           physics: BouncingScrollPhysics(),
                           childAspectRatio: 2.5,
                           crossAxisCount: 2,
                           crossAxisSpacing: 8.0,
                           mainAxisSpacing: 8.0,
                           shrinkWrap: true,
                           children: List.generate( snapshot.data!.length, (index) {
                             return InkWell(
                               onTap: (){
                                 setState(() {
                                   _calculateDistance();
                                   selectedIndex=snapshot.data![index].type;
                                   print(selectedIndex);
                                   price= snapshot.data![index].price;
                                   final base_price = double.parse(snapshot.data![index].base_price.toString());
                                   final cost =  double.parse(price.toString());
                                   final mydist= double.parse(ddd.toString());
                                   final dddd= (mydist*cost)+base_price;
                                   total_cost =  dddd.toStringAsFixed(1);
                                   print("aaaaaaaaaaa");
                                   print(total_cost);
                                 });
                               },
                               child: Container(
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(10),
                                   color:selectedIndex==snapshot.data![index].type? Color(0xffffffff):Theme.of(context).backgroundColor,
                                   border: selectedIndex==snapshot.data![index].type?Border.all(width: 2, color: Theme.of(context).primaryColor):Border.all(width: 0, color:Color(0xffaba9a9).withOpacity(0.5))
                                 ),
                                 child:Center(child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                   children: [
                                     Text(snapshot.data![index].type.toString().toUpperCase(), style: TextStyle(fontSize:selectedIndex==snapshot.data![index].type?9.5:9, color:selectedIndex==snapshot.data![index].type?Theme.of(context).primaryColor:Color(0xff000000)),),
                                     IconButton(onPressed: () {
                                       showDialog(
                                         // barrierColor: Colors.transparent,
                                         context: context,
                                         builder: (BuildContext context) => Column(
                                           mainAxisAlignment: MainAxisAlignment.start,
                                           mainAxisSize: MainAxisSize.min,
                                           children: [
                                             SizedBox(height: MediaQuery.of(context).size.height/11,),
                                             Dialog(
                                               shape:RoundedRectangleBorder(
                                                 borderRadius: BorderRadius.circular(16),
                                               ),
                                               elevation: 0,
                                               backgroundColor: Colors.white,
                                               child:Container(
                                                 padding:EdgeInsets.all(15),
                                                 decoration: BoxDecoration(
                                                   color: Colors.white,
                                                   borderRadius: BorderRadius.circular(16)
                                                 ),
                                                 // height: 100, width: 300,
                                                 child: Column(
                                                   crossAxisAlignment:CrossAxisAlignment.start,
                                                   children: [
                                                     Text("Ambulance Type: "+snapshot.data![index].type.toString().toUpperCase(), style: TextStyle(fontSize: 13),),
                                                     SizedBox(height: 5,),
                                                     Text("Features: "+snapshot.data![index].features.toString(), style: TextStyle(fontSize: 12, color: Colors.blueGrey)),
                                                     SizedBox(height: 5,),
                                                     Text(snapshot.data![index].description.toString(), style: TextStyle(fontSize: 12, color: Colors.blueGrey),),
                                                   ],
                                                 ),
                                               ),
                                             ),
                                           ],
                                         ),
                                       );
                                     },
                                     icon:Icon(Icons.info, size: 20, color:Theme.of(context).primaryColor)),
                                   ],
                                 )) ,
                               ),
                             );
                           },),
                         ):Container(child: Text("not available"),);
                       }
                     ),
                   ],
                 ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding:  EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width:MediaQuery.of(context).size.width/1.1,
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(top: 8, bottom: 8,left: 8, right: 8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                          border: Border.all(width: 1, color:  Color(0xff000000)),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Total Distance : ", style: TextStyle(fontSize: 18, color: Color(0xff000000))),
                              Text(ddd==null?"00 km": "$ddd km", style: TextStyle(fontSize: 20, color:Theme.of(context).primaryColor, fontWeight:FontWeight.w800)),
                            ]
                        ),
                      ),
                      // Container(
                      //   // width:MediaQuery.of(context).size.width/3.2,
                      //   padding: EdgeInsets.only(top: 8, bottom: 8,left: 8, right: 8),
                      //   decoration: BoxDecoration(
                      //       color: Theme.of(context).backgroundColor,
                      //       border: Border.all(width: 1, color: Color(0xff000000)),
                      //       borderRadius: BorderRadius.circular(10)
                      //   ),
                      //   child: Row(
                      //         children: [
                      //           Text("Total Price : ", style: TextStyle(fontSize: 12, color: Color(0xff000000))),
                      //           Text(total_cost==null?"00":'$total_cost', style: TextStyle(fontSize: 16, color:Theme.of(context).primaryColor, fontWeight:FontWeight.w800)),
                      //         ]
                      //     ),
                      // ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 30),
                 child: Column(
                  children: [
                    EntryField(
                      onChange: (){
                        setState(() {
                          _name;
                        });
                      },
                      controller: _name,
                      prefixIcon: Icons.person,
                      hint: "Enter Patent name",
                      // readOnly: true,
                    ),
                    SizedBox(height: 10.0),
                    EntryField(
                      onChange: (){
                        setState(() {
                          _phone;
                        });
                      },
                      controller: _phone,
                      prefixIcon: Icons.phone_android,
                      hint: "Enter your Mobile No",
                    ),
                  ],
                ),
                ),
                 Container(
                  padding: EdgeInsets.all(15),
                  child: CustomButton(
                      onTap: () {
                    // print(_addressfrom.text);
                    if(selectedIndex!=null && _name.text.isNotEmpty && _phone.text.isNotEmpty && _addressfrom.text.isNotEmpty && _addressto.text.isNotEmpty){
                      Fluttertoast.showToast(
                          msg: "Proceed to next step",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ambulance_confirm(
                        type:selectedIndex,
                        fromlocation:widget.fromaddress,
                        tolocation:widget.toaddress,
                        amount:total_cost.toString(),
                        distance:ddd.toString(),
                        name:_name.value.text,
                        phone:_phone.value.text,
                        from_lat:widget.from_lat,
                        from_lan:widget.from_lon,
                        to_lan:widget.to_lan,
                        to_lat:widget.to_lat
                      )));
                    }
                    else{
                      Fluttertoast.showToast(
                          msg: "all details must be need to fill",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  }
                  ),
                ),
              ],
            ),
          ),
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }

  // ambulance_book(String _name, String _phone, String _address) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final key = 'user_id';
  //   final user_id = prefs.getString(key) ?? 0;
  //   print(user_id);
  //   print(_name);
  //   print(_phone);
  //   print(_address);
  //   print("aaaaaaaaa");
  //   final response = await http.post(
  //     Uri.parse("https://app.healthcrad.com/api/index.php/api/Mobile_app/book_ambulance"),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(<String, String>{
  //       'amount':"200",
  //       'user_id':'$user_id',
  //       'username': _name,
  //       'phone': _phone,
  //       'address': _address.toString(),
  //     }),
  //   );
  //   final data = jsonDecode(response.body);
  //   print(data);
  //   if (data['error'] == '200') {
  //     Fluttertoast.showToast(
  //         msg: "Ambulance Booked Successfully",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.CENTER,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Color(0xff00ff44),
  //         textColor: Color(0xffffffff),
  //         fontSize: 16.0);
  //     print("Register SucessFully");
  //     Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavigation()));
  //   }
  //   else {
  //     Fluttertoast.showToast(
  //         msg: data['msg'],
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.CENTER,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor:  Color(0xffff0000),
  //         textColor:  Color(0xffffffff),
  //         fontSize: 16.0);
  //   }
  // }
  Future<List<Album>> bow() async{
    final response = await http.post(
      Uri.parse('https://app.healthcrad.com/api/index.php/api/Mobile_app/ambulance_type'),

    );

    var jsond = json.decode(response.body)["country"];
    print(jsond);
    List<Album> allround = [];
    for (var o in jsond)  {
      Album al = Album(
        o["id"],
        o["type"],
        o["price"],
        o["description"],
        o["features"],
        o["base_price"],
      );
      allround.add(al);
    }
    return allround;
  }
}

class Album {
  String? id;
  String? type;
  String? price;
  String? description;
  String? features;
  String? base_price;

  Album(
      this.id,
      this.type,
      this.price,
      this.description,
      this.features,
      this.base_price,
      );

}
