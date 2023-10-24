import 'dart:convert';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:healthcrad_user/BottomNavigation/bottom_navigation.dart';
import 'package:healthcrad_user/Locale/locale.dart';
import 'package:healthcrad_user/Models/order_card_model.dart';
import 'package:healthcrad_user/BottomNavigation/More/Order/order_info.dart';
import 'package:healthcrad_user/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:healthcrad_user/Routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;

class past{
  String? id;
  String? user_id;
  String? amount;
  String? paymode;
  String? discount;
  String? groupid;
  String? dateTime;
  String? uid;
  String? productid;
  String? quantity;
  String? totalamount;
  String? datetime;
  String? paymod;
  String? name;
  String? price;
  String? image;
  String? status;
  past(
      this.id,
      this.user_id,
      this.amount,
      this.paymode,
      this.discount,
      this.groupid,
      this.dateTime,
      this.uid,
      this.productid,
      this.quantity,
      this.totalamount,
      this.datetime,
      this.paymod,
      this.name,
      this.price,
      this.image,
      this.status
      );

}
class past_order extends StatelessWidget {
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
            icon: Icon(Icons.chevron_left,color: Colors.white)),
        title: Text(
          "Past Order",
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontSize: 17, fontWeight: FontWeight.w700,color: Colors.white),
        ),
        centerTitle: true,
        toolbarTextStyle: Theme.of(context).textTheme.bodyText2,
        titleTextStyle: Theme.of(context).textTheme.headline6,
      ),
      body: FadedSlideAnimation(
        ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child:FutureBuilder<List<past>>(
                  future: pastAppot(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);
                    return snapshot.hasData
                        ? ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => pastOrderCard(snapshot.data![index]),
                    )
                        :Center(child: Text("Orders not available"),);
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

  Future<List<past>> pastAppot() async{
    final prefs = await SharedPreferences.getInstance();
    final key = 'user_id';
    final user_id = prefs.getString(key) ?? 0;
    final response = await http.get(
      Uri.parse('https://app.healthcrad.com/api/index.php/api/Check_out/deliverd_order?user_id=1$user_id'),
    );

    var jsond = json.decode(response.body)["country"];

    List<past> pastlist = [];
    for (var o in jsond)  {
      past al = past(
        o['id'],
        o['user_id'],
        o['amount'],
        o['paymode'],
        o['discount'],
        o['groupid'],
        o['date_time'],
        o['uid'],
        o['productid'],
        o['quantity'],
        o['totalamount'],
        o['datetime'],
        o['paymod'],
        o['name'],
        o['price'],
        o['image'],
        o['status'],
      );

      pastlist.add(al);
    }
    return pastlist;
  }
}


class pastOrderCard extends StatelessWidget {
  final past orderCard;

  pastOrderCard(this.orderCard);

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => OrderInfoPage(orderCard: orderCard)));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Image.asset("assets/doctor_logo.png", height: 40),
            title: Row(
              children: [
                Text(
                  orderCard.name!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: black2, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                orderCard.status=="1"?Text(
                    "confirmed",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 13.5,
                        color: kMainColor
                    )):Text(
                  "Delevered",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 13.5,
                      color:kCompleatColor
                  ),
                ),
              ],
            ),
            subtitle: Row(
              children: [
                Text(
                  orderCard.datetime!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 12, color: Color(0xffb3b3b3)),
                ),
                Spacer(),
                Text(
                    '\₹' + orderCard.amount! + ' | ' + orderCard.paymode!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 12, color: Color(0xffb3b3b3))),
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
          Divider(thickness: 6, height: 0),
        ],
      ),
    );
  }
}

