import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:healthcrad_user/BottomNavigation/Doctors/reschedule.dart';
import 'package:http/http.dart' as http;
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:healthcrad_user/BottomNavigation/bottom_navigation.dart';
import 'package:healthcrad_user/Locale/locale.dart';
import 'package:healthcrad_user/Routes/routes.dart';
import 'package:healthcrad_user/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class past_appointment extends StatefulWidget {
  @override
  _past_appointmentState createState() => _past_appointmentState();
}

class Appointments {
  String image;
  String name;
  String speciality;
  String hospital;
  String date;
  String time;
  String? reviews;

  Appointments(this.image, this.name, this.speciality, this.hospital, this.date,
      this.time);
}
var app_id;
class _past_appointmentState extends State<past_appointment> {

  final TextEditingController comment=TextEditingController();
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            size: 16, color: Colors.white,
          ),
          onTap:() {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNavigation(pageIndex:3)));
          },
        ),
        title: FadedScaleAnimation(
          Text(
            locale.myAppointments!,
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(fontSize: 17, fontWeight: FontWeight.w700, color: Colors.white),
          ),
          durationInMilliseconds: 400,
        ),
        centerTitle: true,
      ),
      body: Container(
        child: ListView(
          //padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            // Container(
            //   padding: EdgeInsets.only(top: 20, left: 10),
            //   color: Theme.of(context).backgroundColor,
            //   height: 50,
            //   child: Text(locale.upcoming!,
            //       style: Theme.of(context)
            //           .textTheme
            //           .bodyText2!
            //           .copyWith(fontSize: 13.3, color: Color(0xffb3b3b3))),
            // ),
            // Divider(
            //   thickness: 6,
            //   height: 6,
            //   color: Theme.of(context).backgroundColor,
            // ),
            // Container(
            //   height: MediaQuery.of(context).size.height/3,
            //   child: FutureBuilder<List<schedul>>(
            //       future: UpcomingAppot(),
            //       builder: (context, snapshot) {
            //         if (snapshot.hasError) print(snapshot.error);
            //         return snapshot.hasData
            //             ? ListView.builder(
            //           physics: NeverScrollableScrollPhysics(),
            //           shrinkWrap: true,
            //           itemCount: snapshot.data!.length,
            //           itemBuilder: (context, index) {
            //             return Column(
            //               children: [
            //                 Stack(
            //                   children: [
            //                     Padding(
            //                       padding: const EdgeInsets.only(
            //                           bottom: 10.0, left: 10, right: 10),
            //                       child: GestureDetector(
            //                         onTap: () {
            //                           Navigator.pushNamed(
            //                               context, PageRoutes.appointmentDetail);
            //                         },
            //                         child: Row(
            //                           children: [
            //                             Container(
            //                               height:100,width:100,
            //                               decoration: BoxDecoration(
            //                                   image: DecorationImage(
            //                                       image: NetworkImage("https://app.healthcrad.com/upload/"+snapshot.data![index].dimg_url.toString(),
            //                                       ),
            //                                       fit:BoxFit.cover
            //                                   )
            //                               ),
            //                             ),
            //                             SizedBox(
            //                               width: 8,
            //                             ),
            //                             Column(
            //                               crossAxisAlignment: CrossAxisAlignment.start,
            //                               children: [
            //                                 SizedBox(
            //                                   height: 10,
            //                                 ),
            //                                 Text("Doctor: "+
            //                                     snapshot.data![index].dname.toString(),
            //                                   style: Theme
            //                                       .of(context)
            //                                       .textTheme
            //                                       .bodyText1!
            //                                       .copyWith(
            //                                       height: 1.5,
            //                                       fontSize: 15,
            //                                       fontWeight: FontWeight.bold),
            //                                 ),
            //                                 RichText(
            //                                     text: TextSpan(
            //                                         style: Theme
            //                                             .of(context)
            //                                             .textTheme
            //                                             .subtitle2,
            //                                         children: <TextSpan>[
            //                                           TextSpan(
            //                                             text:"${snapshot.data![index].depart}"+",",
            //                                             style: Theme
            //                                                 .of(context)
            //                                                 .textTheme
            //                                                 .bodyText2!
            //                                                 .copyWith(
            //                                                 color: Color(0xff999999),
            //                                                 fontSize: 11.7,
            //                                                 height: 1.5),
            //                                           ),
            //                                           TextSpan(
            //                                             text:snapshot.data![index].dprofile,
            //                                             style: Theme
            //                                                 .of(context)
            //                                                 .textTheme
            //                                                 .bodyText2!
            //                                                 .copyWith(
            //                                                 color: Color(0xff999999),
            //                                                 fontSize: 11.7,
            //                                                 height: 1.5),
            //                                           ),
            //                                         ])),
            //                                 Text("Patient: "+
            //                                     snapshot.data![index].name.toString(),
            //                                   style: Theme
            //                                       .of(context)
            //                                       .textTheme
            //                                       .bodyText1!
            //                                       .copyWith(
            //                                     height: 1.5,
            //                                     fontSize: 14,
            //                                   ),
            //                                 ),
            //                                 SizedBox(
            //                                   height: 18,
            //                                 ),
            //                                 Row(
            //                                   children: [
            //                                     Text(
            //                                       snapshot.data![index].start_time.toString()+
            //                                           ' | ',
            //                                       style: Theme
            //                                           .of(context)
            //                                           .textTheme
            //                                           .subtitle1!
            //                                           .copyWith(
            //                                           fontSize: 13.3,
            //                                           fontWeight: FontWeight.bold),
            //                                     ),
            //                                     Text(
            //                                       snapshot.data![index].week_day.toString(),
            //                                       style: Theme
            //                                           .of(context)
            //                                           .textTheme
            //                                           .subtitle1!
            //                                           .copyWith(
            //                                           fontSize: 13.3,
            //                                           fontWeight: FontWeight.bold),
            //                                     ),
            //                                   ],
            //                                 ),
            //                               ],
            //                             ),
            //                           ],
            //                         ),
            //                       ),
            //                     ),
            //                     PositionedDirectional(
            //                         top: 0,
            //                         end: -5,
            //                         child: PopupMenuButton(
            //                             iconSize: 15,
            //                             icon: Icon(Icons.more_vert,
            //                                 color: Theme
            //                                     .of(context)
            //                                     .primaryColor),
            //                             itemBuilder: (context) =>
            //                             <PopupMenuEntry<dynamic>>[
            //                               PopupMenuItem(
            //                                 child: TextButton(
            //                                   onPressed: () {
            //                                     showDialog(
            //                                         context: context,
            //                                         builder:
            //                                             (BuildContext context ) {
            //                                           return Dialog(
            //                                             shape:RoundedRectangleBorder(
            //                                               borderRadius: BorderRadius.circular(16),
            //                                             ),
            //                                             elevation: 0,
            //                                             backgroundColor: Colors.transparent,
            //                                             child: Container(
            //                                               padding: EdgeInsets.only(top: 10, bottom:10),
            //                                               decoration: BoxDecoration(
            //                                                   borderRadius: BorderRadius.circular(16),
            //                                                   color: Colors.white,
            //                                                   border: Border.all(width: 5, color: Colors.black54)
            //                                               ),
            //                                               width: MediaQuery.of(context).size.width,
            //                                               height: 200,
            //                                               alignment: Alignment.bottomCenter,
            //                                               // margin: EdgeInsets.only(top:MediaQuery.of(context).size.height/1.5),
            //                                               child: Column(
            //                                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //                                                 crossAxisAlignment: CrossAxisAlignment.center,
            //                                                 children: [
            //                                                   Container(
            //                                                     child: Icon(Icons.warning_amber, size: 50, color: Colors.red,),
            //                                                   ),
            //                                                   Container(
            //                                                     padding: EdgeInsets.all(10),
            //                                                     alignment: Alignment.center,
            //                                                     width: MediaQuery.of(context).size.width/1.1,
            //                                                     child:Text("Are you really want to Cancel the selected schedule ?",style: TextStyle(color: Colors.blueGrey,),textAlign: TextAlign.center,
            //                                                     ),
            //                                                   ),
            //                                                   Row(
            //                                                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //                                                     children: [
            //                                                       Container(width: 100, height: 40,
            //                                                         child: ElevatedButton(onPressed: () {
            //                                                           Navigator.pop(context);
            //                                                         },
            //                                                           style: ElevatedButton.styleFrom(
            //                                                               primary: Colors.red
            //                                                           ),
            //                                                           child: Text("Cancel", style: TextStyle(fontSize: 15, color: Colors.white),),),
            //                                                       ),
            //
            //                                                       Container(height: 40, width: 100,
            //                                                         child: ElevatedButton(onPressed: ()
            //                                                         async {
            //                                                           app_id= snapshot.data![index].id;
            //                                                           appointcance(snapshot.data![index].id);
            //                                                         },
            //
            //                                                             style: ElevatedButton.styleFrom(
            //                                                                 primary: Theme.of(context).primaryColor
            //                                                             )
            //                                                             , child: Text("Confirm",style: TextStyle(fontSize: 15),)),
            //                                                       )
            //                                                     ],
            //                                                   ),
            //                                                 ],
            //                                               ),
            //                                             ),
            //                                           );
            //                                         }
            //                                     );
            //                                   },
            //                                   child: Text("Cancel",
            //                                     style: Theme
            //                                         .of(context)
            //                                         .textTheme
            //                                         .bodyText1!
            //                                         .copyWith(
            //                                         fontSize: 15,
            //                                         fontWeight: FontWeight.w700),
            //                                     overflow: TextOverflow.ellipsis,),
            //                                 ),
            //                               )
            //                             ])),
            //                     PositionedDirectional(
            //                         bottom: 0,
            //                         end: 0,
            //                         child: Row(
            //                           children: [
            //                             IconButton(
            //                               icon: Icon(
            //                                 Icons.phone,
            //                                 color: Theme
            //                                     .of(context)
            //                                     .primaryColor,
            //                                 size: 15,
            //                               ),
            //                               onPressed: (){
            //
            //                               },
            //                             ),
            //                             GestureDetector(
            //                               onTap:(){
            //                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>reschedule_appointment(
            //                                     img_url: snapshot.data![index].dimg_url.toString(),
            //                                     name: snapshot.data![index].dname.toString(),
            //                                     profile: snapshot.data![index].dprofile.toString(),
            //                                     Fees: snapshot.data![index].amount.toString(),
            //                                     department_name: snapshot.data![index].depart.toString(),
            //                                     id: snapshot.data![index].doctor.toString(),
            //                                     appoinment_id:snapshot.data![index].id.toString()
            //                                 )));
            //                               },
            //                               child: Container(
            //                                 decoration:BoxDecoration(
            //                                     border: Border.all(width: 0.5,color: Theme.of(context).primaryColor),
            //                                     borderRadius: BorderRadius.circular(3)
            //                                 ),
            //                                 margin:EdgeInsets.only(right: 10, bottom: 10),
            //                                 padding:EdgeInsets.all(3),
            //                                 child:Row(
            //                                   children: [
            //                                     Icon(Icons.schedule,size: 20, color: Theme.of(context).primaryColor, ),
            //                                     Text(" Reschedule", style: TextStyle(fontSize: 10, color:Theme.of(context).primaryColor),)
            //                                   ],
            //                                 ),
            //                               ),
            //                             )
            //                           ],
            //                         )
            //                     )
            //                   ],
            //                 ),
            //                 Divider(
            //                   height: 6,
            //                   thickness: 6,
            //                   color: Theme
            //                       .of(context)
            //                       .backgroundColor,
            //                 ),
            //               ],
            //             );
            //           },
            //         ):Center(child: Text("No any upcoming appointments"),);
            //       }
            //   ),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width/2,
                    // padding: EdgeInsets.only(top: 20, right: 20, left: 10),
                    alignment: Alignment.center,
                    // color: Theme.of(context).backgroundColor,
                    height: 50,
                    child: Text("Upcoming Appointments",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontSize: 13.3, color: Color(0xffb3b3b3))),
                  ),
                ),
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
                  child: Text('Past Appointment',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 13.3, color: Theme.of(context).primaryColor)),
                ),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height/1.25,
              child: FutureBuilder<List<past>>(
                  future: pastAppot(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);
                    return snapshot.hasData
                        ? ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10.0, left: 10, right: 10, top: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, PageRoutes.appointmentDetail);
                                    },
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height:100,width:100,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage("https://app.healthcrad.com/upload/"+snapshot.data![index].dimg_url.toString(),
                                                  ),
                                                  fit:BoxFit.cover
                                              )
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Doctor: "+"${snapshot.data![index].dname}",
                                              style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                  height: 1.5,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            RichText(
                                                text: TextSpan(
                                                    style: Theme
                                                        .of(context)
                                                        .textTheme
                                                        .subtitle2,
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: "${snapshot.data![index].depart}",
                                                        style: Theme
                                                            .of(context)
                                                            .textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                            color: Theme
                                                                .of(context)
                                                                .disabledColor,
                                                            fontSize: 11.7,
                                                            height: 1.5),
                                                      ),
                                                      TextSpan(
                                                        text: "${snapshot.data![index].dprofile}",
                                                        style: Theme
                                                            .of(context)
                                                            .textTheme
                                                            .bodyText2!
                                                            .copyWith(
                                                            color: Theme
                                                                .of(context)
                                                                .disabledColor,
                                                            fontSize: 11.7,
                                                            height: 1.5),
                                                      ),
                                                    ])),
                                            Text("Patient: "+
                                                snapshot.data![index].name.toString(),
                                              style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                height: 1.5,
                                                fontSize: 14,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "${snapshot.data![index].start_time}" + ' | ',
                                                  style: Theme
                                                      .of(context)
                                                      .textTheme
                                                      .subtitle1!
                                                      .copyWith(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                Text(
                                                  "${snapshot.data![index].day} | ",
                                                  style: Theme
                                                      .of(context)
                                                      .textTheme
                                                      .subtitle1!
                                                      .copyWith(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                Text(
                                                  "${snapshot.data![index].bookdate}",
                                                  style: Theme
                                                      .of(context)
                                                      .textTheme
                                                      .subtitle1!
                                                      .copyWith(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold),

                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  snapshot.data![index].status=="2"?
                                  Text("Cancelled",style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                      fontSize: 15,color: Colors.red,
                                      fontWeight: FontWeight.w700),
                                    overflow: TextOverflow.ellipsis,):
                                  Text(" Attended",style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                      fontSize: 15,color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w700),
                                    overflow: TextOverflow.ellipsis,),
                                  GestureDetector(
                                    onTap: () async {
                                      var url = Uri.parse("tel: "+snapshot.data![index].phone.toString());
                                      if (await canLaunchUrl(url)) {
                                      await launchUrl(url);
                                      } else {
                                      throw 'Could not launch $url';
                                      }
                                    },
                                    child: Container(
                                      padding:EdgeInsets.all(3),
                                      decoration:BoxDecoration(
                                          color:Theme.of(context).primaryColor,
                                          border: Border.all(width: 0.5,color: Theme.of(context).primaryColor),
                                          borderRadius: BorderRadius.circular(3)
                                      ),
                                      child:Row(
                                        children: [
                                          Icon(
                                            Icons.phone,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                          Text("call", style: TextStyle(color: Colors.white),)
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap:(){
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              scrollable: true,
                                              content: Container(
                                                margin: EdgeInsets.only(left: 5, right: 5, top: 15),
                                                // height: 100,
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.black, width: 1),
                                                    borderRadius: BorderRadius.circular(8)
                                                ),
                                                child: TextField(
                                                  maxLines: 5,
                                                  controller: comment,
                                                  decoration: InputDecoration(
                                                      border: OutlineInputBorder(
                                                        borderSide: BorderSide.none,
                                                      ),
                                                      hintText: "Please write your review here..",
                                                      hintStyle: TextStyle(fontSize: 15, color: Colors.grey.withOpacity(0.8), fontWeight: FontWeight.w400)
                                                  ),
                                                ),
                                              ),
                                              actions: [
                                                ElevatedButton(onPressed: (){
                                                  Navigator.pop(context, true);
                                                  review(snapshot.data![index].id, snapshot.data![index].doctor, comment.text);
                                                }, child: Text('Submit'))
                                              ],
                                            );
                                          });
                                    },
                                    child: Container(
                                      padding:EdgeInsets.all(3),
                                      decoration:BoxDecoration(
                                          color:Theme.of(context).primaryColor,
                                          border: Border.all(width: 0.5,color: Theme.of(context).primaryColor),
                                          borderRadius: BorderRadius.circular(3)
                                      ),
                                      child: Text(
                                        "Add Feedback",
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            Divider(
                              height: 6,
                              thickness: 6,
                              color: Theme
                                  .of(context)
                                  .backgroundColor,
                            ),
                          ],
                        );
                      },
                    ) :Center(
                      child: Text("Data not Avalable."),
                    );
                  }
              ),
            )
          ],
        ),
      ),
    );
  }
  review(String? id,String? doctor, String comment) async{
    final prefs = await SharedPreferences.getInstance();
    final user_id = prefs.getString('user_id') ?? '0';
    final paymentres= await http.post(Uri.parse('https://app.healthcrad.com/api/index.php/api/Mobile_app/docterfeedback'),

      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "userid":"$user_id",
        "appointment_id":id.toString(),
        "comment":comment.toString(),
        "doterid":doctor.toString(),
      }),
    );
    final data= jsonDecode(paymentres.body);

    if(data["error"]=="200"){
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNavigation()));
      Fluttertoast.showToast(
          msg: data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);

    }
    else{
      Fluttertoast.showToast(
          msg: "Something Went Wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}

Future<List<past>> pastAppot() async{
  final prefs = await SharedPreferences.getInstance();
  final key = 'user_id';
  final user_id = prefs.getString(key) ?? 0;
  final response = await http.get(
    Uri.parse('https://app.healthcrad.com/api/index.php/api/Mobile_app/past_appointments?userid=$user_id'),
  );

  var jsond = json.decode(response.body)["country"];
print(jsond);
  List<past> allround = [];
  for (var o in jsond)  {
    past al = past(
        o["id"],
        o["week_day"],
        o["start_time"],
        o["dname"],
        o["dprofile"],
        o["depart"],
        o["doctorname"],
        o["amount"],
        o["dimg_url"],
        o["patientname"],
        o["name"],
        o["doctor"],
        o["status"],
        o["phone"],
        o["bookdate"],
        o["day"],
    );

    allround.add(al);
  }
  return allround;
}
class schedul {
  String? id;
  String? week_day;
  String? start_time;
  String? dname;
  String? dprofile;
  String? depart;
  String? doctorname;
  String? amount;
  String? dimg_url;
  String? patientname;
  String? name;
  String? doctor;
  String? bookdate;
  schedul(
      this.id,
      this.week_day,
      this.start_time,
      this.dname,
      this.dprofile,
      this.depart,
      this.doctorname,
      this.amount,
      this.dimg_url,
      this.patientname,
      this.name,
      this.doctor,
      this.bookdate,
      );

}
class past{
  String? id;
  String? week_day;
  String? start_time;
  String? dname;
  String? dprofile;
  String? depart;
  String? doctorname;
  String? amount;
  String? dimg_url;
  String? patientname;
  String? name;
  String? doctor;
  String? status;
  String? phone;
  String? bookdate;
  String? day;
  past(
      this.id,
      this.week_day,
      this.start_time,
      this.dname,
      this.dprofile,
      this.depart,
      this.doctorname,
      this.amount,
      this.dimg_url,
      this.patientname,
      this.name,
      this.doctor,
      this.status,
      this.phone,
      this.bookdate,
      this.day,
      );

}
