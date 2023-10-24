import 'dart:async';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:healthcrad_user/BottomNavigation/Doctors/past_appointment.dart';
import 'package:healthcrad_user/BottomNavigation/Doctors/reschedule.dart';
import 'package:healthcrad_user/BottomNavigation/Doctors/view_appointment_detail.dart';
import 'package:healthcrad_user/Theme/testt.dart';
import 'package:http/http.dart' as http;
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:healthcrad_user/BottomNavigation/bottom_navigation.dart';
import 'package:healthcrad_user/Locale/locale.dart';
import 'package:healthcrad_user/Routes/routes.dart';
import 'package:healthcrad_user/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class AppointmentPage extends StatefulWidget {
  @override
  _AppointmentPageState createState() => _AppointmentPageState();
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
class _AppointmentPageState extends State<AppointmentPage> {

  final comment=TextEditingController();
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width/2,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    border: Border(
                      bottom: BorderSide(width: 2, color:Theme.of(context).primaryColor )
                    )
                  ),
                  height: 50,
                  child: Text('Upcoming Appointment',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 13.3, color: Theme.of(context).primaryColor)),
                ),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>past_appointment()));
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width/2,
                    alignment: Alignment.center,
                    height: 50,
                    child: Text("Past Appointments",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontSize: 13.3, color: Color(0xffb3b3b3))),
                  ),
                ),
              ],
            ),
            Divider(
              thickness: 6,
              height: 6,
              color: Colors.white,
            ),
           Container(
             padding: EdgeInsets.only(bottom: 10),
             height: MediaQuery.of(context).size.height/1.35,
             child: FutureBuilder<List<schedul>>(
             future: UpcomingAppot(),
             builder: (context, snapshot) {
             if (snapshot.hasError) print(snapshot.error);
             return snapshot.hasData
              ? SingleChildScrollView(
                child: ListView.builder(
                 physics: BouncingScrollPhysics(),
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
                         top: 5, left: 5, right: 5, bottom: 5),
                     margin: EdgeInsets.only(
                         left: 8, right: 8, bottom: 5),
                     child: Column(
                       children: [
                         Row(
                           mainAxisAlignment:
                           MainAxisAlignment.spaceBetween,
                           crossAxisAlignment:
                           CrossAxisAlignment.start,
                           children: [
                             CircleAvatar(
                               radius: 40,
                               backgroundImage: NetworkImage(
                                   "https://app.healthcrad.com/upload/" +
                                       snapshot
                                           .data![index].dimg_url
                                           .toString()),
                             ),
                             SizedBox(
                               width: 10,
                             ),
                             Column(
                               crossAxisAlignment:
                               CrossAxisAlignment.start,
                               mainAxisAlignment:
                               MainAxisAlignment.center,
                               children: [
                                 Row(
                                   children: [
                                     Text(
                                          "Doctor: ",
                                         style: Theme.of(context)
                                             .textTheme
                                             .bodyText1!
                                             .copyWith(
                                             color: Colors.black38,
                                             height: 1.7, fontSize: 13)),
                                     Text(
                                       snapshot
                                           .data![index]
                                           .dname
                                           .toString(),
                                       style: Theme.of(context)
                                           .textTheme
                                           .bodyText1!
                                           .copyWith(
                                           color: black2,
                                           height: 1.7, fontSize: 13,overflow: TextOverflow.ellipsis),
                                     ),
                                   ],
                                 ),
                                 Container(
                                   width: MediaQuery.of(context).size.width/1.5,
                                   child: Text(
                                       "("+ snapshot
                                           .data![index]
                                           .dprofile
                                           .toString()+")",
                                       style: Theme.of(context)
                                           .textTheme
                                           .bodyText1!
                                           .copyWith(
                                         fontSize: 10,
                                         color: Colors.black54,
                                         overflow: TextOverflow.ellipsis
                                       )),
                                 ),
                                 SizedBox(
                                   height: 2,
                                 ),
                                 Row(
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [
                                     Text(
                                       "Patient: ",
                                       style: Theme.of(context)
                                           .textTheme
                                           .subtitle2!
                                           .copyWith(
                                           color: Theme.of(
                                               context)
                                               .disabledColor,
                                           fontSize: 13),
                                     ),
                                     Text(
                                       snapshot.data![index].name
                                           .toString() ,
                                       style: Theme.of(context)
                                           .textTheme
                                           .subtitle1!
                                           .copyWith(fontSize: 13),
                                     ),
                                   ],
                                 ),
                                 SizedBox(
                                   height: 4,
                                 ),
                                 Row(
                                   children: [
                                     Text(
                                       snapshot.data![index].week_day.toString()+" | ",
                                       style: Theme.of(context)
                                           .textTheme
                                           .subtitle2!
                                           .copyWith(
                                           fontSize: 12),
                                     ),
                                     Text(
                                       snapshot.data![index].time_slot.toString() +" | "
                                           .toString()+" -" ,
                                       style: Theme.of(context)
                                           .textTheme
                                           .subtitle2!
                                           .copyWith(fontSize: 11),
                                     ),
                                     Text(snapshot.data![index].bookdate.toString(),
                                       style: Theme.of(context)
                                           .textTheme
                                           .subtitle2!
                                           .copyWith(fontSize: 11),
                                     )
                                   ],
                                 ),
                                 SizedBox(
                                   height: 6,
                                 ),
                                 Row(
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [
                                     Text(
                                       "Paymode: ",
                                       style: Theme.of(context)
                                           .textTheme
                                           .subtitle2!
                                           .copyWith(
                                           color: Theme.of(
                                               context)
                                               .disabledColor,
                                           fontSize: 13),
                                     ),
                                     Text(
                                       snapshot.data![index].payment
                                           .toString() ,
                                       style: Theme.of(context)
                                           .textTheme
                                           .subtitle1!
                                           .copyWith(fontSize: 13),
                                     ),
                                   ],
                                 ),
                               ],
                             ),
                             Spacer(),
                           ],
                         ),
                         Divider(thickness: 0.5, color: Colors.black26,),
                         Padding(
                           padding: const EdgeInsets.only(left: 9, right: 9),
                           child: Row(
                             mainAxisAlignment:
                             MainAxisAlignment.spaceBetween,
                             children: [
                               Container(
                                 padding: EdgeInsets.only(
                                     left: 5, right: 5),
                                 alignment: Alignment.center,
                                 height: 30,
                                 child: Row(
                                   children: [
                                     Text("Status: ",
                                       style: TextStyle(
                                           fontSize: 14,
                                           color: Colors.black),
                                     ),
                                     snapshot.data![index].status.toString() == "0"?
                                     Text("Wait for approval",
                                       style: TextStyle(
                                           fontSize: 14.5,
                                           color: Colors.orange),
                                     ):
                                     snapshot.data![index].status.toString() == "3"?
                                     Text("Appointment accepted",
                                       style: TextStyle(
                                           fontSize: 14.5,
                                           color: Colors.green),
                                     ):Text(""),
                                   ],
                                 ),
                               ),
                               GestureDetector(
                                 onTap: () async {
                                   Navigator.push(context, MaterialPageRoute(builder: (context)=> Myaaa()));
                                   var url = Uri.parse("tel: "+snapshot.data![index].contact.toString());
                                   if (await canLaunchUrl(url)) {
                                     await launchUrl(url);
                                   }
                                   else {
                                     throw 'Could not launch $url';
                                   }
                                 },
                                 child: Container(
                                   width: 100,
                                   height: 30,
                                   decoration:BoxDecoration(
                                       border: Border.all(width: 0.5,color:Theme.of(context).primaryColor),
                                       borderRadius: BorderRadius.circular(3)
                                   ),
                                   // margin:EdgeInsets.only(right: 10, bottom: 10),
                                   padding:EdgeInsets.all(3),
                                   child:Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                     children: [
                                       Icon(Icons.call,size: 20, color: Theme.of(context).primaryColor, ),
                                       Text(" Contact", style: TextStyle(fontSize: 15, color:Theme.of(context).primaryColor),)
                                     ],
                                   ),
                                 ),
                               ),
                             ],
                           ),
                         ),
                         SizedBox(height: 5,),
                         Row(
                           mainAxisAlignment:
                           MainAxisAlignment.spaceEvenly,
                           children: [
                             GestureDetector(
                               onTap: (){
                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>view_appointment(Fees: snapshot.data![index].amount.toString(),
                                     department_name:snapshot.data![index].dprofile.toString(),
                                     id: snapshot.data![index].id.toString(),
                                     img_url: snapshot.data![index].dimg_url.toString(),
                                     dphone:snapshot.data![index].dphone.toString() ,
                                     slotid:snapshot.data![index].slot_id.toString(),
                                     dname: snapshot.data![index].dname.toString(),
                                     name:snapshot.data![index].name.toString(),
                                     start:snapshot.data![index].start_time.toString(),
                                     end:snapshot.data![index].end_time.toString(),
                                     address:snapshot.data![index].address.toString(),
                                     age:snapshot.data![index].age.toString(),
                                     day:snapshot.data![index].week_day.toString(),
                                     phone:snapshot.data![index].phone.toString(),
                                     paymode:snapshot.data![index].payment.toString(),
                                     date:snapshot.data![index].bookdate.toString()
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
                                   "View Details",
                                   style: TextStyle(fontSize: MediaQuery.of(context).size.width/25),
                                 ),
                               ),
                             ),
                             GestureDetector(
                               onTap:() {
                                 showDialog(
                                     context: context,
                                     builder:
                                         (BuildContext context ) {
                                       return Dialog(
                                         shape:RoundedRectangleBorder(
                                           borderRadius: BorderRadius.circular(16),
                                         ),
                                         elevation: 0,
                                         backgroundColor: Colors.transparent,
                                         child: Container(
                                           padding: EdgeInsets.only(top: 10, bottom:10),
                                           decoration: BoxDecoration(
                                               borderRadius: BorderRadius.circular(16),
                                               color: Colors.white,
                                               border: Border.all(width: 5, color: Colors.black54)
                                           ),
                                           width: MediaQuery.of(context).size.width,
                                           height: 200,
                                           alignment: Alignment.bottomCenter,
                                           // margin: EdgeInsets.only(top:MediaQuery.of(context).size.height/1.5),
                                           child: Column(
                                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                             crossAxisAlignment: CrossAxisAlignment.center,
                                             children: [
                                               Container(
                                                 child: Icon(Icons.warning_amber, size: 50, color: Colors.red,),
                                               ),
                                               Container(
                                                 padding: EdgeInsets.all(10),
                                                 alignment: Alignment.center,
                                                 width: MediaQuery.of(context).size.width/1.1,
                                                 child:Text("Are you really want to Cancel the selected schedule ?",style: TextStyle(color: Colors.blueGrey,),textAlign: TextAlign.center,
                                                 ),
                                               ),
                                               Row(
                                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                 children: [
                                                   Container(width: 100, height: 40,
                                                     child: ElevatedButton(onPressed: () {
                                                       Navigator.pop(context);
                                                     },
                                                       style: ElevatedButton.styleFrom(
                                                           primary: Colors.red
                                                       ),
                                                       child: Text("Cancel", style: TextStyle(fontSize: 15, color: Colors.white),),),
                                                   ),

                                                   Container(height: 40, width: 100,
                                                     child: ElevatedButton(onPressed: ()
                                                     async {
                                                       app_id= snapshot.data![index].id;
                                                       appointcance(snapshot.data![index].id);
                                                       print(app_id);
                                                     },

                                                         style: ElevatedButton.styleFrom(
                                                             primary: Theme.of(context).primaryColor
                                                         )
                                                         , child: Text("Confirm",style: TextStyle(fontSize: 15),)),
                                                   )
                                                 ],
                                               ),
                                             ],
                                           ),
                                         ),
                                       );
                                     }
                                 );
                               },
                               child: Container(
                                 width: 100,
                                 height: 30,
                                 decoration:BoxDecoration(
                                     border: Border.all(width: 0.5,color: Colors.red),
                                     borderRadius: BorderRadius.circular(3)
                                 ),
                                 // margin:EdgeInsets.only(right: 10, bottom: 10),
                                 padding:EdgeInsets.all(3),
                                 child:Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                   children: [
                                     Icon(Icons.delete,size: 20, color: Colors.red, ),
                                     Text(" Cancel", style: TextStyle(fontSize:  MediaQuery.of(context).size.width/25, color:Colors.red),)
                                   ],
                                 ),
                               ),
                             ),
                             GestureDetector(
                               onTap:(){
                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>reschedule_appointment(
                                   img_url: snapshot.data![index].dimg_url.toString(),
                                   name: snapshot.data![index].dname.toString(),
                                   profile: snapshot.data![index].dprofile.toString(),
                                   Fees: snapshot.data![index].amount.toString(),
                                   department_name: snapshot.data![index].depart.toString(),
                                   id: snapshot.data![index].doctor.toString(),
                                   appoinment_id:snapshot.data![index].id.toString(),
                                 )));
                               },
                               child: Container(
                                 width: 100,
                                 height: 30,
                                 decoration:BoxDecoration(
                                     border: Border.all(width: 0.5,color: Theme.of(context).primaryColor),
                                     borderRadius: BorderRadius.circular(3)
                                 ),
                                 // margin:EdgeInsets.only(right: 10, bottom: 10),
                                 padding:EdgeInsets.all(3),
                                 child:Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                   children: [
                                     Icon(Icons.schedule,size: 20, color: Theme.of(context).primaryColor, ),
                                     Text(" Reschedule", style: TextStyle(fontSize: MediaQuery.of(context).size.width/30, color:Theme.of(context).primaryColor),)
                                   ],
                                 ),
                               ),),
                           ],
                         ),

                       ],
                     ),
                   );
                                },
             ),
              ):Center(child: Text("No any upcoming appointments"),);
             }
              ),
           ),
          ],
        ),
      ),
    );
  }
  appointcance(String? id)async {
    final prefs = await SharedPreferences.getInstance();
    final user_id = prefs.getString('user_id') ?? '0';
    final response = await http.post(
      Uri.parse("https://app.healthcrad.com/api/index.php/api/Mobile_app/cancel_appointment"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "appointment_id":app_id,
        "userid":"$user_id"

      }),
    );
    // print(snapshot.data![index].id);
    print("ashu");
    print(app_id);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg:"Selected appointment Cancel successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor:  Colors.green.withOpacity(0.7),
          textColor:  Color(0xffffffff),
          fontSize: 12.0);
      print("1 item delete ho gya");
      // print(snapshot.data![index].id);
      Navigator.pop(context);
      setState(() {
        Timer(Duration(milliseconds: 300 ), () {
          print("Yeah, this line is printed immediately");
          UpcomingAppot();
        });
      });
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AppointmentPage()));
    }
    else {
      print("appointment delete nhi ho paya");
    }
  }

}


Future<List<schedul>> UpcomingAppot() async{
  final prefs = await SharedPreferences.getInstance();
  final key = 'user_id';
  final user_id = prefs.getString(key) ?? 0;
  final response = await http.get(
    Uri.parse('https://app.healthcrad.com/api/index.php/api/Mobile_app/upcoming_appointments?userid=$user_id'),
  );
  var jsond = json.decode(response.body)["country"];
  print(jsond);
  print('ssssssssss');
  List<schedul> allround = [];
  for (var o in jsond)  {
    schedul al = schedul(
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
      o["dphone"],
      o["end_time"],
      o["payment"],
      o["address"],
      o["age"],
      o["phone"],
      o["slot_id"],
      o["bookdate"],
      o["status"],
      o["contact"],
      o["time"],
      o["time_slot"],
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
  String? dphone;
  String? end_time;
  String? payment;
  String? address;
  String? age;
  String? phone;
  String? slot_id;
  String? bookdate;
  String? status;
  String? contact;
  String? time;
  String? time_slot;
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
      this.dphone,
      this.end_time,
      this.payment,
      this.address,
      this.age,
      this.phone,
      this.slot_id,
      this.bookdate,
      this.status,
      this.contact,
      this.time,
      this.time_slot,
      );

}
