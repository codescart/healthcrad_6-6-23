import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class order_detailos extends StatefulWidget {
  String groupid;
  String amount;
  String status;

  order_detailos({ required this.groupid, required this.amount, required this.status});

  @override
  State<order_detailos> createState() => _order_detailosState();
}
var orderCard;
class _order_detailosState extends State<order_detailos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios, size: 18, color: Colors.white,),),
        title: Text("Order Details"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      bottomSheet:  FutureBuilder<List<schedul>>(
          future: UpcomingAppot(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount:1 ,
                shrinkWrap: true,
                itemBuilder:(context, index) {
                  return
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(top: 6, bottom: 6, left: 10, right: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(width: 0.1, color: Colors.black54)
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Order Status: ",style: TextStyle(fontSize: 18, color:Colors.black54)),
                                Container(
                                  width: MediaQuery.of(context).size.width/1.7,
                                  child:widget.status=="1"? Text("Order Accepted",
                                    softWrap: true,
                                    style: TextStyle(fontSize: 18, color:Colors.green,),):
                                  widget.status=="2"? Text("Order Processing",
                                    softWrap: true,
                                    style: TextStyle(fontSize: 18, color:Colors.green,),):
                                  widget.status=="4"? Text("Order Pickup",
                                    softWrap: true,
                                    style: TextStyle(fontSize: 18, color:Colors.green,),):
                                  widget.status=="0"? Text("Order Waiting",
                                    softWrap: true,
                                    style: TextStyle(fontSize: 18, color:Colors.green,),):
                                      widget.status=="15"?Text(
                                        softWrap: true,
                                        "Rejected", style: TextStyle(color: Colors.red, fontSize: 18),):
                                      Text("")
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            padding: EdgeInsets.only(top: 6, bottom: 6, left: 10, right: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(width: 0.1, color: Colors.black54)
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Address: ",style: TextStyle(fontSize: 18, color:Colors.black54)),
                                SizedBox(height: 3,),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(snapshot.data![index].address.toString(),
                                    softWrap: true,
                                    style: TextStyle(fontSize: 15, color:Colors.black,),),
                                ),

                              ],
                            ),
                          ),
                          SizedBox(height: 10,),

                          // Text("Total Cost:", style: TextStyle(fontSize: 20),),
                          Container(
                            padding: EdgeInsets.only(top: 6, bottom: 6, left: 10, right: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(width: 0.1, color: Colors.black54)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Order Date & Time: ",style: TextStyle(fontSize: 15, color:Colors.black54)),
                                Text(snapshot.data![index].date_time.toString(), style: TextStyle(fontSize: 15, color:Colors.black),),

                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              snapshot.data![index].url==null?GestureDetector(
                                onTap:(){
                                  orderCard=true;

                                },
                                child: Container(
                                  decoration:BoxDecoration(
                                      border: Border.all(width: 0.5,color:Colors.black26),
                                      borderRadius: BorderRadius.circular(3)
                                  ),
                                  // margin:EdgeInsets.only(right: 10, bottom: 10),
                                  padding:EdgeInsets.all(3),
                                  child:Text("Track Order", style: TextStyle(fontSize: 18.3, color:Colors.black26),),
                                ),
                              ):GestureDetector(
                                onTap:()
                                async {
                                  final url =snapshot.data![index].url.toString();
                                  if (await canLaunch(url)) {
                                    await launch(url, forceWebView: true, enableJavaScript: true);
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
                                  child:Text("Track Order", style: TextStyle(fontSize: 25, color:Theme.of(context).primaryColor),),
                                ),
                              ),
                              Container(
                                decoration:BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                    border: Border.all(width: 0.5,color:Colors.black54),
                                    borderRadius: BorderRadius.circular(3)
                                ),
                                // margin:EdgeInsets.only(right: 10, bottom: 10),
                                padding:EdgeInsets.only(left: 5, right: 5, top: 2, bottom: 2),
                                child:Text(snapshot.data![index].paymode.toString().toUpperCase(), style: TextStyle(fontSize: 25, color:Colors.white),),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(width: 1, color: Colors.black54)
                            ),
                            padding: EdgeInsets.only(top: 6, bottom: 6, left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Total Cost:", style: TextStyle(fontSize: 20,color:Colors.black54),),
                                Text("₹ "+widget.amount, style: TextStyle(fontSize: 25, color: Theme.of(context).primaryColor),),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                }
            ):Container(child: Text("order detail not available"),);
          }),
      body: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                // margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(8),
                child: Text("List of Items ", style: TextStyle(fontSize: 25, ),),
              ),
              // Divider(thickness: 1, color: Colors.black38,),
              FutureBuilder<List<schedul>>(
                future: UpcomingAppot(),
               builder: (context, snapshot) {
               if (snapshot.hasError) print(snapshot.error);
               return snapshot.hasData
              ? ListView.builder(
               physics: NeverScrollableScrollPhysics(),
                itemCount:snapshot.data!.length ,
               shrinkWrap: true,
               itemBuilder:(context, index) {
               return
               Column(
                children: [
                InkWell(
                  child: Container(
                    decoration:BoxDecoration(
                      border: Border.all(width: 0.3, color: Colors.black38),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.black12.withOpacity(0.01),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 12),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage("https://app.healthcrad.com/api/uploads/medicine/"+snapshot.data![index].image.toString()),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // height: 75,
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width/1.5,
                                  child: Text(
                                    snapshot.data![index].name.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(
                                        fontSize:MediaQuery.of(context).size.width*0.038, color:Colors.black,),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Text("₹ "+snapshot.data![index].baseprice.toString()+".00",
                                    textAlign: TextAlign.right,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                        fontSize: 13.7,
                                        decoration: TextDecoration.lineThrough)),
                                Text( "  off "+snapshot.data![index].mdiscount.toString()+"%",
                                    textAlign: TextAlign.right,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                        fontSize: 16.7,
                                        fontWeight: FontWeight.w600, color: Colors.green)),
                                Text("   ₹ "+snapshot.data![index].discountedprice.toString()+".00",
                                    textAlign: TextAlign.right,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                        fontSize: 16.7,
                                        fontWeight: FontWeight.w600)),

                              ],
                            ),
                                                    SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: [
                                Text("Quantity: "+snapshot.data![index].mquantity.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(
                                        fontWeight:
                                        FontWeight.normal)),
                                SizedBox(
                                  width: 15,
                                ),

                              ],
                            ),
                          ],
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 10,)
              ],
            );
        }
    ):Container(child: Text("order detail not available"),);
    }),

              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
  Future<List<schedul>> UpcomingAppot() async{
    final prefs = await SharedPreferences.getInstance();
    final key = 'user_id';
    final user_id = prefs.getString(key) ?? 0;
    final response = await http.get(
      Uri.parse('https://app.healthcrad.com/api/index.php/api/Check_out/view_item?groupid='+widget.groupid),
    );
    var jsond = json.decode(response.body)["country"];
    print(jsond);
    List<schedul> allround = [];
    for (var o in jsond)  {
      schedul al = schedul(
        o["id"],
        o["productid"],
        o["user_id"],
        o["amount"],
        o["date_time"],
        o["discount"],
        o["groupid"],
        o["paymode"],
        o["status"],
        o["transactionid"],
        o["description"],
        o["name"],
        o["image"],
        o["baseprice"],
        o["mquantity"],
        o["mdiscount"],
        o["discountedprice"],
        o["address"],
        o["url"],
      );

      allround.add(al);
    }
    return allround;
  }
}
class schedul {
  String? id;
  String? productid;
  String? user_id;
  String? amount;
  String? date_time;
  String? discount;
  String? groupid;
  String? paymode;
  String? status;
  String? transactionid;
  String? description;
  String? name;
  String? image;
  String? baseprice;
  String? mquantity;
  String? mdiscount;
  String? discountedprice;
  String? address;
  String? url;
  schedul(
      this.id,
      this.productid,
      this.user_id,
      this.amount,
      this.date_time,
      this.discount,
      this.groupid,
      this.paymode,
      this.status,
      this.transactionid,
      this.description,
      this.name,
      this.image,
      this.baseprice,
      this.mquantity,
      this.mdiscount,
      this.discountedprice,
      this.address,
      this.url,
      );

}
