import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:healthcrad_user/BottomNavigation/Doctors/doctor_search.dart';
import 'package:healthcrad_user/BottomNavigation/Medicine/allmedi.dart';
import 'package:healthcrad_user/BottomNavigation/Medicine/home_medicine_view.dart';
import 'package:healthcrad_user/BottomNavigation/Medicine/medicines.dart';
import 'package:healthcrad_user/BottomNavigation/Medicine/my_cart.dart';
import 'package:healthcrad_user/BottomNavigation/Medicine/offers.dart';
import 'package:healthcrad_user/BottomNavigation/Medicine/shop_by_category_page.dart';
import 'package:healthcrad_user/BottomNavigation/all_categry.dart';
import 'package:healthcrad_user/Components/title_row.dart';
import 'package:healthcrad_user/Locale/locale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthcrad_user/Pages/emergency/emergency_ui.dart';
import 'package:healthcrad_user/apiconstant.dart';
import 'package:healthcrad_user/razor_pay.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';


class MedicinePage extends StatefulWidget {
  @override
  _MedicinePageState createState() => _MedicinePageState();
}

class _MedicinePageState extends State<MedicinePage> {
  @override
  void initState() {
    banner();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Builder(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height*0.18,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 0.5, color: Colors.black26)
              )
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
                              width:70,
                              child: Image.asset("assets/doctor_logo.png")),
                          Container(
                            height: 50,
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
                            IconButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>CartPage()));
                            }, icon: Icon(Icons.shopping_cart_outlined, color: Colors.black,size: 30,)),
                          IconButton(onPressed: (){
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>apitest()));
                          }, icon: Icon(Icons.notifications_none_outlined, color: Colors.black,size: 30,))
                          ],
                        ) ,
                      )
                    ],
                  ),
                  SizedBox(height: 15,),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>doctor_search()));
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
               SizedBox(height: 10,),

                ],
              )
          ),
          // backgroundColor: Theme.of(context).primaryColor,
          titleSpacing: 20,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                // height: 130,
                child: CarouselSlider(
                  items: state_data.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Padding(
                          padding:  EdgeInsets.only(left: 10, right: 10),
                          child: GestureDetector(
                            onTap: () async {
                              final url =i['url'].toString();
                              if (await canLaunch(url)) {
                                await launch(url, forceWebView: true, enableJavaScript: true);
                              }
                              else {
                                throw 'Could not launch $url';
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                  image: NetworkImage("https://app.healthcrad.com/api//uploads/advertisement/"+i['image']),
                                  // image: NetworkImage("https://app.healthcrad.com/api//uploads/advertisement/firstbanner.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                    // $i'
                  }).toList(),
                  options: CarouselOptions(
                    // height: MediaQuery.of(context).size.height * 1,
                    aspectRatio: 12/ 4,
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 5),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    // onPageChanged: callbackFunction,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                height: 113,
                child: categry(),
              ),
              TitleRow(
                  locale.shopByCategory, () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ShopByCategoryPage()));
              }),
              Container(
                height: 124,
                child: FutureBuilder<List<DAlbum>>(
                    future: bow(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) print(snapshot.error);
                      return snapshot.hasData
                          ?
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MedicinesPage(category:'${snapshot.data![index].id}',name:'${snapshot.data![index].category}')));
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              height:180,
                              width: 100,
                              child: Card(
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        image:  DecorationImage(
                                            image: NetworkImage("https://app.healthcrad.com/api/uploads/"+snapshot.data![index].image.toString()),
                                            fit: BoxFit.cover)
                                    ),
                                    // child: Container(
                                    //     padding: EdgeInsets.only(top: 40,left: 15),
                                    //     child: Text('${snapshot.data![index].category}', style: TextStyle(color: Colors.black,fontSize: 14),maxLines: 2,)
                                    // )
                                ),
                              ),
                            ),
                          );
                        }):Center(child: Text('Medicine Not Available'));
                  }
                ),
              ),
              TitleRow(locale.offers, () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OffersPage()));
              }),
              Container(
                height: 108,
                child: FutureBuilder<List<slider>>(
                    future: bowe(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) print(snapshot.error);
                      return snapshot.hasData
                          ? ListView.builder(
                          shrinkWrap: true,
                           padding: EdgeInsets.symmetric(horizontal: 20),
                           physics: BouncingScrollPhysics(),
                           scrollDirection: Axis.horizontal,
                           itemCount: snapshot.data!.length,
                           itemBuilder: (context, index) {
                           return Padding(
                            padding: EdgeInsetsDirectional.only(end: 20),
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => OffersPage()));
                                },
                                child: Container(
                                  width: 300,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                      image: NetworkImage("https://app.healthcrad.com/api/uploads/advertisement/"+snapshot.data![index].images),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )),
                          );
                        }): Center(child: Text("loading..."));
                  }
                ),
              ),
              TitleRow("Medicines", () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Medicinesall()));
              }),
              Container(
                // height: MediaQuery.of(context).size.height*0.3,
                  child:view_home_medicine()
              ),
            ],
          ),
        ),
      );
    });
  }
  List state_data = [];
  Future<String> banner() async {
    print("vvvvv");
    final res = await http
        .get(Uri.parse("https://app.healthcrad.com/api/index.php/api/Mobile_app/getbanner"));
    final resBody = json.decode(res.body)["data"];
    print("hhhhhhhhhhhhh");
    print(resBody);
    setState(() {
      state_data = resBody;
    });
    return "Sucess";
  }

}


class DAlbum {
  String ?id;
  String ?category;
  String ?description;
  String ?hospital_id;
  String ?image;
  DAlbum(
      this.id,
      this.category,
      this.description,
      this.hospital_id,
      this.image
      );
}
Future<List<DAlbum>> bow() async{
  final response = await http.get(
    Uri.parse(Api.baseurl+'medicalcategory'),
  );
  var jsond = json.decode(response.body)["data"];
  print(jsond);
  print("jjjjjjjjjjjjjjj");
  List<DAlbum> allround = [];
  for (var o in jsond)  {
    DAlbum al = DAlbum(
      o["id"],
      o["category"],
      o["description"],
      o["hospital_id"],
      o["image"],
    );
    allround.add(al);
  }
  return allround;
}

class slider {
  String images;
  slider(this.images);
}
Future<List<slider>> bowe() async{
  final response = await http.get(
    Uri.parse(Api.baseurl+'offerslider'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
  var jsond = json.decode(response.body)["data"];
  print("saaaaaa");
  print(jsond);
  List<slider> allround = [];
  for (var o in jsond)  {
    slider al = slider(
      o["image"],
    );
    allround.add(al);
  }
  return allround;
}
