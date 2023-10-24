import 'dart:convert';
import 'dart:math';
import 'package:flutter_openmoney/flutter_openmoney.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:healthcrad_user/BottomNavigation/appointments_page.dart';
import 'package:healthcrad_user/BottomNavigation/bottom_navigation.dart';
import 'package:healthcrad_user/Components/entry_field.dart';
import 'package:flutter/material.dart';
import 'package:healthcrad_user/Locale/locale.dart';
import 'package:healthcrad_user/apiconstant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class BookAppointment extends StatefulWidget {
  final String? time;
  final String? day;
  final String? slot_id;
  final String? drname;
  final String? dept;
  final String? profile;
  final String? fees;
  final String? exp;
  final String? doctId;
  final String? img;
  final String? date;
  BookAppointment({
    this.time,
    this.day,
    this.slot_id,
    this.drname,
    this.dept,
    this.profile,
    this.fees,
    this.exp,
    this.doctId,
    this.img, required this.date
  });

  @override
  _BookAppointmentState createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  var selectedIndex;
  var _selectedRadio;
  var _mode;
  late final FlutterOpenmoney flutterOpenmoney;
  token() async{
    final prefs = await SharedPreferences.getInstance();

    var intValue = Random().nextInt(10000000);


    final user_id = prefs.getString('user_id') ?? '0';
    final phone = prefs.getString('phone') ?? '1234567890';
    final email = prefs.getString('email') ?? 'abc@gmail.com';
    final paymentres= await http.post(Uri.parse('https://icp-api.bankopen.co/api/payment_token'),

      headers: <String, String>{
        "Authorization": "Bearer f85d5380-b73c-11ed-8e44-6db0310598b2:62483c420201ac1ac48b5735a894f4bd25b3107e",
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "amount": widget.fees.toString(),
        "contact_number": "$phone",
        "email_id": "$email",
        "currency": "INR",
        "mtx": 'Health'+intValue.toString()
      }),
    );
    final data= jsonDecode(paymentres.body)['id'];

    _initPayment(data);

  }
  void _initPayment(data) async {
    /// get from openmoney dashboard
    const accessKey = 'f85d5380-b73c-11ed-8e44-6db0310598b2';

    /// Generated using openmoney create token api in server
    /// refer https://docs.bankopen.com/reference/generate-token
    final paymentToken = data;
    final options = PaymentOptions(accessKey, paymentToken, PaymentMode.live);

    try {
      flutterOpenmoney.initPayment(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async{
    final prefs = await SharedPreferences.getInstance();
    final user_id = prefs.getString('user_id') ?? '0';
    final phone = prefs.getString('phone') ?? '1234567890';
    final email = prefs.getString('email') ?? 'abc@gmail.com';
    // response.paymentId
    final resd=await http.post(Uri.parse('https://app.healthcrad.com/api/index.php/api/Mobile_app/book_appointment'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "paymode": response.paymentId.toString(),
        'user_id': "$user_id" ,
        "slot_id": widget.slot_id.toString(),
        'doctor_id':widget.doctId.toString(),
        "amount": widget.fees.toString(),
        "name":_name.text,
        "age": _age.text,
        "address":_addres.text,
        "phone": _phone.text,
      }),
    );
    final data= jsonDecode(resd.body);
    if(data['error']=='200'){
      Fluttertoast.showToast(
          msg: "Appointment booked  Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNavigation()));

    }else{
      Fluttertoast.showToast(
          msg: "Something Went Wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BookAppointment()));

    Fluttertoast.showToast(
      msg: 'ERROR: ${response.code} - ${response.message}',
      toastLength: Toast.LENGTH_LONG,
    );
  }

  // token() async{
  //   print('pppppp');
  //   final prefs = await SharedPreferences.getInstance();
  //   final key = 'email';
  //   final key1 = 'phone';
  //   final email = prefs.getString(key) ?? 0;
  //   final phone = prefs.getString(key1) ?? 0;
  //   var intValue = Random().nextInt(10000000);
  //   print('pankaj');
  //   print(intValue);
  //   final paymentres= await http.post(Uri.parse('https://icp-api.bankopen.co/api/payment_token'),
  //
  //     headers: <String, String>{
  //       "Authorization": "Bearer f85d5380-b73c-11ed-8e44-6db0310598b2:62483c420201ac1ac48b5735a894f4bd25b3107e",
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(<String, String>{
  //       "amount": widget.fees.toString(),
  //       "contact_number": "$phone",
  //       "email_id": "$email",
  //       "currency": "INR",
  //       "mtx": 'Health'+intValue.toString()
  //     }),
  //   );
  //   final data= jsonDecode(paymentres.body)['id'];
  //   print(data);
  //   print("payment sucesssssssssssssssss");
  //
  //   _initPayment(data);
  //
  // }
  // void _initPayment(data) async {
  //   /// get from openmoney dashboard
  //   const accessKey = 'f85d5380-b73c-11ed-8e44-6db0310598b2';
  //
  //   /// Generated using openmoney create token api in server
  //   /// refer https://docs.bankopen.com/reference/generate-token
  //   final paymentToken = data;
  //   final options = PaymentOptions(accessKey, paymentToken, PaymentMode.live);
  //
  //   try {
  //     flutterOpenmoney.initPayment(options);
  //   } catch (e) {
  //     debugPrint('Error: e');
  //   }
  // }
  //
  // void _handlePaymentSuccess(PaymentSuccessResponse response) {
  //   bookapoitment(_name.text, _addres.text, _age.text, _phone.text);
  //
  //   Fluttertoast.showToast(
  //     msg: 'SUCCESS: ${response.paymentId}',
  //     toastLength: Toast.LENGTH_LONG,
  //   );
  //   Fluttertoast.showToast(
  //       msg: "Order successfuly placed",
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.CENTER,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: Colors.green,
  //       textColor: Colors.white,
  //       fontSize: 16.0);
  //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AppointmentPage()));
  // }
  //
  // void _handlePaymentError(PaymentFailureResponse response) {
  //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNavigation()));
  //
  //   print("payment failllllllllllllllll");
  //   Fluttertoast.showToast(
  //     msg: 'ERROR: ${response.code} - ${response.message}',
  //     toastLength: Toast.LENGTH_LONG,
  //   );
  // }
  final TextEditingController _name=TextEditingController();
  final TextEditingController _addres=TextEditingController();
  final TextEditingController _age=TextEditingController();
  final TextEditingController _phone=TextEditingController();

  bool _loading =false;
  @override
  void dispose() {
    _name.dispose();
    _addres.dispose();
    _age.dispose();
    _phone.dispose();
    super.dispose();
  }

  var state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
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
                      // color: Colors.green,
                      child:Row(
                        children: [
                          IconButton(onPressed: (){

                          },
                              icon: Icon(Icons.shopping_cart_outlined, color: Colors.black,size: 30,)),
                          // IconButton(onPressed: (){}, icon: Icon(Icons.notifications_none_outlined, color: Colors.black,size: 30,))
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
      body:Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 10, right: 10, top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 40,
                      backgroundImage: NetworkImage("https://app.healthcrad.com/upload/"+widget.img.toString()),
                    ),
                    SizedBox(width: 20,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Dr. "+widget.drname.toString(), style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700),),
                        Text(widget.dept.toString(),style: TextStyle(fontSize: 13, color: Colors.black,fontWeight: FontWeight.w400 ),),
                        Container(
                            width: MediaQuery.of(context).size.width/2,
                            child: Text("(${widget.profile.toString()})",style: TextStyle(fontSize: 10, color: Colors.black,fontWeight: FontWeight.w400),)),
                        Text("Exp: "+widget.exp.toString()+ " years",style: TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.w400),),
                      ],
                    ),
                    Spacer(),
                    Container(
                      height: 50,
                      alignment: Alignment.centerRight,
                      child:  Text(
                        '\₹ ' + widget.fees.toString()+".00",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(fontSize: 15, color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(thickness: 1, color: Colors.grey.withOpacity(0.4),),
              Padding(
                padding:  EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text( "Appointment at:",style: TextStyle(color: Colors.black, fontSize:20, fontWeight:FontWeight.w300)),
                             SizedBox(height: 5,),
                              Text(widget.time.toString(), style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500)),
                              Text(widget.date.toString(), style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500))
                            ]),
                        Container(
                          padding: EdgeInsets.only(
                            left: 10, right: 10, top: 5, bottom: 5
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            border: Border.all(
                              width: 1, color: Colors.black
                            ),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child:Column(
                              children: [
                                Text(widget.day.toString(), style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500))
                              ]
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 30,),
                    Text("This appointment is for: ", style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w400),),
                    SizedBox(height: 20,),
                    Container(
                      padding: EdgeInsets.all(8),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(width: 2, color: Colors.grey.shade200),
                      ),
                      child: Column(
                        children: [
                          EntryField(
                            controller: _name,
                            prefixIcon: Icons.person,
                            hint: "Name",
                          ),
                          SizedBox(height: 8,),
                          EntryField(
                            controller: _addres,
                            prefixIcon: Icons.location_city,
                            hint: "Address",
                          ),
                          SizedBox(height: 8,),
                          EntryField(
                            controller: _age,
                            prefixIcon: Icons.real_estate_agent_outlined,
                            hint: "Age",
                          ),
                          SizedBox(height: 8,),
                          EntryField(
                            controller: _phone,
                            textInputType: TextInputType.number,
                            prefixIcon: Icons.call,
                            hint: "Phone No.",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height/20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: (){
                            final paymode= "Offline/ COD";
                            setState(() {
                              _mode= paymode;
                              _loading=true;
                            });
                            bookapoitment(_name.text, _age.text, _addres.text, _phone.text);
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
                            decoration:BoxDecoration(
                              border: Border.all(
                                width: 1, color: Colors.black
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child:_loading==false? Text("Confirm Appointment", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 15, fontWeight: FontWeight.w400),):CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }

  bookapoitment(String _name,  String _age, String _addres, String _phone) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'user_id';
    final user_id = prefs.getString(key) ?? 0;

    final response = await http.post(
        Uri.parse("https://app.healthcrad.com/api/index.php/api/Mobile_app/book_appointment"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "paymode": "$_mode",
          'user_id': "$user_id" ,
          "slot_id": widget.slot_id.toString(),
          'doctor_id':widget.doctId.toString(),
          "amount": widget.fees.toString(),
          "name":_name,
          "age": _age,
          "address":_addres,
          "phone": _phone,
          "bookdate": widget.date.toString(),
          "time": widget.time.toString(),
        }),
      );
      final data = jsonDecode(response.body);
      if (data['error'] == '200') {
        Fluttertoast.showToast(
            msg: "APPOINTMENT BOOKED SUCCESSFULLY",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AppointmentPage()));
      }
      else {
        Fluttertoast.showToast(
            msg: "Appointment not booked",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
  }
}