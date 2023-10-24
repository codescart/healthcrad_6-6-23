import 'dart:convert';

import 'package:animation_wrappers/Animations/faded_scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:healthcrad_user/BottomNavigation/bottom_navigation.dart';
import 'package:healthcrad_user/ambulance/map_test.dart';
import 'package:http/http.dart'   as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
class ambulance_view extends StatefulWidget {
  const ambulance_view({Key? key}) : super(key: key);

  @override
  State<ambulance_view> createState() => _ambulance_viewState();
}

class _ambulance_viewState extends State<ambulance_view> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            size: 16,
            color: Colors.white,
          ),
          onTap:() {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNavigation(pageIndex:3)));
          },
        ),
        title: FadedScaleAnimation(
          Text(
            "My Ambulace Bookings",
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(fontSize: 17, color: Colors.white),
          ),
          durationInMilliseconds: 400,
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20, left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<List<doctor>>(
                  future: medicine(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);
                    return snapshot.hasData
                        ? ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){},
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    width: 1, color: Theme.of(context).primaryColor
                                )
                            ),
                            width: MediaQuery.of(context).size.width/1.5,
                            padding: EdgeInsets.only(left: 0, right: 5, top: 0,bottom: 0),
                            margin: EdgeInsets.only(left: 5, right: 5, bottom: 5),

                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color:Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(9),
                                        bottomLeft: Radius.circular(9),
                                      )
                                  ),
                                  height:160,
                                  width: MediaQuery.of(context).size.width/6,
                                  child: Padding(
                                    padding:
                                    EdgeInsets.only(top: 8, bottom: 10.0),
                                    child: GestureDetector(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text("Ord Id: "+snapshot.data![index].id.toString(), style: TextStyle(fontSize: 11, color: Colors.white),),
                                          CircleAvatar(
                                            radius: 35,
                                            backgroundImage: AssetImage("assets/doctor_logo.png"),
                                            backgroundColor: Colors.white,
                                          ), // Text(snapshot.data)
                                          // Text("₹: "+snapshot.data![index].amount.toString(), style: TextStyle(fontSize: 10, color: Colors.white),),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 5, bottom: 5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width/1.4,
                                        padding: EdgeInsets.only(right: 15),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Name:  "+snapshot.data![index].username.toString().toUpperCase(), style: TextStyle(fontSize: 11, ),),
                                            Text("Phone:  "+snapshot.data![index].phone.toString(), style: TextStyle(fontSize: 11, ),),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      Container(
                                        width: MediaQuery.of(context).size.width/1.4,
                                        padding: EdgeInsets.only(right: 15),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            snapshot.data![index].dname==null?Text("Searching for Driver ", style: TextStyle(color: Colors.black26,fontSize: 12, ),):Text("Driver Name:  "+snapshot.data![index].dname.toString().toUpperCase(), style: TextStyle(fontSize: 11, ),),
                                            snapshot.data![index].dphone==null?Container(
                                              width: 50,height: 25,
                                              decoration: BoxDecoration(
                                                  border: Border.all(width: 1, color: Colors.black26),
                                                  // color: Theme.of(context).primaryColor,
                                                  borderRadius: BorderRadius.circular(5)
                                              ),
                                              child:Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Icon(Icons.call, size: 15,color: Colors.black26,),
                                                  Text("Driver", style: TextStyle(fontSize: 10,color: Colors.black26 ),),
                                                ],
                                              ),
                                            ):
                                               GestureDetector(
                                                 onTap:() async {
                                                   var url = Uri.parse("tel: "+snapshot.data![index].dphone.toString());
                                                   if (await canLaunchUrl(url)) {
                                                   await launchUrl(url);
                                                   } else {
                                                   throw 'Could not launch $url';
                                                   }
                                                 },
                                                 child: Container(
                                                   width:35,height: 25,
                                                   decoration: BoxDecoration(
                                                     border: Border.all(width: 1, color: Colors.blueAccent),
                                                       // color: Theme.of(context).primaryColor,
                                                       borderRadius: BorderRadius.circular(5)
                                                   ),
                                                   child:Row(
                                                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                     children: [
                                                       Icon(Icons.call, size: 18,color: Colors.blueAccent),
                                                       // Text("call", style: TextStyle(fontSize: 13,color: Colors.blueAccent ),),
                                                     ],
                                                   ),
                                                 ),
                                               )
                                                // IconButton(onPressed: (){}, icon: Icon(Icons.add_call, size: 15,))
                                            // Text("Driver Phone:  "+snapshot.data![index].dphone.toString(), style: TextStyle(fontSize: 11, ),),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      Container(
                                        width: MediaQuery.of(context).size.width/1.4,
                                        padding: EdgeInsets.only(right: 15),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Type:  "+snapshot.data![index].ambulance_type.toString(), style: TextStyle(fontSize: 13, ),),
                                            Text("Dist: "+snapshot.data![index].distance.toString()+" km", style: TextStyle(fontSize: 13, ),),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      Container(
                                        width: MediaQuery.of(context).size.width/1.4,
                                        // padding: EdgeInsets.only(right: 15),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("from:  "+snapshot.data![index].pickup_address.toString(), style: TextStyle(fontSize: 11,overflow: TextOverflow.ellipsis ),),
                                            SizedBox(height: 5,),
                                            Text("To:  "+snapshot.data![index].drop_address.toString(), style: TextStyle(fontSize: 11,overflow: TextOverflow.ellipsis ),),
                                            SizedBox(height: 8,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text("Status: ", style: TextStyle(fontSize: 11, color: Colors.black54),),
                                                   snapshot.data![index].status=="0" || snapshot.data![index].status=="1" || snapshot.data![index].status=="2" || snapshot.data![index].status=="3"?Text("Wait for Accept order", style: TextStyle(fontSize: MediaQuery.of(context).size.width/30, color: Colors.black54),):
                                                   snapshot.data![index].status.toString()=="4" || snapshot.data![index].status=="5"  ?Text("Driver Assigned", style: TextStyle(fontSize: MediaQuery.of(context).size.width/30, color:Colors.green),):
                                                   snapshot.data![index].status.toString()=="6" ?Text("Driver on the way", style: TextStyle(fontSize:MediaQuery.of(context).size.width/30, color:Colors.green),):
                                                   snapshot.data![index].status.toString()=="7" ?Text("Arrived pickup location", style: TextStyle(fontSize: MediaQuery.of(context).size.width/30, color:Colors.green),):
                                                   snapshot.data![index].status.toString()=="8" ?Text("Pin Verified & Pickup", style: TextStyle(fontSize:MediaQuery.of(context).size.width/30, color:Colors.green),):
                                                   snapshot.data![index].status.toString()=="9" ?Text("Trip started", style: TextStyle(fontSize: MediaQuery.of(context).size.width/30, color:Colors.green),):
                                                   snapshot.data![index].status.toString()=="10" ?Text("Reached Destination & Trip Completed", style: TextStyle(fontSize:MediaQuery.of(context).size.width/30, color:Colors.green),):
                                                   snapshot.data![index].status=="11"?Text("Trip completed", style: TextStyle(fontSize: 15, color: Colors.green, fontWeight: FontWeight.bold),):

                                                   Container()
                                                  ],
                                                ),
                                                snapshot.data![index].status.toString()=="5" || snapshot.data![index].status.toString()=="6" ||
                                                    snapshot.data![index].status.toString()=="8" || snapshot.data![index].status.toString()=="9"? GestureDetector(
                                                    onTap:(){
                                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PlayBack(
                                                     id:snapshot.data![index].id.toString(),
                                                    )));
                                                    },
                                                     child: Container(
                                                     padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                                     decoration: BoxDecoration(
                                                       border: Border.all(width: 1, color: Colors.blueAccent),
                                                       // color: Theme.of(context).primaryColor,
                                                       borderRadius: BorderRadius.circular(5)
                                                   ),
                                                     child: Text("Track location", style: TextStyle(fontSize: 11.5, color: Theme.of(context).primaryColor),)),
                                             ):Container()
                                              ],
                                            ),
                                            SizedBox(height: 5,),
                                            Row(
                                              children: [
                                                Text("Verification Code:", style: TextStyle(fontSize: 12, color: Colors.black,),),
                                                SizedBox(width: 5,),
                                                Text(snapshot.data![index].verify_number.toString(), style: TextStyle(fontSize: 15, color:Theme.of(context).primaryColor,),)
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );

                      },
                    ):Center(child:Text('No Bookings'));
                  })
            ],
          ),
        ),
      ),
    );
  }

  Future<List<doctor>> medicine() async{
    // final catgId = widget.catid;
    final prefs = await SharedPreferences.getInstance();
    final key = 'user_id';
    final user_id = prefs.getString(key) ?? 0;
    final response = await http.get(
      Uri.parse('https://app.healthcrad.com/api/index.php/api/Mobile_app/ambulancehistory?user_id=$user_id'),
    );
    var jsond = json.decode(response.body)["data"];

    List<doctor> allround = [];
    for (var o in jsond)  {
      doctor al = doctor(
        o["id"],
        o["username"],
        o["phone"],
        o["ambulance_type"],
        o["vehicle_number"],
        o["pickup_address"],
        o["drop_address"],
        o["distance"],
        o["amount"],
        o["aname"],
        o["dname"],
        o["dphone"],
        o["agency_id"],
        o["verify_number"],
        o["status"],
      );
      allround.add(al);
    }
    return allround;
  }
}

class doctor {
  String? id;
  String? username;
  String? phone;
  String? ambulance_type;
  String? vehicle_number;
  String? pickup_address;
  String? drop_address;
  String? distance;
  String? amount;
  String? aname;
  String? dname;
  String? dphone;
  String? agency_id;
  String? verify_number;
  String? status;



  doctor(
      this.id,
      this.username,
      this.phone,
      this.ambulance_type,
      this.vehicle_number,
      this.pickup_address,
      this.drop_address,
      this.distance,
      this.amount,
  this.aname,
  this.dname,
  this.dphone,
      this.agency_id,
      this.verify_number,
      this.status

      );
}
