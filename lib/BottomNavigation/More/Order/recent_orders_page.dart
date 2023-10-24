import 'dart:convert';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:healthcrad_user/BottomNavigation/Medicine/order/odered_medicine_details.dart';
import 'package:healthcrad_user/BottomNavigation/Medicine/order/order_tabbar.dart';
import 'package:healthcrad_user/BottomNavigation/More/Order/past_order.dart';
import 'package:healthcrad_user/BottomNavigation/bottom_navigation.dart';
import 'package:healthcrad_user/Locale/locale.dart';
import 'package:healthcrad_user/Models/order_card_model.dart';
import 'package:healthcrad_user/BottomNavigation/More/Order/order_info.dart';
import 'package:healthcrad_user/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:healthcrad_user/Routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import 'package:url_launcher/url_launcher.dart';

class resent{
  dynamic id;
  dynamic user_id;
  dynamic amount;
  dynamic paymode;
  dynamic discount;
  dynamic groupid;
  dynamic date_time;
  dynamic productid;
  dynamic quantity;
  dynamic totalamount;
  dynamic datetime;
  dynamic paymod;
  dynamic name;
  // String? image;
  dynamic status;
  dynamic url;
  dynamic count;
  resent(
      this.id,
      this.user_id,
      this.amount,
      this.paymode,
      this.discount,
      this.groupid,
      this.date_time,
      this.productid,
      this.quantity,
      this.totalamount,
      this.datetime,
      this.paymod,
      this.name,
      // this.image,
      this.status,
      this.url,
      this.count
      );

}

class RecentOrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNavigation(pageIndex:3)));
            },
            icon: Icon(Icons.chevron_left, color: Colors.white)),
        title: Text(
          locale.recentOrders!,
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
      body: FadedSlideAnimation(
        ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width/2,
                  // padding: EdgeInsets.only(top: 20, right: 20, left: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      border: Border(
                          bottom: BorderSide(width: 2, color:Theme.of(context).primaryColor )
                      )
                  ),
                  height: 50,
                  child: Text('In Process Orders',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 13.3, color: Theme.of(context).primaryColor)),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>prescription_order()));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width/2,
                    // padding: EdgeInsets.only(top: 20, right: 20, left: 10),
                    alignment: Alignment.center,
                    // color: Theme.of(context).backgroundColor,
                    height: 50,
                    child: Text("Prescription Orders",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontSize: 13.3, color: Color(0xffb3b3b3))),
                  ),
                ),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height/1.25,
              child: FutureBuilder<List<resent>>(
                  future: resentAppot(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);
                    return snapshot.hasData
                        ? ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) =>
                          OrderCard(snapshot.data![index]),
                    ):Center(child: Text("Orders not available"),);
                  }
              ),
            )
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
  // api for data for medicine order
  Future<List<resent>> resentAppot() async{
    final prefs = await SharedPreferences.getInstance();
    final key = 'user_id';
    final user_id = prefs.getString(key) ?? 0;
    final response = await http.get(
      Uri.parse('https://app.healthcrad.com/api/index.php/api/Mobile_app/inprocess_order?user_id=$user_id'),
      // Uri.parse('https://app.healthcrad.com/api/index.php/api/Check_out/inprocess_order?user_id=$user_id'),
    );
//https://app.healthcrad.com/api/index.php/api/Mobile_app/inprocess_order?user_id=1069
    var jsond = json.decode(response.body)["country"];
    print(jsond);
    List<resent> resentlist = [];
    for (var o in jsond)  {
      resent al = resent(
           o['id'],
           o['user_id'],
           o['amount'],
           o['paymode'],
           o['discount'],
           o['groupid'],
           o['date_time'],
           o['productid'],
           o['quantity'],
           o['totalamount'],
           o['datetime'],
           o['paymod'],
           o['name'],
           // o['image'],
           o['status'],
           o['url'],
           o['count']
      );

      resentlist.add(al);
    }
    return resentlist;
  }
  // api for order by prescription
}


class OrderCard extends StatelessWidget {
  final resent orderCard;

  OrderCard(this.orderCard);

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => order_detailos(
                          groupid:orderCard.groupid.toString(),
                          amount:orderCard.amount.toString(),
                          status: orderCard.status.toString(),
                        )));
              },
              child: Image.asset("assets/doctor_logo.png", height: 40)),
          title: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => order_detailos(
                              groupid:orderCard.groupid.toString(),
                              amount:orderCard.amount.toString(),
                            status: orderCard.status.toString(),

                          )));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width/2,
                  child: Text(
                     orderCard.count.toString()+" Items",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: black2, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
                    maxLines: 2,
                  ),
                ),
              ),
              Spacer(),
              Text(
                  '\₹' + orderCard.amount.toString()! + ' | ' + orderCard.paymode.toString()!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 12, color: Colors.blueAccent)),
            ],
          ),
          subtitle: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => order_detailos(
                                  groupid:orderCard.groupid.toString(),
                                  amount:orderCard.amount.toString(),
                                status:orderCard.status.toString()
                              )));
                    },
                    child: Text(
                      orderCard.date_time.toString()!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 12, color: Color(0xffb3b3b3)),
                    ),
                  ),
                  Spacer(),
                  orderCard.url==null?GestureDetector(
                    onTap:(){
                    },
                    child: Container(
                      decoration:BoxDecoration(
                          border: Border.all(width: 0.5,color:Colors.black26),
                          borderRadius: BorderRadius.circular(3)
                      ),
                      // margin:EdgeInsets.only(right: 10, bottom: 10),
                      padding:EdgeInsets.all(3),
                      child:Text("Track Order", style: TextStyle(fontSize: 12.3, color:Colors.black26),),
                    ),
                  ):GestureDetector(
                    onTap:()
                      async {
                        final url = orderCard.url.toString();
                        if (await canLaunch(url!)) {
                      await launch(url!, forceWebView: true, enableJavaScript: true);
                      } else {
                      throw 'Could not launch $url';
                      }
                    },
                    child: Container(
                      decoration:BoxDecoration(
                          border: Border.all(width: 0.5,color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(3)
                      ),
                      // margin:EdgeInsets.only(right: 10, bottom: 10),
                      padding:EdgeInsets.all(3),
                      child:Text("Track Order", style: TextStyle(fontSize: 11.3, color:Theme.of(context).primaryColor),),
                    ),
                  ),

                ],
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Text("Order status: ",style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 12, color: Colors.black54)),
                      orderCard.status=="1"? Text("Processing",style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 14, color: Colors.green)):
                      orderCard.status=="2"? Text("Order Accepted",style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 14, color: Colors.green)):
                      orderCard.status=="4"? Text("Order Pickup",style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 14, color: Colors.green)):
                      orderCard.status=="0"? Text("Waiting",style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 14, color: Colors.orangeAccent)):
                      orderCard.status=="5"? Text("Delivered",style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 14, color: Colors.green)):
                      orderCard.status=="10"? Text("Shipped",style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 14, color: Colors.green)):
                      orderCard.status=="7"? Text("Returned",style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 14, color: Colors.green)):
                      orderCard.status=="8"? Text("Replaced",style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 14, color: Colors.green)):
                      orderCard.status=="9"? Text("Refund complete",style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 14, color: Colors.green)):
                      orderCard.status=="10"? Text("Shipped",style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 14, color: Colors.green)):
                      Container()
                    ],
                  ),
                  // here manage the status of order..
                ],
              ),
              SizedBox(height: 8,),
            ],
          ),
        ),
               Divider(thickness: 6, height: 0),
      ],
    );
  }
}


