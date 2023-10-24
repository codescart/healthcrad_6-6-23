import 'dart:convert';
import 'package:healthcrad_user/BottomNavigation/Medicine/order/prescription_details.dart';
import 'package:healthcrad_user/BottomNavigation/More/Order/past_order.dart';
import 'package:healthcrad_user/BottomNavigation/bottom_navigation.dart';
import 'package:healthcrad_user/Theme/colors.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class prescription_order extends StatefulWidget {
  const prescription_order({Key? key}) : super(key: key);

  @override
  State<prescription_order> createState() => _prescription_orderState();
}

class _prescription_orderState extends State<prescription_order> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNavigation(pageIndex:3)));
            },
            icon: Icon(Icons.chevron_left,color: Colors.white)),
        title: Text(
          "Order by Prescription",
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontSize: 17, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>past_order()));
          }, icon: Icon(Icons.history,color: Colors.white))
        ],
        centerTitle: true,
        toolbarTextStyle: Theme.of(context).textTheme.bodyText2,
        titleTextStyle: Theme.of(context).textTheme.headline6,
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width/2,
                    // padding: EdgeInsets.only(top: 20, right: 20, left: 10),
                    alignment: Alignment.center,
                    height: 50,
                    child: Text('In Process Orders',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontSize: 13.3, color: Color(0xffb3b3b3))),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>past_appointment()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        border: Border(
                            bottom: BorderSide(width: 2, color:Theme.of(context).primaryColor )
                        )
                    ),
                    width: MediaQuery.of(context).size.width/2,
                    // padding: EdgeInsets.only(top: 20, right: 20, left: 10),
                    alignment: Alignment.center,
                    // color: Theme.of(context).backgroundColor,
                    height: 50,
                    child: Text("Prescription Orders",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontSize: 13.3, color: Theme.of(context).primaryColor)),
                  ),
                ),
              ],
            ),
           SizedBox(height: 15,),
            Container(
              height: MediaQuery.of(context).size.height/1.3,
              child: FutureBuilder<List<doctor>>(
                  future: medicine(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);
                    return snapshot.hasData
                        ? ListView.builder(
                      // physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              leading: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => prescription_detail(
                                                id:snapshot.data![index].id.toString(),
                                              status:""
                                            )));
                                  },
                                  child: Image.asset("assets/doctor_logo.png", height: 40)),
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    snapshot.data![index].images.toString()!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(color: black2, fontWeight: FontWeight.bold),
                                  ),

                                  // Spacer(),
                                  Text(
                                       snapshot.data![index].landmark.toString() + ' ' + snapshot.data![index].city.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(fontSize: 12, color: Colors.blueAccent)),
                                ],
                              ),
                              subtitle: Row(
                                children: [
                                    Text(
                                      snapshot.data![index].phone.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(fontSize: 12, color: Color(0xffb3b3b3)),
                                    ),
                                  Spacer(),
                                  // orderCard.url==null?GestureDetector(
                                  //   onTap:(){
                                  //
                                  //   },
                                  //   child: Container(
                                  //     decoration:BoxDecoration(
                                  //         border: Border.all(width: 0.5,color:Colors.black26),
                                  //         borderRadius: BorderRadius.circular(3)
                                  //     ),
                                  //     // margin:EdgeInsets.only(right: 10, bottom: 10),
                                  //     padding:EdgeInsets.all(3),
                                  //     child:Text("Track Order", style: TextStyle(fontSize: 12.3, color:Colors.black26),),
                                  //   ),
                                  // ):GestureDetector(
                                  //   onTap:(){},
                                  //   // async {
                                  //   //   final url = orderCard.name.toString();
                                  //   //   if (await canLaunch(url!)) {
                                  //   //     await launch(url!, forceWebView: true, enableJavaScript: true);
                                  //   //   } else {
                                  //   //     throw 'Could not launch $url';
                                  //   //   }
                                  //   //
                                  //   // },
                                  //   child: Container(
                                  //     decoration:BoxDecoration(
                                  //         border: Border.all(width: 0.5,color: Theme.of(context).primaryColor),
                                  //         borderRadius: BorderRadius.circular(3)
                                  //     ),
                                  //     // margin:EdgeInsets.only(right: 10, bottom: 10),
                                  //     padding:EdgeInsets.all(3),
                                  //     child:Text("Track Order", style: TextStyle(fontSize: 11.3, color:Theme.of(context).primaryColor),),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            // ListView.builder(
                            //   physics: NeverScrollableScrollPhysics(),
                            //   itemCount: orderCard.medicines.length,
                            //   padding: EdgeInsetsDirectional.fromSTEB(72, 0, 0, 20),
                            //   shrinkWrap: true,
                            //   itemBuilder: (context, innerIndex) => Text(
                            //     orderCard.medicines[innerIndex],
                            //     style: Theme.of(context)
                            //         .textTheme
                            //         .bodyText1!
                            //         .copyWith(height: 1.8, fontSize: 13.5, color: black2),
                            //   ),
                            // ),
                            // if (orderCard.status.toLowerCase() == 'delivered')
                            //   Align(
                            //     alignment: AlignmentDirectional.topEnd,
                            //     child: TextButton(
                            //         onPressed: () =>
                            //             Navigator.pushNamed(context, PageRoutes.reviewOrderPage),
                            //         child: Text(
                            //           locale!.reviewNow!,
                            //           style: Theme.of(context)
                            //               .textTheme
                            //               .bodyText1!
                            //               .copyWith(color: Theme.of(context).primaryColor),
                            //         )),
                            //   ),
                            Container(
                              padding: EdgeInsets.only(left: 10,right: 10, bottom: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Order Status: ",style: TextStyle(fontSize: 12, color:Colors.black54)),
                                  Container(
                                      alignment: Alignment.centerRight,
                                      width: MediaQuery.of(context).size.width/1.7,
                                      child:snapshot.data![index].status=="1"? Text("Order Accepted",
                                        softWrap: true,
                                        style: TextStyle(fontSize: 12, color:Colors.green,),):
                                      snapshot.data![index].status=="2"? Text("Order Processing",
                                        softWrap: true,
                                        style: TextStyle(fontSize: 12, color:Colors.green,),):
                                      snapshot.data![index].status=="4"? Text("Order Pickup",
                                        softWrap: true,
                                        style: TextStyle(fontSize: 12, color:Colors.green,),):
                                      snapshot.data![index].status=="0"? Text("Order Waiting",
                                        softWrap: true,
                                        style: TextStyle(fontSize: 12, color:Colors.green,),):
                                      Text("not avl.",style: TextStyle(fontSize: 12, ))
                                  ),
                                ],
                              ),
                            ),
                            Divider(thickness: 6, height: 0),
                          ],
                        );
                      },
                    )
                        : Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ));
                  }),
            )
          ],
        ),
      ),
    );
  }
  Future<List<doctor>> medicine() async {
    // final catgId = widget.catid;
    final prefs = await SharedPreferences.getInstance();
    final key = 'user_id';
    final user_id = prefs.getString(key) ?? 0;
    final response = await http.post(
      Uri.parse(
          'https://app.healthcrad.com/api/index.php/api/Check_out/prescription_order?userid=$user_id'),
    );

    var jsond = json.decode(response.body)["data"];
    List<doctor> allround = [];
    for (var o in jsond) {
      doctor al = doctor(
        o["id"],
        o["userid"],
        o["pincode"],
        o["city"],
        o["images"],
        o["address"],
        o["phone"],
        o["landmark"],
        o["status"],
      );

      allround.add(al);
    }
    return allround;
  }
}
class doctor {
  String? id;
  String? userid;
  String? pincode;
  String? city;
  String? images;
  String? address;
  String? phone;
  String? landmark;
  String? status;



  doctor(
      this.id,
      this.userid,
      this.pincode,
      this.city,
      this.images,
      this.address,
      this.phone,
      this.landmark,
      this.status,


      );
}