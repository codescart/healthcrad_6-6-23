import 'dart:convert';
import 'dart:core';
import 'package:healthcrad_user/BottomNavigation/Doctors/doctor_review_page.dart';
import 'package:healthcrad_user/BottomNavigation/Medicine/my_cart.dart';
import 'package:http/http.dart' as http;
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:healthcrad_user/BottomNavigation/Doctors/doctor_info.dart';
import 'package:healthcrad_user/BottomNavigation/Doctors/doctor_search.dart';
import 'package:healthcrad_user/Theme/colors.dart';
import 'package:flutter/material.dart';

class DoctorsPage extends StatefulWidget {
  String catid;
  DoctorsPage({required this.catid});
  @override
  _DoctorsPageState createState() => _DoctorsPageState();
}

class _DoctorsPageState extends State<DoctorsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.16,
          flexibleSpace: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 0.5, color: Colors.black26))),
              padding: EdgeInsets.only(top: 10, left: 10, right: 5, bottom: 5),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                              padding: EdgeInsets.only(left: 5, right: 5),
                              width: 70,
                              child: Image.asset("assets/doctor_logo.png")),
                          Container(
                            height: 50,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Health",
                                      style: TextStyle(
                                        fontSize: 21.5,
                                        color: Color(0xff084fa1),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      "CRAD",
                                      style: TextStyle(
                                        fontSize: 20.5,
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "Save More, Serve More",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CartPage()));
                                },
                                icon: Icon(
                                  Icons.shopping_cart_outlined,
                                  color: Colors.black,
                                  size: 30,
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => doctor_search()));
                    },
                    child: Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width / 1.1,
                      padding: EdgeInsets.only(left: 10, right: 10),
                      margin: EdgeInsets.only(left: 15, right: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 2),
                              color: Colors.grey.shade600.withOpacity(0.6),
                              spreadRadius: 0,
                              blurRadius: 3)
                        ],
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Search",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          Icon(
                            Icons.search,
                            size: 25,
                            color: Colors.black,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )),
          titleSpacing: 20,
          automaticallyImplyLeading: false,
        ),
        body: FadedSlideAnimation(
          Container(
            height: double.infinity,
            color: Theme.of(context).backgroundColor,
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
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
                                return Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 1,
                                          color:
                                              Theme.of(context).primaryColor)),
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  padding: EdgeInsets.only(
                                      top: 10, left: 5, right: 5, bottom: 10),
                                  margin: EdgeInsets.only(
                                      left: 5, right: 5, bottom: 5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            radius: 35,
                                            backgroundImage: NetworkImage(
                                                "https://app.healthcrad.com/upload/" +
                                                    snapshot
                                                        .data![index].img_url
                                                        .toString()),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                   snapshot
                                                      .data![index]
                                                      .name
                                                      .toString() ,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                      color: black2,
                                                  )),
                                              Text(
                                                   snapshot
                                                      .data![index]
                                                      .dname
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                    fontSize: 12.5,
                                                    color: Color(
                                                        0xff999999),
                                                  )),
                                              SizedBox(height: 3,),
                                              Container(
                                                width:MediaQuery.of(context).size.width/1.5,
                                                child: Text(
                                                    "("+ snapshot
                                                        .data![index]
                                                        .profile
                                                        .toString()+")",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                      fontSize: 10,
                                                      color: Colors.black54,

                                                    )),
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Experience: ",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle2!
                                                        .copyWith(
                                                            color: Theme.of(
                                                                    context)
                                                                .disabledColor,
                                                            fontSize: 12),
                                                  ),
                                                  Text(
                                                    snapshot.data![index].Exp
                                                            .toString() +
                                                        " years",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle1!
                                                        .copyWith(fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Fees: ",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle2!
                                                        .copyWith(
                                                        color: Theme.of(
                                                            context)
                                                            .disabledColor,
                                                        fontSize: 12),
                                                  ),
                                                  Text(
                                                    snapshot.data![index].fees
                                                        .toString(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle1!
                                                        .copyWith(fontSize: 14, color: Theme.of(context).primaryColor),
                                                  ),

                                                ],
                                              ),
                                              Text("Address: "+
                                                  snapshot.data![index].city
                                                      .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1!
                                                    .copyWith(fontSize: 12, color: Colors.grey),
                                                maxLines: 1,
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DoctorReviewPage(
                                                            img_url: snapshot
                                                                .data![index]
                                                                .img_url
                                                                .toString(),
                                                            name: snapshot
                                                                .data![index]
                                                                .name
                                                                .toString(),
                                                            profile: snapshot
                                                                .data![index]
                                                                .profile
                                                                .toString(),
                                                            Exp: snapshot
                                                                .data![index]
                                                                .Exp
                                                                .toString(),
                                                            Fees: snapshot
                                                                .data![index]
                                                                .fees
                                                                .toString(),
                                                            department_name:
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .dname
                                                                    .toString(),
                                                            id: snapshot
                                                                .data![index].id
                                                                .toString(),
                                                            about: snapshot
                                                                .data![index].about
                                                                .toString(),
                                                            city:snapshot.data![index].city.toString()
                                                          )));
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  left: 5, right: 5),
                                              alignment: Alignment.center,
                                              width: 100,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Colors.black),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Text(
                                                "View Profile",
                                                style: TextStyle(fontSize: MediaQuery.of(context).size.width/25 ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DoctorInfo(
                                                            img_url: snapshot
                                                                .data![index]
                                                                .img_url
                                                                .toString(),
                                                            name: snapshot
                                                                .data![index]
                                                                .name
                                                                .toString(),
                                                            profile: snapshot
                                                                .data![index]
                                                                .profile
                                                                .toString(),
                                                            Exp: snapshot
                                                                .data![index]
                                                                .Exp
                                                                .toString(),
                                                            Fees: snapshot
                                                                .data![index]
                                                                .fees
                                                                .toString(),
                                                            department_name:
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .dname
                                                                    .toString(),
                                                            id: snapshot
                                                                .data![index].id
                                                                .toString(),
                                                            city: snapshot
                                                                .data![index].city
                                                                .toString(),
                                                            about: snapshot
                                                                .data![index].about
                                                                .toString(),
                                                          )));
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  left: 5, right: 5),
                                              alignment: Alignment.center,
                                              width: 100,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Colors.black),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Text(
                                                "Book Now",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                            ));
                    })
              ],
            ),
          ),
          beginOffset: Offset(0, 0.3),
          endOffset: Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
        ));
  }

  Future<List<doctor>> medicine() async {
    final catgId = widget.catid;
    final response = await http.get(
      Uri.parse(
          'https://app.healthcrad.com/api/index.php/api/Mobile_app/department_list?id=$catgId'),
    );

    var jsond = json.decode(response.body)["data"];
    List<doctor> allround = [];
    for (var o in jsond) {
      doctor al = doctor(
        o["id"],
        o["img_url"],
        o["name"],
        o["email"],
        o["address"],
        o["phone"],
        o["department"],
        o["profile"],
        o["Exp"],
        o["fees"],
        o["dname"],
        o["city"],
        o["about"],
      );
      allround.add(al);
    }
    return allround;
  }
}

class doctor {
  String? id;
  String? img_url;
  String? name;
  String? email;
  String? address;
  String? phone;
  String? department;
  String? profile;
  String? Exp;
  String? fees;
  String? dname;
  String? city;
  String? about;

  doctor(
    this.id,
    this.img_url,
    this.name,
    this.email,
    this.address,
    this.phone,
    this.department,
    this.profile,
    this.Exp,
    this.fees,
    this.dname,
    this.city,
    this.about,
  );
}
