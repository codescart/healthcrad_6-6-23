// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:healthcrad_user/BottomNavigation/Doctors/doctor_info.dart';
// import 'package:healthcrad_user/BottomNavigation/Medicine/medicine_info.dart';
// import 'package:http/http.dart' as http;
//
// class doctor_search extends StatefulWidget {
//   doctor_search() : super();
//
//   @override
//   doctor_searchState createState() => doctor_searchState();
// }
//
// class Debouncer {
//   int? milliseconds;
//   VoidCallback? action;
//   Timer? timer;
//
//   run(VoidCallback action) {
//     if (null != timer) {
//       timer!.cancel();
//     }
//     timer = Timer(
//       Duration(milliseconds: Duration.millisecondsPerSecond),
//       action,
//     );
//   }
// }
//
// class doctor_searchState extends State<doctor_search> {
//   final _debouncer = Debouncer();
//
//   List<Subject> ulist = [];
//   List<Subject> userLists = [];
//   //API call for All Subject List
//
//   String url = 'https://app.healthcrad.com/api/index.php/api/Mobile_app/doctor';
//
//   Future<List<Subject>> getAllulistList() async {
//     try {
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//
//         List<Subject> list = parseAgents(response.body);
//         return list;
//       } else {
//         throw Exception('Error');
//       }
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }
//
//   static List<Subject> parseAgents(String responseBody) {
//     final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
//     return parsed.map<Subject>((json) => Subject.fromJson(json)).toList();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     getAllulistList().then((subjectFromServer) {
//       setState(() {
//         ulist = subjectFromServer;
//         userLists = ulist;
//       });
//     });
//   }
//
//   //Main Widget
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         leading:IconButton(onPressed: () { Navigator.pop(context); }, icon: Icon(Icons.arrow_back_ios, size: 16, color: Colors.white,),),
//         //
//         backgroundColor: Theme.of(context).primaryColor,
//         title: Text(
//           "Search Doctor",
//           style: TextStyle(),
//         ),
//       ),
//       body: Column(
//         children: <Widget>[
//           //Search Bar to List of typed Subject
//           Container(
// //             padding: EdgeInsets.all(15),
// //             child:Container(
// //               decoration: BoxDecoration(
// //                 boxShadow: [
// //                   BoxShadow(
// //                       offset: Offset(0,2),
// //                       color: Colors.grey.shade600.withOpacity(0.6),
// //                       spreadRadius: 0, blurRadius: 3
// //                   )
// //                 ],
// //                 borderRadius: BorderRadius.circular(25.0),
// //               ),
// //               child: TextField(
// //                 autofocus: true,
// //                 textInputAction: TextInputAction.search,
// //                 decoration: InputDecoration(
// //                   fillColor:Colors.white,
// //                   filled: true,
// //                   enabledBorder: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(25.0),
// //                     borderSide: BorderSide.none,
// //                   ),
// //                   focusedBorder: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(20.0),
// //                     borderSide: BorderSide(
// //                       color: Colors.blue,
// //                     ),
// //                   ),
// //                   suffixIcon: InkWell(
// //                     child: Icon(Icons.search),
// //                   ),
// //                   contentPadding: EdgeInsets.all(15.0),
// //                   hintText: 'Search ',
// //                 ),
// //                 onChanged: (string) {
// //                   _debouncer.run(() {
// //                     setState(() {
// //                       userLists = ulist.where((u) =>
// //                       (u.dname.toLowerCase().contains(string.toLowerCase()
// //                         ,))|| u.city.toLowerCase().contains(string.toLowerCase())
// //                         || u.department_name.toLowerCase().contains(string.toLowerCase())
// //                         ,).toList();
// //                     });
// //                   });
// //                 },
// //               ),
// //             ),
// //           ),
//           Expanded(
//             child: ListView.builder(
//               shrinkWrap: true,
//               physics: ClampingScrollPhysics(),
//               padding: EdgeInsets.all(5),
//               itemCount: userLists.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return GestureDetector(
//                   onTap: (){
//                     Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorInfo(
//                       name: userLists[index].dname.toString(),
//                       img_url:userLists[index].img_url.toString(),
//                       profile:userLists[index].profile.toString() ,
//                       Exp:userLists[index].Exp.toString(),
//                       Fees: userLists[index].Fees.toString(),
//                       department_name:userLists[index].department.toString(),
//                       id:userLists[index].id.toString(), city: userLists[index].city.toString(),
//                     )));
//                   },
//                   child: Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.all(5.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           ListTile(
//                             leading:Container( height:100, width: 100,
//                                 child:userLists[index].img_url==null?Container(): Image.network("https://app.healthcrad.com/upload/"+ userLists[index].img_url, width: 100,)),
//                             title: Text(
//                               userLists[index].dname.toString(),
//                               style: TextStyle(fontSize: 16),
//                             ),
//                             subtitle: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                     userLists[index].profile ?? "",
//                                   style: TextStyle(fontSize: 13),
//                                 ),
//                                 Text(
//                                   userLists[index].city ?? "",
//                                   style: TextStyle(fontSize: 14),
//                                 ),
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// //Declare Subject class for json data or parameters of json string/data
// //Class For Subject
// class Subject {
//   var id;
//   var img_url;
//   var dname;
//   var email;
//   var address;
//   var phone;
//   var department;
//   var profile;
//   var Exp;
//   var Fees;
//   var ion_user_id;
//   var hospital_id;
//   var department_name;
//   var city;
//   Subject({
//     required this.id,
//     required this.img_url,
//     required this.dname,
//     required this.email,
//     required this.address,
//     required this.phone,
//     required this.department,
//     required this.profile,
//     required this.Exp,
//     required this.Fees,
//     required this.ion_user_id,
//     required this.hospital_id,
//     // required this.effects,
//     required this.department_name,
//     required this.city,
//   });
//
//   factory Subject.fromJson(Map<dynamic, dynamic> json) {
//     return Subject(
//       id: json['id'],
//       img_url: json['img_url'],
//       dname: json['dname'],
//       email: json['email'],
//       address: json['address'],
//       phone: json['phone'],
//       department: json['department'],
//       profile: json['profile'],
//       Exp: json['Exp'],
//       Fees: json['fees'],
//       ion_user_id: json['ion_user_id'],
//       hospital_id: json['hospital_id'],
//       department_name: json['department_name'],
//       city: json['city'],
//     );
//   }
// }

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

