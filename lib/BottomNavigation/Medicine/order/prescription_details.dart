import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class prescription_detail extends StatefulWidget {
  String id;
  String status;

  prescription_detail({ required this.id, required this.status,});

  @override
  State<prescription_detail> createState() => _prescription_detailState();
}
var orderCard;
class _prescription_detailState extends State<prescription_detail> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 300 ), () {
      print("Yeah, this line is printed immediately");
      getData();
    });

  }

  var data;
  Future<void> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'user_id';
    final user_id = prefs.getString(key) ?? 0;
    final response = await http.post(
      Uri.parse("https://app.healthcrad.com/api/index.php/api/Mobile_app/prescription_order?orderid="+widget.id),
      body: json.encode(
        {
          "id": "$user_id",
        },
      ),
    );
    final datas = jsonDecode(response.body)["data"];
    if (response.statusCode == 200) {
      setState(() {
        data = datas[0];
        print('Got Data');
        print(data);
      });

    } else {
      print('Failed');
    }
  }


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
      body:data !=null? Container(
        padding: EdgeInsets.all(10),
        child:Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 0.5, color: Colors.black),
            image: DecorationImage(
              image: NetworkImage("https://app.healthcrad.com/upload/"+data["images"].toString()),
              fit:BoxFit.cover
            ),
          ),
          // color: Colors.red,
          height: MediaQuery.of(context).size.height/2,
          // child: Image.network("https://app.healthcrad.com/upload/"+data["images"].toString()),
        ) ,
      ):Center(
        child: CircularProgressIndicator(),
      ),
      bottomSheet: data != null? Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                  Text("Name: ",style: TextStyle(fontSize: 18, color:Colors.black54)),
                  Container(
                      // width: MediaQuery.of(context).size.width/1.7,
                      child: Text(data["name"],
                        softWrap: true,
                        style: TextStyle(fontSize: 18, color:Colors.black,),)
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
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
                    alignment: Alignment.centerRight,
                      width: MediaQuery.of(context).size.width/1.7,
                      child:data["status"].toString()=="1"? Text("Order Accepted",
                        softWrap: true,
                        style: TextStyle(fontSize: 18, color:Colors.green,),):
                      data["status"].toString()=="2"? Text("Order Processing",
                        softWrap: true,
                        style: TextStyle(fontSize: 18, color:Colors.green,),):
                      data["status"].toString()=="4"? Text("Order Pickup",
                        softWrap: true,
                        style: TextStyle(fontSize: 18, color:Colors.green,),):
                      data["status"].toString()=="0"? Text("Order Waiting",
                        softWrap: true,
                        style: TextStyle(fontSize: 18, color:Colors.green,),):
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
                    child: Text(data["address"].toString()+", "+data["landmark"].toString()+", "+data["city"].toString()+", "+data["pincode"].toString(),
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
                  Text(data["date_time"].toString(), style: TextStyle(fontSize: 15, color:Colors.black),),

                ],
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                data["url"]==null?GestureDetector(
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
                    final url ="snapshot.data![index].url.toString()";
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
                    child:Text("Track Order", style: TextStyle(fontSize: 20, color:Theme.of(context).primaryColor),),
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
                  child:Text("COD/Offline".toUpperCase(), style: TextStyle(fontSize: 20, color:Colors.white),),
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
                  Text("not avl.", style: TextStyle(fontSize: 25, color: Theme.of(context).primaryColor),),
                ],
              ),
            ),
          ],
        ),
      ):Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
  // Future<List<schedul>> UpcomingAppot() async{
  //   final prefs = await SharedPreferences.getInstance();
  //   final key = 'user_id';
  //   final user_id = prefs.getString(key) ?? 0;
  //   print('https://app.healthcrad.com/api/index.php/api/Mobile_app/prescription_order?orderid='+widget.id);
  //   final response = await http.get(
  //     Uri.parse('https://app.healthcrad.com/api/index.php/api/Mobile_app/prescription_order?orderid='+widget.id),
  //   );
  //   var jsond = json.decode(response.body)["data"];
  //
  //   List<schedul> allround = [];
  //   for (var o in jsond)  {
  //     schedul al = schedul(
  //       o["id"],
  //       o["productid"],
  //       o["user_id"],
  //       o["amount"],
  //       o["date_time"],
  //       o["discount"],
  //       o["groupid"],
  //       o["paymode"],
  //       o["status"],
  //       o["transactionid"],
  //       o["description"],
  //       o["name"],
  //       o["image"],
  //       o["baseprice"],
  //       o["mquantity"],
  //       o["mdiscount"],
  //       o["discountedprice"],
  //       o["address"],
  //       o["url"],
  //     );
  //
  //     allround.add(al);
  //   }
  //   return allround;
  // }
}
// class schedul {
//   String? id;
//   String? productid;
//   String? user_id;
//   String? amount;
//   String? date_time;
//   String? discount;
//   String? groupid;
//   String? paymode;
//   String? status;
//   String? transactionid;
//   String? description;
//   String? name;
//   String? image;
//   String? baseprice;
//   String? mquantity;
//   String? mdiscount;
//   String? discountedprice;
//   String? address;
//   String? url;
//   schedul(
//       this.id,
//       this.productid,
//       this.user_id,
//       this.amount,
//       this.date_time,
//       this.discount,
//       this.groupid,
//       this.paymode,
//       this.status,
//       this.transactionid,
//       this.description,
//       this.name,
//       this.image,
//       this.baseprice,
//       this.mquantity,
//       this.mdiscount,
//       this.discountedprice,
//       this.address,
//       this.url,
//       );
//
// }
