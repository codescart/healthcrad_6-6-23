import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:healthcrad_user/Locale/locale.dart';
import 'package:healthcrad_user/Theme/colors.dart';
import 'package:flutter/material.dart';

class view_appointment extends StatefulWidget {
  final String img_url;
  final String dphone;
  final String slotid;
  final String Fees;
  final String department_name;
  final String id;
  final String dname;
  final String name;
  final String start;
  final String end;
  final String address;
  final String age;
  final String day;
  final String phone;
  final String paymode;
  final String date;
  view_appointment({
    required this.Fees,
    required this.department_name,
    required this.id,
    required this.img_url,
    required this.dphone,
    required this.slotid,
    required this.dname, required this.name,
    required this.start, required this.end,
    required this.address, required this.age,
    required this.day, required this.phone, required this.paymode, required this.date,});

  @override
  _view_appointmentState createState() => _view_appointmentState();
}

class ReviewDetail {
  String image;
  String name;
  String? disease;
  double rating;
  String date;

  ReviewDetail(this.image, this.name, this.disease, this.rating, this.date);
}

class _view_appointmentState extends State<view_appointment> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    // List<ReviewDetail> _reviews = [
    //   ReviewDetail('assets/ProfilePics/dp1.png', 'Ronny George',
    //       locale.coldFever, 5.0, '20 Dec, 2019'),
    //   ReviewDetail('assets/ProfilePics/dp2.png', 'Reena Roy', locale.headache,
    //       4.0, '15 Dec, 2019'),
    //   ReviewDetail('assets/ProfilePics/dp3.png', 'Herry Johnson',
    //       locale.headache, 1.0, '02 Dec, 2019'),
    //   ReviewDetail('assets/ProfilePics/dp1.png', 'Ronny George',
    //       locale.coldFever, 5.0, '20 Dec, 2019'),
    //   ReviewDetail('assets/ProfilePics/dp2.png', 'Reena Roy', locale.headache,
    //       4.0, '15 Dec, 2019'),
    //   ReviewDetail('assets/ProfilePics/dp3.png', 'Herry Johnson',
    //       locale.headache, 1.0, '02 Dec, 2019'),
    //   ReviewDetail('assets/ProfilePics/dp1.png', 'Ronny George',
    //       locale.coldFever, 5.0, '20 Dec, 2019'),
    //   ReviewDetail('assets/ProfilePics/dp2.png', 'Reena Roy', locale.headache,
    //       4.0, '15 Dec, 2019'),
    //   ReviewDetail('assets/ProfilePics/dp3.png', 'Herry Johnson',
    //       locale.headache, 1.0, '02 Dec, 2019'),
    // ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios, size: 18, color: Colors.white,),),
        title: Text("Appointment Details"),
        centerTitle: true,
        // toolbarHeight: MediaQuery.of(context).size.height*0.1,
        // flexibleSpace: Container(
        //     decoration: BoxDecoration(
        //     ),
        //     padding: EdgeInsets.only(top:10, left: 10, right: 5, bottom: 5),
        //     child:Column(
        //       children: [
        //         SizedBox(height:MediaQuery.of(context).size.height*0.04,),
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: [
        //             Row(
        //               children: [
        //                 Container(
        //                     padding: EdgeInsets.only(left: 5, right: 5),
        //                     // margin: EdgeInsets.only(right: 5, left: 25),
        //                     width:70,
        //                     // height: 100,
        //                     // color: Colors.blueGrey,
        //                     child: Image.asset("assets/doctor_logo.png")),
        //                 Container(
        //                   height: 50,
        //                   // color: Colors.red,
        //                   child: Column(
        //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     children: [
        //                       Text("HealthCrad",  style: TextStyle(fontSize: 23, color: Colors.black, fontWeight: FontWeight.w700,),),
        //                       Text("Save More, Serve More",  style: TextStyle(fontSize: 11, color: Colors.black, fontWeight: FontWeight.bold,),),
        //                     ],
        //                   ),
        //                 ),
        //               ],
        //             ),
        //             Container(
        //               // color: Colors.green,
        //               child:Row(
        //                 children: [
        //                   IconButton(onPressed: (){}, icon: Icon(Icons.shopping_cart_outlined, color: Colors.black,size: 30,)),
        //                   IconButton(onPressed: (){}, icon: Icon(Icons.notifications_none_outlined, color: Colors.black,size: 30,))
        //                 ],
        //               ) ,
        //             )
        //           ],
        //         ),
        //       ],
        //     )
        // ) ,
        // titleSpacing: 20,
        automaticallyImplyLeading: false,
      ),
      body: FadedSlideAnimation(
        ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                        "https://app.healthcrad.com/upload/" +
                            widget.img_url
                                .toString()),
                  ),
                  SizedBox(width: 20,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Dr: ", style: TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w700),),
                          Text(widget.dname, style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700),),
                        ],
                      ),
                      Text(widget.department_name,style: TextStyle(fontSize: 15, color: Colors.black,fontWeight: FontWeight.w400 ),),
                      Row(
                        children: [
                          Text("Fees: ", style: TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w700),),
                          Text(
                            '\₹ ' + widget.Fees,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(fontSize: 16, color: Theme.of(context).primaryColor),
                          ),
                        ],
                      )
                    ],
                  ),
                  Spacer(),
                  Container(
                    // color: Colors.grey,
                    height: 50,
                    alignment: Alignment.centerRight,
                    // width: MediaQuery.of(context).size.width/2.8,

                  ),
                ],
              ),
            ),
            Divider(thickness: 1, color: Colors.grey.shade400,),
            // Container(
            //   margin: EdgeInsets.only(left: 10, right: 10),
            //   decoration: BoxDecoration(
            //       color: Theme.of(context).backgroundColor,
            //       borderRadius: BorderRadius.circular(15),
            //       border: Border.all(width: 1, color: Colors.black.withOpacity(0.2))
            //   ),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Container(
            //         padding: EdgeInsets.only(left: 15, bottom: 10, top: 10),
            //         child: Text("About -",style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),),
            //       ),
            //       Padding(padding: EdgeInsets.only(left: 50, right: 20, bottom: 10),
            //         child: Text("Dr."+widget.dname+" is one of the best "+widget.department_name+". he had done "+widget.department_name+
            //             "He is practicing from  years. and has treated several thousands of patients and cured thems.",
            //           style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w400),
            //           textAlign: TextAlign.justify,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Container(
              // height: MediaQuery.of(context).size.height/1.8,
              margin: EdgeInsets.only(left: 10,right: 10 , top: 10),
              decoration: BoxDecoration(
                  // color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  border: Border.all(width: 1, color: Colors.black.withOpacity(0.2))
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width:MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      decoration:BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          )
                      ),
                      padding:EdgeInsets.only(top: 5, bottom: 5 ),
                      child: Text("Complete details", style: TextStyle(fontSize: 22, color: Colors.white),),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                        width: MediaQuery.of(context).size.width/2.6,
                        height: MediaQuery.of(context).size.height/2,
                        // color: Colors.black,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Patient Name:", style: TextStyle(fontSize:16, color: Colors.black54),),
                            Text("Patient Age:", style: TextStyle(fontSize:16, color: Colors.black54),),
                            Text("Patient M. no.:", style: TextStyle(fontSize:16, color: Colors.black54),),
                            Text("Slot Id :", style: TextStyle(fontSize:16, color: Colors.black54),),
                            Text("Day:", style: TextStyle(fontSize:16, color: Colors.black54),),
                            Text("Date:", style: TextStyle(fontSize:16, color: Colors.black54),),
                            Text("Slot from:", style: TextStyle(fontSize:16, color: Colors.black54),),
                            Text("Slot to:", style: TextStyle(fontSize:16, color: Colors.black54),),
                            Text("Doctor Name:", style: TextStyle(fontSize:16, color: Colors.black54),),
                            // Text("Doctor Phone:", style: TextStyle(fontSize:16, color: Colors.black54),),
                            Text("Address: ", style: TextStyle(fontSize:16, color: Colors.black54),),
                            Text("paymode: ", style: TextStyle(fontSize:16, color: Colors.black54),),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                        width: MediaQuery.of(context).size.width/1.9,
                        height: MediaQuery.of(context).size.height/2,
                        // color: Colors.black,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(widget.name, style: TextStyle(fontSize:16, color: Colors.black),),
                            Text(widget.age, style: TextStyle(fontSize:16, color: Colors.black),),
                            Text(widget.phone, style: TextStyle(fontSize:16, color: Colors.black),),
                            Text(widget.slotid, style: TextStyle(fontSize:16, color: Colors.black),),
                            Text(widget.day, style: TextStyle(fontSize:16, color: Colors.black),),
                            Text(widget.date, style: TextStyle(fontSize:16, color: Colors.black),),
                            Text(widget.start, style: TextStyle(fontSize:16, color: Colors.black),),
                            Text(widget.end, style: TextStyle(fontSize:16, color: Colors.black),),
                            Text(widget.dname, style: TextStyle(fontSize:16, color: Colors.black),),
                            // Text(widget.dphone, style: TextStyle(fontSize:16, color: Colors.black),),
                            Text(widget.address, style: TextStyle(fontSize:16, color: Colors.black),),
                            Text(widget.paymode, style: TextStyle(fontSize:16, color: Colors.black),),

                          ],
                        ),
                      )
                    ],
                  ),
                  // ListTile(
                  //   title: Row(
                  //     children: [
                  //       Text(
                  //         'Dr.'+ widget.name,
                  //         style: Theme.of(context)
                  //             .textTheme
                  //             .bodyText1!
                  //             .copyWith(fontSize: 18.2, color: black2),
                  //       ),
                  //       Spacer(),
                  //       // Row(
                  //       //   children: [
                  //       //     Icon(
                  //       //       Icons.star,
                  //       //       color: Color(0xffF29F19),
                  //       //       size: 15,
                  //       //     ),
                  //       //     SizedBox(
                  //       //       width: 4,
                  //       //     ),
                  //       //     Text(
                  //       //       '4.5',
                  //       //       style: Theme.of(context)
                  //       //           .textTheme
                  //       //           .bodyText1!
                  //       //           .copyWith(color: Color(0xffF29F19), fontSize: 15),
                  //       //     ),
                  //       //   ],
                  //       // ),
                  //     ],
                  //   ),
                  //   subtitle:Row(
                  //     children: [
                  //       Text(
                  //         locale.averageReviews!,
                  //         style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  //             fontSize: 13.5, height: 1.8, color: lightGreyColor),
                  //       ),
                  //       Spacer(),
                  //       Text(
                  //         locale.avgReview!,
                  //         style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  //             fontSize: 13.5, height: 1.8, color: lightGreyColor),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Container(
                  //   height:  MediaQuery.of(context).size.height/2.4,
                  //   child: ListView.builder(
                  //       itemCount: _reviews.length,
                  //       shrinkWrap: true,
                  //       itemBuilder: (context, index) {
                  //         return SingleChildScrollView(
                  //           child: Column(
                  //             children: [
                  //               Divider(
                  //                 color: Colors.white,
                  //                 thickness: 3,
                  //               ),
                  //               ListTile(
                  //                 leading: CircleAvatar(
                  //                   radius: 18,
                  //                   backgroundImage: AssetImage(_reviews[index].image),
                  //                 ),
                  //                 title: Row(
                  //                   children: [
                  //                     Text(
                  //                       _reviews[index].name,
                  //                       style: Theme.of(context)
                  //                           .textTheme
                  //                           .bodyText1!
                  //                           .copyWith(fontSize: 15, color: black2),
                  //                     ),
                  //                     Spacer(),
                  //                     Row(
                  //                       children: [
                  //                         Text(
                  //                           _reviews[index].rating.toString(),
                  //                           style: Theme.of(context)
                  //                               .textTheme
                  //                               .subtitle1!
                  //                               .copyWith(fontSize: 10),
                  //                         ),
                  //                         SizedBox(
                  //                           width: 5,
                  //                         ),
                  //                         Row(
                  //                           children: List.generate(
                  //                             _reviews[index].rating.floor(),
                  //                                 (index) => Icon(
                  //                               Icons.star,
                  //                               size: 12,
                  //                               color: Color(0xffF29F19),
                  //                             ),
                  //                           ),
                  //                         ),
                  //                         Row(
                  //                           children: List.generate(
                  //                             5 - _reviews[index].rating.floor(),
                  //                                 (index) => Icon(
                  //                               Icons.star,
                  //                               size: 12,
                  //                               color: Theme.of(context).disabledColor,
                  //                             ),
                  //                           ),
                  //                         ),
                  //                       ],
                  //                     ),
                  //                   ],
                  //                 ),
                  //                 subtitle: Row(
                  //                   children: [
                  //                     RichText(
                  //                         text: TextSpan(children: <TextSpan>[
                  //                           TextSpan(
                  //                             text: locale.visitedFor! + ' ',
                  //                             style: Theme.of(context)
                  //                                 .textTheme
                  //                                 .subtitle2!
                  //                                 .copyWith(
                  //                               fontWeight: FontWeight.w600,
                  //                               fontSize: 10,
                  //                               color: Theme.of(context).disabledColor,
                  //                             ),
                  //                           ),
                  //                           TextSpan(
                  //                             text: locale.coldFever,
                  //                             style: Theme.of(context)
                  //                                 .textTheme
                  //                                 .subtitle1!
                  //                                 .copyWith(fontSize: 10),
                  //                           ),
                  //                         ])),
                  //                     Spacer(),
                  //                     Text(
                  //                       '20 Dec, 2020',
                  //                       style: Theme.of(context)
                  //                           .textTheme
                  //                           .subtitle2!
                  //                           .copyWith(
                  //                           fontSize: 8.3, color: Color(0xffcecece)),
                  //                     )
                  //                   ],
                  //                 ),
                  //               ),
                  //               Padding(
                  //                 padding: const EdgeInsets.only(
                  //                     left: 20.0, right: 20.0, bottom: 10.0),
                  //                 child: Text(
                  //                   'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                  //                   style: Theme.of(context)
                  //                       .textTheme
                  //                       .bodyText1!
                  //                       .copyWith(
                  //                       fontWeight: FontWeight.normal,
                  //                       fontSize: 13.3,
                  //                       color: Color(0xff4c4c4c),
                  //                       height: 1.5),
                  //                 ),
                  //               )
                  //             ],
                  //           ),
                  //         );
                  //       }),
                  // )
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
}
