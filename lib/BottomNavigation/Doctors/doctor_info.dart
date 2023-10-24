import 'dart:async';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:healthcrad_user/BottomNavigation/Doctors/book_appointment.dart';
import 'package:healthcrad_user/BottomNavigation/More/ccccc.dart';
import 'package:http/http.dart' as http;
import 'package:healthcrad_user/Locale/locale.dart';
import 'package:healthcrad_user/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../Components/custom_button.dart';

class DoctorInfo extends StatefulWidget {
  final String img_url;
  final String name;
  final String profile;
  final String Exp;
  final String Fees;
  final String department_name;
  final String id;
  final String city;
  final String about;
  DoctorInfo({required this.img_url, required this.name, required this.profile, required this.Exp, required this.Fees, required this.department_name, required this.id, required this.city, required this.about,  });

  @override
  _DoctorInfoState createState() => _DoctorInfoState();

}

class _DoctorInfoState extends State<DoctorInfo> {
  var inDex;
  var  selectedIndex;
  var selectedDate;
  var weekday;
  var week;
  var no_slot;
  final TextEditingController dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height*0.1,
        flexibleSpace: Container(
            padding: EdgeInsets.only(left: 10, right: 5, bottom: 5),
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
                      child:Row(
                        children: [
                          IconButton(onPressed: (){

                          }, icon: Icon(Icons.shopping_cart_outlined, color: Colors.black,size: 30,)),
                          // IconButton(onPressed: (){}, icon: Icon(Icons.notifications_none_outlined, color: Colors.black,size: 30,))
                        ],
                      ) ,
                    ),

                  ],
                ),
              ],
            )
        ) ,
        titleSpacing: 20,
        automaticallyImplyLeading: false,
      ),
      body:SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundImage: NetworkImage("https://app.healthcrad.com/upload/"+widget.img_url),
                  ),
                  SizedBox(width: 10,),
                  Container(
                    width: MediaQuery.of(context).size.width/2.3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10,),
                        Text("Dr. "+widget.name, style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700),),
                        Text(widget.department_name,style: TextStyle(fontSize: 13, color: Colors.black,fontWeight: FontWeight.w400 ),),
                        Text(widget.profile,style: TextStyle(fontSize: 13, color: Colors.black,fontWeight: FontWeight.w400),),
                        Text("Exp: "+widget.Exp+ " years",style: TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.w400),),
                        Text("City: "+widget.city,style: TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.w400),),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(

                    height: 50,
                    width: MediaQuery.of(context).size.width/4.5,
                    alignment: Alignment.centerRight,
                    child:  Text(
                      '\₹ ' + widget.Fees+".00",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(fontSize: 16, color: Theme.of(context).primaryColor),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5,),
            Divider(thickness: 1, color: Colors.grey.withOpacity(0.4),),
            Padding(padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Text("Select Appointment Schedule", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),
            ),
            SizedBox(height: 10,),
            Container(
              // height: MediaQuery.of(context).size.height/2.6,
              margin: EdgeInsets.only(top: 15),
              child:  FutureBuilder<List<schedul>>(
                  future: bowe(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);
                    return snapshot.hasData
                        ?
                    ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(right: 10, left: 10),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  selectedIndex = snapshot.data![index].id;
                                  weekday=snapshot.data![index].weekday;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 10),
                                padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                                decoration:BoxDecoration(
                                    color: selectedIndex == snapshot.data![index].id?Colors.white:Theme.of(context).backgroundColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                    border: selectedIndex == snapshot.data![index].id?Border.all(width: 2.5, color: Theme.of(context).primaryColor):Border.all(width: 0, color: Theme.of(context).backgroundColor)
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text("Weekday : ", style: TextStyle(fontSize: 14),),
                                        Text(
                                          snapshot.data![index].weekday.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                              fontSize: 15,
                                              height: 1.5,
                                              color: selectedIndex == snapshot.data![index].id?Colors.black: black2,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    snapshot.data![index].slot1.toString() !=null && snapshot.data![index].slot2.toString() !="" && snapshot.data![index].slot3.toString() !="" ?
                                    Text("Total No of Slots : 3", style: TextStyle(fontSize: 13.5),):
                                    snapshot.data![index].slot1.toString() !=null && snapshot.data![index].slot2.toString() !="" && snapshot.data![index].slot3.toString() =="" ?
                                    Text("Total No of Slots : 2", style: TextStyle(fontSize: 13.5),):
                                    snapshot.data![index].slot1.toString() !=null && snapshot.data![index].slot2.toString() =="" && snapshot.data![index].slot3.toString() =="" ?
                                    Text("Total No of Slots : 1", style: TextStyle(fontSize: 13.5),):Text(""),
                                    SizedBox(height: 5,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: 40,
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Address : ", style: TextStyle(fontSize: 14),),
                                              Icon(
                                                Icons.location_pin,
                                                color: Theme.of(context).primaryColor,
                                                size: 15,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context).size.width*0.65,
                                                child: Text(
                                                  snapshot.data![index].hospital_id.toString(),
                                                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                                      fontSize: 13,
                                                      color:selectedIndex == snapshot.data![index].id?Colors.blueGrey: Theme.of(context).disabledColor),
                                                  overflow: TextOverflow.visible,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Text(snapshot.data![index].id),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    selectedIndex==snapshot.data![index].id? Column(
                                      children: [
                                        Text("Choose time slot", style: TextStyle(fontSize: 15, color: Colors.black),),
                                        SizedBox(height: 10 ,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: (){
                                                setState(() {
                                                  inDex= "1";
                                                  selectedDate = snapshot.data![index].slottime1.toString();
                                                  no_slot = snapshot.data![index].slot1.toString();
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border:selectedDate == snapshot.data![index].slottime1.toString() && selectedIndex == snapshot.data![index].id && inDex == "1"?
                                                  Border.all(width: 2, color:Theme.of(context).primaryColor):
                                                  Border.all(width: 0.2, color: Colors.black),
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Slot No: 1", style: TextStyle(fontSize: 10,),),
                                                    SizedBox(height: 5,),
                                                    Text("Time : \n"+snapshot.data![index].slottime1.toString(), style: TextStyle(fontSize: 10),),
                                                    SizedBox(height: 5,),
                                                    Text("No. of Bookings : "+snapshot.data![index].slot1.toString(), style: TextStyle(fontSize: 10),),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            snapshot.data![index].slot2 !="0"? GestureDetector(
                                              onTap: (){
                                                setState(() {
                                                  inDex = "2";
                                                  selectedDate = snapshot.data![index].slottime2.toString();
                                                  no_slot = snapshot.data![index].slot2.toString();
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border:selectedDate == snapshot.data![index].slottime2.toString() && selectedIndex == snapshot.data![index].id && inDex == "2"?
                                                  Border.all(width: 2, color:Theme.of(context).primaryColor):Border.all(width: 0.2, color: Colors.black),
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Slot No: 2", style: TextStyle(fontSize: 10,),),
                                                    SizedBox(height: 5,),
                                                    Text("Time : \n"+snapshot.data![index].slottime2.toString(), style: TextStyle(fontSize: 10),),
                                                    SizedBox(height: 5,),
                                                    Text("No. of Booking : "+snapshot.data![index].slot2.toString(), style: TextStyle(fontSize: 10),),
                                                  ],
                                                ),
                                              ),
                                            ):Spacer(),
                                            snapshot.data![index].slot3 !="0"? GestureDetector(
                                              onTap: (){
                                                setState(() {
                                                   inDex = "3";
                                                  selectedDate = snapshot.data![index].slottime3.toString();
                                                  no_slot = snapshot.data![index].slot3.toString();
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border:selectedDate == snapshot.data![index].slottime3.toString() && selectedIndex == snapshot.data![index].id && inDex == "3"?
                                                  Border.all(width: 2, color:Theme.of(context).primaryColor):Border.all(width: 0.2, color: Colors.black),
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Slot No: 3", style: TextStyle(fontSize: 10,),),
                                                    SizedBox(height: 5,),
                                                    Text("Time : \n"+snapshot.data![index].slottime3.toString(), style: TextStyle(fontSize: 10),),
                                                    SizedBox(height: 5,),
                                                    Text("No. of Bookings : "+snapshot.data![index].slot3.toString(), style: TextStyle(fontSize: 10),),
                                                  ],
                                                ),
                                              ),
                                            ):SizedBox(width: 1,)
                                          ],
                                        ),
                                        SizedBox(height: 10 ,),
                                        Column(
                                          children: [
                                            Text("Choose Appointment date", style: TextStyle(fontSize: 15, color: Colors.black),),
                                            SizedBox(height: 8,),
                                            Text("The date must be selected on the behalf of selected weekday", style: TextStyle(fontSize: 11.5, color: Colors.black54),),
                                           SizedBox(height: 8,),
                                            Container(
                                              padding: EdgeInsets.only(left: 10, right: 10),
                                                decoration: BoxDecoration(
                                                  border: Border.all(width: 0.5, color: Colors.black26,),
                                                  borderRadius: BorderRadius.circular(10)
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                 Text("Select date : ${deteformat == null?"": deteformat}",style: TextStyle(fontSize: 12),),
                                                 IconButton(onPressed: () async{
                                                   if(no_slot== snapshot.data![index].slot1.toString() ||no_slot== snapshot.data![index].slot2.toString() || no_slot== snapshot.data![index].slot3.toString()) {
                                                     if (weekday == "Monday" ||
                                                         weekday == "MonDay") {
                                                       // DateTime.monday;
                                                         monday();

                                                     }
                                                     if (weekday == "Tuesday" ||
                                                         weekday == "TuesDay") {
                                                       // week = DateTime.tuesday;

                                                         tuesday();

                                                     }
                                                     if (weekday ==
                                                         "Wednesday" ||
                                                         weekday ==
                                                             "WednesDay") {
                                                       // week = DateTime.wednesday ;

                                                         wednesday();

                                                     }
                                                     if (weekday ==
                                                         "Thursday" ||
                                                         weekday ==
                                                             "ThursDay") {
                                                       // week = DateTime.thursday;
                                                       thursday();
                                                     }
                                                     if (weekday == "Friday" ||
                                                         weekday == "FriDay") {
                                                       // week = DateTime.friday as DateTime;
                                                       friday();
                                                     }
                                                     if (weekday ==
                                                         "Saturday" ||
                                                         weekday ==
                                                             "SaturDay") {
                                                       // week = DateTime.saturday ;
                                                       saturday();
                                                     }
                                                     if (weekday == "Sunday" ||
                                                         weekday == "SunDay") {
                                                       // week = DateTime.sunday;
                                                       sunday();
                                                     }
                                                   }
                                                   else{
                                                     Fluttertoast.showToast(
                                                         msg: "Please choose time slot to check date availability",
                                                         toastLength: Toast.LENGTH_LONG,
                                                         gravity: ToastGravity.BOTTOM,
                                                         timeInSecForIosWeb: 1,
                                                         backgroundColor: Colors.red,
                                                         textColor: Colors.white,
                                                         fontSize: 12.0);
                                                   }
                                                  }, icon: Icon(Icons.calendar_month,size: 30,color: Theme.of(context).primaryColor,)),
                                              ],
                                            )),
                                          ],
                                        ),
                                        SizedBox(height: 10 ,),
                                      ],
                                    ):SizedBox()
                                  ],
                                ),
                              ),
                            ),
                          );
                        }):Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,));
                  }
              ),
            ),
            InkWell(
              onTap: (){
                if(selectedIndex==null || deteformat == null){
                  Fluttertoast.showToast(
                      msg: "Select Slot & date to Proceed next page",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 20.0);
                }
                else{
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BookAppointment(
                      time:selectedDate,
                      day:weekday,
                      slot_id:selectedIndex,
                      drname:widget.name,
                      dept:widget.department_name,
                      profile:widget.profile,
                      fees:widget.Fees,
                      exp:widget.Exp,
                      doctId:widget.id,
                      img:widget.img_url,
                    date:deteformat.toString()
                  )));
                }
              },
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: MediaQuery.of(context).size.width*0.8,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1, color: Colors.black)
                  ),
                  child: Text("Continue", style: TextStyle(fontSize: 20, color: Colors.white,),),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }



  var monthss;

  // view popup for selec the date..
  DateTime _selectedDate = DateTime.now();
  monday() {
    List<int> _availableWeekdays = [DateTime.monday];
    showDialog<void>(
      useSafeArea: false,
      context: context,
      builder: (_) => AlertDialog(
        contentPadding: EdgeInsets.all(0),
        content:Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TableCalendar(
              // rowHeight: 40,
              daysOfWeekVisible: true,
              headerVisible: true,
              headerStyle: HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                  titleTextStyle: TextStyle(fontSize: 15)
              ),
              firstDay: DateTime.utc(2023, 1, 1),
              lastDay: DateTime.utc(2050, 12, 31),
              focusedDay: _selectedDate,
              calendarFormat: CalendarFormat.month,
              selectedDayPredicate: (day) {
                return _availableWeekdays.contains(day.weekday);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDate = selectedDay;
                  if(_selectedDate.weekday ==DateTime.monday){
                    if(selectedDay.isBefore(DateTime.now())){
                      Fluttertoast.showToast(
                          msg: "Booking not allowed for past Dates",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 12.0);
                    }
                    else{
                      deteformat = DateFormat('dd-MM-yyyy').format(_selectedDate);
                      checkslot();
                    }
                    //  if(_selectedDate.day >= DateTime.now().day && _selectedDate.month >= DateTime.now().month){
                    //   checkslot();
                    // }
                    // else{
                    //   Fluttertoast.showToast(
                    //       msg: "Booking not allowed for past Dates",
                    //       toastLength: Toast.LENGTH_SHORT,
                    //       gravity: ToastGravity.TOP,
                    //       timeInSecForIosWeb: 2,
                    //       backgroundColor: Colors.red,
                    //       textColor: Colors.white,
                    //       fontSize: 12.0);
                    // }
                  }
                  else{
                    Fluttertoast.showToast(
                        msg: "Must be select the appropriate date \n that belongs to selected weekday",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 2,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 12.0);
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }


  tuesday() {
    List<int> _availableWeekdays = [DateTime.tuesday];
    showDialog<void>(
      context: context,
      builder: (_) => Dialog(
        child:Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TableCalendar(
              daysOfWeekVisible: true,
              headerVisible: true,
              headerStyle: HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                  titleTextStyle: TextStyle(fontSize: 15)
              ),
              firstDay: DateTime.utc(2023, 1, 1),
              lastDay: DateTime.utc(2050, 12, 31),
              focusedDay: _selectedDate,
              calendarFormat: CalendarFormat.month,
              selectedDayPredicate: (day) {
                return _availableWeekdays.contains(day.weekday);
              },
              onDaySelected: (selectedDay, focusedDay) {
                print("aaaaa");
                print(focusedDay);
                print(_selectedDate);
                setState(() {
                  _selectedDate = selectedDay;
                  deteformat = DateFormat('dd-MM-yyyy').format(_selectedDate);
                  if(_selectedDate.weekday ==DateTime.tuesday){
                    if(selectedDay.isBefore(DateTime.now())){
                      Fluttertoast.showToast(
                          msg: "Booking not allowed for past Dates",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 12.0);
                    }
                    else{
                      deteformat = DateFormat('dd-MM-yyyy').format(_selectedDate);
                      checkslot();
                    }
                  }
                  else{
                    Fluttertoast.showToast(
                        msg: "Must be select the appropriate date \n that belongs to selected weekday",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 2,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 12.0);
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }


  wednesday() {
    List<int> _availableWeekdays = [DateTime.wednesday];
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        content:Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TableCalendar(
              daysOfWeekVisible: true,
              headerVisible: true,
              headerStyle: HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
                  titleTextStyle: TextStyle(fontSize: 15)
              ),
              firstDay: DateTime.utc(2023, 1, 1),
              lastDay: DateTime.utc(2050, 12, 31),
              focusedDay: _selectedDate,
              calendarFormat: CalendarFormat.month,
              selectedDayPredicate: (day) {
                return _availableWeekdays.contains(day.weekday);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDate = selectedDay;
                  deteformat = DateFormat('dd-MM-yyyy').format(_selectedDate);
                  if(_selectedDate.weekday ==DateTime.wednesday){
                    if(selectedDay.isBefore(DateTime.now())){
                      Fluttertoast.showToast(
                          msg: "Booking not allowed for past Dates",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 12.0);
                    }
                    else{
                      deteformat = DateFormat('dd-MM-yyyy').format(_selectedDate);
                      checkslot();
                    }
                  }
                  else{
                    Fluttertoast.showToast(
                        msg: "Must be select the appropriate date \n that belongs to selected weekday",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 2,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 12.0);
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }


  thursday() {
    List<int> _availableWeekdays = [DateTime.thursday];
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        content:Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TableCalendar(
              daysOfWeekVisible: true,
              headerVisible: true,
              headerStyle: HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                  titleTextStyle: TextStyle(fontSize: 15)
              ),
              firstDay: DateTime.utc(2023, 1, 1),
              lastDay: DateTime.utc(2050, 12, 31),
              focusedDay: _selectedDate,
              calendarFormat: CalendarFormat.month,
              selectedDayPredicate: (day) {
                return _availableWeekdays.contains(day.weekday);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDate = selectedDay;
                  deteformat = DateFormat('dd-MM-yyyy').format(_selectedDate);
                  if(_selectedDate.weekday ==DateTime.thursday){
                    if(selectedDay.isBefore(DateTime.now())){
                      Fluttertoast.showToast(
                          msg: "Booking not allowed for past Dates",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 12.0);
                    }
                    else{
                      deteformat = DateFormat('dd-MM-yyyy').format(_selectedDate);
                      checkslot();
                    }
                  }
                  else{
                    Fluttertoast.showToast(
                        msg: "Must be select the appropriate date \n that belongs to selected weekday",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 2,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 12.0);
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }


  friday() {
    List<int> _availableWeekdays = [DateTime.friday];

    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        content:Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TableCalendar(
              daysOfWeekVisible: true,
              headerVisible: true,
              headerStyle: HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                  titleTextStyle: TextStyle(fontSize: 15)
              ),
              firstDay: DateTime.utc(2023, 1, 1),
              lastDay: DateTime.utc(2050, 12, 31),
              focusedDay: _selectedDate,
              calendarFormat: CalendarFormat.month,
              selectedDayPredicate: (day) {
                return _availableWeekdays.contains(day.weekday);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDate = selectedDay;
                  deteformat = DateFormat('dd-MM-yyyy').format(_selectedDate);
                  if(_selectedDate.weekday ==DateTime.friday){
                    if(selectedDay.isBefore(DateTime.now())){
                      Fluttertoast.showToast(
                          msg: "Booking not allowed for past Dates",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 12.0);
                    }
                    else{
                      deteformat = DateFormat('dd-MM-yyyy').format(_selectedDate);
                      checkslot();
                    }
                  }
                  else{
                    Fluttertoast.showToast(
                        msg: "Must be select the appropriate date \n that belongs to selected weekday",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 2,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 12.0);
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }


  saturday() {
    List<int> _availableWeekdays = [DateTime.saturday];
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        content:Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TableCalendar(
              daysOfWeekVisible: true,
              headerVisible: true,
              headerStyle: HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                  titleTextStyle: TextStyle(fontSize: 15)
              ),
              firstDay: DateTime.utc(2023, 1, 1),
              lastDay: DateTime.utc(2050, 12, 31),
              focusedDay: _selectedDate,
              calendarFormat: CalendarFormat.month,
              selectedDayPredicate: (day) {
                return _availableWeekdays.contains(day.weekday);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDate = selectedDay;
                  deteformat = DateFormat('dd-MM-yyyy').format(_selectedDate);
                  if(_selectedDate.weekday ==DateTime.saturday){
                    if(selectedDay.isBefore(DateTime.now())){
                      Fluttertoast.showToast(
                          msg: "Booking not allowed for past Dates",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 12.0);
                    }
                    else{
                      deteformat = DateFormat('dd-MM-yyyy').format(_selectedDate);
                      checkslot();
                    }
                  }
                  else{
                    Fluttertoast.showToast(
                        msg: "Must be select the appropriate date \n that belongs to selected weekday",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 2,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 12.0);
                  }
                });
              },
            ),

          ],
        ),
      ),
    );
  }


  sunday() {
    List<int> _availableWeekdays = [DateTime.sunday];
    showDialog<void>(
      routeSettings: RouteSettings(),
      context: context,
      builder: (_) => AlertDialog(
        content:Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TableCalendar(
              daysOfWeekVisible: true,
              headerVisible: true,
              headerStyle: HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                  titleTextStyle: TextStyle(fontSize: 15)
              ),
              firstDay: DateTime.utc(2023, 1, 1),
              lastDay: DateTime.utc(2050, 12, 31),
              focusedDay: _selectedDate,
              calendarFormat: CalendarFormat.month,
              selectedDayPredicate: (day) {
                return _availableWeekdays.contains(day.weekday);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDate = selectedDay;
                  deteformat = DateFormat('dd-MM-yyyy').format(_selectedDate);
                  if(_selectedDate.weekday ==DateTime.sunday){
                    if(selectedDay.isBefore(DateTime.now())){
                      Fluttertoast.showToast(
                          msg: "Booking not allowed for past Dates",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 12.0);
                    }
                    else{
                      deteformat = DateFormat('dd-MM-yyyy').format(_selectedDate);
                      checkslot();
                    }
                  }
                  else{
                    Fluttertoast.showToast(
                        msg: "Must be select the appropriate date \n that belongs to selected weekday",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.SNACKBAR,
                        timeInSecForIosWeb: 2,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 12.0);
                  }
                });
              },
            ),

          ],
        ),
      ),
    );
  }

  // check slot avaibality
  var avl_slot;
  var mssg;
  var deteformat;

  checkslot() async {
    final response = await http.post(
      Uri.parse(
          "https://app.healthcrad.com/api/index.php/api/Mobile_app/checkslot"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "date":deteformat.toString(),
        "slot":no_slot
      }),
    );
    final data = jsonDecode(response.body);

    if (data['error'] == '200') {
      avl_slot = data['available slot'];
      mssg = data['msg'];
      if(avl_slot == "0" || avl_slot == "null"){
        Fluttertoast.showToast(
            msg:"Bookings not availaable for the selected date please select another date" ,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
       }
       else {
         Navigator.pop(context);
         Fluttertoast.showToast(
             msg:avl_slot +" Slots Available on ${deteformat}",
             toastLength: Toast.LENGTH_SHORT,
             gravity: ToastGravity.TOP,
             timeInSecForIosWeb: 1,
             backgroundColor: Colors.green,
             textColor: Colors.white,
             fontSize: 16.0);
       }
    }
    else{
      print("function nahi chala");
    }
     }

// Fetch Schedule data...
  Future<List<schedul>> bowe() async{
    final response = await http.post(
      Uri.parse('https://app.healthcrad.com/api/index.php/api/Mobile_app/doctor_getshift'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "doctor_id": widget.id
      }),

    );

    var jsond = json.decode(response.body)["data"];
    List<schedul> allround = [];
    for (var o in jsond)  {
      schedul al = schedul(
        o["id"],
        o["s_time"],
        o["e_time"],
        o["weekday"],
        o["hospital_id"],
        o["date"],
        o["slot1"],
        o["slot2"],
        o["slot3"],
        o["slottime1"],
        o["slottime2"],
        o["slottime3"],
      );
      allround.add(al);
    }
    return allround;
  }
}
class schedul {
  String? id;
  String? s_time;
  String? e_time;
  String? weekday;
  String? hospital_id;
  String? date;
  String? slot1;
  String? slot2;
  String? slot3;
  String? slottime1;
  String? slottime2;
  String? slottime3;
  schedul(
      this.id,
      this.s_time,
      this.e_time,
      this.weekday,
      this.hospital_id,
      this.date,
      this.slot1,
      this.slot2,
      this.slot3,
      this.slottime1,
      this.slottime2,
      this.slottime3,
      );

}
