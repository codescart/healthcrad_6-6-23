import 'dart:convert';
import 'dart:core';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:healthcrad_user/BottomNavigation/Doctors/doctor_info.dart';
import 'package:healthcrad_user/Locale/locale.dart';
import 'package:healthcrad_user/Routes/routes.dart';
import 'package:healthcrad_user/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;

class SearchDoctors extends StatefulWidget {
  final String dcat;
  SearchDoctors({Key? key, required this.dcat}) : super(key: key);
  @override
  _SearchDoctorsState createState() => _SearchDoctorsState();
}


class _SearchDoctorsState extends State<SearchDoctors> {


  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    return Scaffold(
      body: FadedSlideAnimation(
        ListView(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 15, right: 15),
              child: TextFormField(
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 14.5),
                // initialValue: '',
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none),
                  hintText: locale.searchDoc,
                  filled: true,
                  fillColor: Theme.of(context).backgroundColor,
                  prefixIcon: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      Navigator.pushNamed(
                          context, PageRoutes.searchHistoryPage);
                    },
                  ),
                ),
              ),
            ),
            // Container(
            //   color: Theme.of(context).backgroundColor,
            //   padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            //   margin: EdgeInsets.only(top: 15),
            //   child: Text(
            //     '27 ' + locale.resultsFound!,
            //     style: Theme.of(context)
            //         .textTheme
            //         .bodyText1!
            //         .copyWith(color: Color(0xffacacac)),
            //   ),
            // ),
        FutureBuilder<List<Album>>(
             future: bow(),
             builder: (context, snapshot) {
             if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                   ? ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 18.0, left:8.0, right: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorInfo(
                                      img_url: snapshot.data![index].img_url,
                                      Fees: snapshot.data![index].Fees,
                                      profile: snapshot.data![index].profile,
                                      department_name: snapshot.data![index].department_name,
                                      Exp: snapshot.data![index].Exp,
                                      name: snapshot.data![index].name,
                                      id:'', city:snapshot.data![index].city,
                                        about: snapshot
                                            .data![index].about
                                            .toString(),
                                      )));
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 80,
                                        width: 80,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          image: DecorationImage(
                                            image: NetworkImage("https://flaphealth.foundercodes.com/api/upload/"+snapshot.data![index].img_url,),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        ),
                                      SizedBox(width: 15,),
                                      Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 12,
                                            ),
                                            RichText(
                                                text: TextSpan(
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle2,
                                                    children: <TextSpan>[
                                                  TextSpan(
                                                      text:
                                                          'Dr.'+snapshot.data![index].name + '\n',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                              color: black2,
                                                              height: 1.7)),
                                                  TextSpan(
                                                      text: snapshot.data![index].profile+'\n',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                            fontSize: 11.2,
                                                            color:
                                                                Color(0xff999999),
                                                          )),
                                                  TextSpan(
                                                      text: snapshot.data![index].department_name+' '+'Department',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                            fontSize: 11.2,
                                                            color:
                                                                Color(0xffcccccc),
                                                          )),
                                                  // TextSpan(
                                                  //     text: searchList[index].hospital,
                                                  //     style: Theme.of(context)
                                                  //         .textTheme
                                                  //         .bodyText1!
                                                  //         .copyWith(
                                                  //           fontSize: 11.2,
                                                  //           color: Color(0xff999999),
                                                  //         )),
                                                ])),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  locale.exp!  +snapshot.data![index].Exp+locale.years!,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                          color:
                                                              Color(0xff979797),
                                                          fontSize: 10),
                                                ),
                                                // Text(
                                                //   searchList[index].experience +
                                                //       locale.years!,
                                                //   style: Theme.of(context)
                                                //       .textTheme
                                                //       .bodyText1!
                                                //       .copyWith(fontSize: 10),
                                                // ),
                                                SizedBox(
                                                  width: 12,
                                                ),
                                                Text(
                                                  locale.fee!  +'₹'  +snapshot.data![index].Fees,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                          color:
                                                              Color(0xff979797),
                                                          fontSize: 10),
                                                ),
                                                // Text(
                                                //   '\$' + searchList[index].fee,
                                                //   style: Theme.of(context)
                                                //       .textTheme
                                                //       .bodyText1!
                                                //       .copyWith(fontSize: 10),
                                                // ),
                                                SizedBox(
                                                  width: 35,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                height: 6,
                                thickness: 6,
                                color: Theme.of(context).backgroundColor,
                              ),
                            ],
                          ),
                          PositionedDirectional(
                            bottom: 28,
                            end: 4,
                            child: Row(
                              children: [
                                RatingBar.builder(
                                    unratedColor: Color(0xff979797),
                                    itemSize: 12,
                                    initialRating: 4,
                                    direction: Axis.horizontal,
                                    itemCount: 5,
                                    itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                    onRatingUpdate: (rating) {
                                    }),
                                SizedBox(
                                  width: 4,
                                ),
                                // Text(
                                //   '(${searchList[index].reviews})',
                                //   style: Theme.of(context)
                                //       .textTheme
                                //       .subtitle2!
                                //       .copyWith(
                                //           fontSize: 10, color: Color(0xff979797)),
                                // ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ):Center(child: Container(child: Text('Loading...'),));
                }
            ),
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }

  Future<List<Album>> bow() async{
    final response = await http.post(
      Uri.parse("https://app.healthcrad.com/api/index.php/api/Mobile_app/doctor"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        // "zone_id":"98",
        // "department":widget.dcat
      }),

    );

    var jsond = json.decode(response.body);
    List<Album> allround = [];
    for (var o in jsond)  {
      Album al = Album(
        o["id"],
        o["img_url"],
        o["name"],
        o["email"],
        o["address"],
        o["phone"],
        o["city"],
        o["about"],

      );

      allround.add(al);
    }
    return allround;
  }
}

class Album {
  String img_url;
  String name;
  String profile;
  String Exp;
  String Fees;
  String department_name;
  String city;
  String about;

  Album(
      this.img_url,
      this.name,
      this.profile,
      this.Exp,
      this.Fees,
      this.department_name,
      this.city,
      this.about,
      );
}

