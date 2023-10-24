import 'dart:convert';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:healthcrad_user/Locale/locale.dart';
import 'package:healthcrad_user/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:healthcrad_user/apiconstant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DoctorReviewPage extends StatefulWidget {
  final String img_url;
  final String profile;
  final String Exp;
  final String Fees;
  final String department_name;
  final String id;
  final String name;
  final String about;
  final String city;
  DoctorReviewPage({
    required this.Fees,
    required this.department_name,
    required this.id,
    required this.img_url,
    required this.profile,
    required this.Exp,
    required this.name,
    required this.about, required this.city});

  @override
  _DoctorReviewPageState createState() => _DoctorReviewPageState();
}

class ReviewDetail {
  String image;
  String name;
  String? disease;
  double rating;
  String date;

  ReviewDetail(this.image, this.name, this.disease, this.rating, this.date);
}

class _DoctorReviewPageState extends State<DoctorReviewPage> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height*0.1,
        flexibleSpace: Container(
            decoration: BoxDecoration(
            ),
            padding: EdgeInsets.only(top:10, left: 10, right: 5, bottom: 5),
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
                              Text("HealthCrad",  style: TextStyle(fontSize: 23, color: Colors.black, fontWeight: FontWeight.w700,),),
                              Text("Save More, Serve More",  style: TextStyle(fontSize: 11, color: Colors.black, fontWeight: FontWeight.bold,),),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      // color: Colors.green,
                      child:Row(
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(Icons.shopping_cart_outlined, color: Colors.black,size: 30,)),
                          IconButton(onPressed: (){}, icon: Icon(Icons.notifications_none_outlined, color: Colors.black,size: 30,))
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
        ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 10, right: 10, top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 40,
                    backgroundImage: NetworkImage("https://app.healthcrad.com/upload/"+widget.img_url.toString()),
                  ),
                  SizedBox(width: 10,),
                  Container(
                    width: MediaQuery.of(context).size.width/2.3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Dr. "+widget.name, style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700),),
                        Text(widget.department_name,style: TextStyle(fontSize: 13, color: Colors.black,fontWeight: FontWeight.w400 ),),
                        Text(widget.profile,style: TextStyle(fontSize: 13, color: Colors.black,fontWeight: FontWeight.w400),),
                        // Text(widget.,style: TextStyle(fontSize: 15, color: Colors.black,fontWeight: FontWeight.w400),),
                        Text("Exp: "+widget.Exp+ "years",style: TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.w400),),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    // color: Colors.grey,
                    height: 50,
                    alignment: Alignment.centerRight,
                    // width: MediaQuery.of(context).size.width/2.8,
                    child:  Text(
                      '\₹ ' + widget.Fees,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(fontSize: 18, color: Theme.of(context).primaryColor),
                    ),
                  ),
                ],
              ),
            ),
            Divider(thickness: 1, color: Colors.grey.shade400,),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(width: 1, color: Colors.black.withOpacity(0.2))
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 15, bottom: 10, top: 10),
                    child: Text("About -",style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),),
                  ),
                  Padding(padding: EdgeInsets.only(left: 50, right: 20, bottom: 10),
                    child: Text(widget.about=="null"? "About not available":widget.about,
                      style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w400),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // height: MediaQuery.of(context).size.height/1.7,
              margin: EdgeInsets.only(left: 10,right: 10 , top: 10),
              decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(width: 1, color: Colors.black.withOpacity(0.2))
              ),
              child: Column(
                children: [
                  Container(
                    width:MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      decoration:BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),

                        )
                      ),
                      padding:EdgeInsets.only(top: 5, bottom: 5 ),
                      child: Text("Patient's Reviews", style: TextStyle(fontSize: 22),)
                      ),
                  FutureBuilder<List<Review>>(
                    future: reviews(),
                    builder: (context, snapshot) {
                      return snapshot.hasData?
                        ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Divider(
                                  color: Colors.white,
                                  thickness: 3,
                                ),
                                ListTile(
                                  leading: CircleAvatar(
                                    radius: 18,
                                    backgroundImage:NetworkImage("https://app.healthcrad.com/api/uploads/"+snapshot.data![index].userimage.toString()),
                                  ),
                                  title: Text(
                                    snapshot.data![index].uname.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(fontSize: 13, color: black2),
                                  ),
                                  subtitle: Text(snapshot.data![index].problem.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14.3,
                                        color: Color(0xff4c4c4c),
                                        height: 1.5),
                                  ),
                                ),
                              ],
                            );
                          }):Container(
                          padding: EdgeInsets.only(top: 40),
                          child: Center(child: Text("Reviews not available")));
                    }
                  )
                ],
              ),
            ),


          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
  Future<List<Review>> reviews() async{
    final prefs = await SharedPreferences.getInstance();
    final key = 'user_id';
    final value = prefs.getString(key) ?? 0;
    final response = await http.post(
      Uri.parse(Api.baseurl+'show_feedback'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "docterid":widget.id
      }),
    );

    var jsond = json.decode(response.body)["country"];
    List<Review> allround = [];
    for (var o in jsond)  {
      Review al = Review(
        o["problem"],
        o["userimage"],
        o["review"],
        o["uname"],
        o["datetime"],
      );
      allround.add(al);
    }
    return allround;
  }
}
class Review {
  String? problem;
  String? userimage;
  String? review;
  String? uname;
  String? datetime;

  Review(this.problem,this.userimage,this.review,this.uname,this.datetime,);

}