class doctor_search extends StatefulWidget {
  @override
  _doctor_searchState createState() => _doctor_searchState();
}

class _doctor_searchState extends State<doctor_search> {
  TextEditingController  search= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height/5,
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
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 2),
                              color: Colors.grey.shade600.withOpacity(0.6),
                              spreadRadius: 0,
                              blurRadius: 3)
                        ],
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: TextField(
                        controller: search,
                        autofocus: true,
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                          suffixIcon: InkWell(
                            child: Icon(Icons.search),
                          ),
                          contentPadding: EdgeInsets.all(15.0),
                          hintText: 'Search ',
                        ),
                        onChanged: (value) {
                          setState(() {
                            medicine();
                          });

                        },
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                              RichText(
                                                  text: TextSpan(
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .subtitle2,
                                                      children: <TextSpan>[
                                                    TextSpan(
                                                        text: snapshot
                                                                .data![index]
                                                                .name
                                                                .toString() +
                                                            '\n',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                                color: black2,
                                                                height: 1.7)),
                                                    TextSpan(
                                                        text:
                                                            snapshot
                                                                .data![index]
                                                                .profile
                                                                .toString() ,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .black54,
                                                            )),
                                                  ])),
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
                                                    snapshot.data![index].exp
                                                            .toString() +
                                                        " years",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle1!
                                                        .copyWith(fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "City: ",
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
                                                    snapshot.data![index].city
                                                        .toString() ,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle1!
                                                        .copyWith(fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          Container(
                                            padding: EdgeInsets.only(right: 10),
                                            height: 50,
                                            alignment: Alignment.topRight,
                                            child: Text(
                                              'Fees: ' +
                                                  '\₹' +
                                                  snapshot.data![index].fees
                                                      .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1!
                                                  .copyWith(fontSize: 15),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text("Specilities : "+snapshot.data![index].department.toString().substring(2), style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),),
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
                                                                .exp
                                                                .toString(),
                                                            Fees: snapshot
                                                                .data![index]
                                                                .fees
                                                                .toString(),
                                                            department_name:
                                                                snapshot
                                                                    .data![index]
                                                                    .name
                                                                    .toString(),
                                                            id: snapshot
                                                                .data![index].id
                                                                .toString(),
                                                            about: snapshot
                                                                .data![index].about
                                                                .toString(), city: snapshot.data![index].city.toString(),
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
                                                style: TextStyle(fontSize: 14),
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
                                                                .exp
                                                                .toString(),
                                                            Fees: snapshot
                                                                .data![index]
                                                                .fees
                                                                .toString(),
                                                            department_name:
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .name
                                                                    .toString(),
                                                            id: snapshot
                                                                .data![index].id
                                                                .toString(),
                                                            city: snapshot
                                                                .data![index]
                                                                .city
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
    // final catgId = widget.catid;
    final response = await http.get(
      Uri.parse(
          'https://app.healthcrad.com/api/index.php/api/Mobile_app/doctor?search=${search.text}'),
    );

    var jsond = json.decode(response.body)["data"];
    List<doctor> allround = [];
    for (var o in jsond) {
      doctor al = doctor(
        o["id"],
        o["img_url"],
        o["dname"],
        o["email"],
        o["address"],
        o["phone"],
        o["profile"],
        o["department"],
        o["city"],
        o["landmark"],
        o["exp"],
        o["fees"],
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
  String? profile;
  String? department;
  String? city;
  String? landmark;
  String? exp;
  String? fees;
  String? about;

  doctor(
    this.id,
    this.img_url,
    this.name,
    this.email,
    this.address,
    this.phone,
    this.profile,
    this.department,
    this.city,
    this.landmark,
    this.exp,
    this.fees,
    this.about,
  );
}
