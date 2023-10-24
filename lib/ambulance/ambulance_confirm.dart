import 'dart:convert';
import 'dart:math';
import 'package:flutter_openmoney/flutter_openmoney.dart';
import 'package:healthcrad_user/BottomNavigation/More/change_language_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:healthcrad_user/BottomNavigation/bottom_navigation.dart';
import 'package:healthcrad_user/Components/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ambulance_confirm extends StatefulWidget {
  final String type;
  final String fromlocation;
  final String tolocation;
  final String amount;
  final String distance;
  final String name;
  final String phone;
  final String from_lat;
  final String from_lan;
  final String to_lan;
  final String to_lat;
   ambulance_confirm({required this.type, required this.fromlocation, required this.tolocation, required this.amount, required this.distance,required this.name, required this.phone,
     required this.from_lat, required this.from_lan, required this.to_lan, required this.to_lat});

  @override
  State<ambulance_confirm> createState() => _ambulance_confirmState();
}

var _selectedRadio;


class _ambulance_confirmState extends State<ambulance_confirm> {
  late final FlutterOpenmoney flutterOpenmoney;

  token() async{
    final prefs = await SharedPreferences.getInstance();

    print('pppppp');
    var intValue = Random().nextInt(10000000);
    print('pankaj');
    print(intValue);
    final user_id = prefs.getString('user_id') ?? '0';
    final phone = prefs.getString('phone') ?? '1234567890';
    final email = prefs.getString('email') ?? 'abc@gmail.com';
    print("ashuuuuuuuuuuuu");
    print(user_id);
    print(phone);
    print("ggggggggggggggggggg");
    print(email);
    final paymentres= await http.post(Uri.parse('https://icp-api.bankopen.co/api/payment_token'),

      headers: <String, String>{
        "Authorization": "Bearer f85d5380-b73c-11ed-8e44-6db0310598b2:62483c420201ac1ac48b5735a894f4bd25b3107e",
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "amount": widget.amount,
        "contact_number": "$phone",
        "email_id": "$email",
        "currency": "INR",
        "mtx": 'Health'+intValue.toString()
      }),
    );
    final data= jsonDecode(paymentres.body)['id'];
    print(data);
    print("payment sucesssssssssssssssss");

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
    final resd=await http.post(Uri.parse('https://app.healthcrad.com/api/index.php/api/Mobile_app/book_ambulance'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'amount':widget.amount,
        'user_id':'$user_id',
        'username': widget.name,
        'phone': widget.phone,
        'address':widget.fromlocation,
        'pickup_address': widget.fromlocation,
        'drop_address': widget.tolocation,
        'ambulance_type': widget.type,
        'distance': widget.distance,
        'paymode': response.paymentId.toString(),
        'originlat': response.paymentId.toString(),
        'originlong': response.paymentId.toString(),
        'destilat': response.paymentId.toString(),
        'destilong': response.paymentId.toString(),

      }),
    );
    final data= jsonDecode(resd.body);
    print("payment sucesssssssssssssssss");
    if(data['error']=='200'){
      Fluttertoast.showToast(
          msg: "Ambulance booked  Successfully",
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
    print("payment failllllllllllllllll");
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ambulance_confirm(type: widget.type, fromlocation: widget.fromlocation, tolocation: widget.tolocation, distance: widget.distance, amount: widget.amount, name: widget.name,
      phone: widget.phone, from_lat: '', from_lan: '', to_lan: '', to_lat: '',)));

    Fluttertoast.showToast(
      msg: 'ERROR: ${response.code} - ${response.message}',
      toastLength: Toast.LENGTH_LONG,
    );
  }

  // void _handleRadioValueChange(var value) {
  //   setState(() {
  //     _selectedRadio = value;
  //   });
  // }


  // token() async{
  //   final prefs = await SharedPreferences.getInstance();
  //   final key = 'email';
  //   final key1 = 'phone';
  //   final email = prefs.getString(key) ?? 0;
  //   final phone = prefs.getString(key1) ?? 0;
  //   print('pppppp');
  //   print(email);
  //   print(phone);
  //   final amount = double.parse(widget.amount);
  //   var intValue = Random().nextInt(10000000);
  //   // print('pankaj');
  //   print(intValue);
  //   final paymentres= await http.post(Uri.parse('https://icp-api.bankopen.co/api/payment_token'),
  //
  //     headers: <String, String>{
  //       "Authorization": "Bearer f85d5380-b73c-11ed-8e44-6db0310598b2:62483c420201ac1ac48b5735a894f4bd25b3107e",
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(<String, String>{
  //       "amount": widget.amount,
  //       "contact_number": "$phone",
  //       "email_id":"$email",
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
  //   print("payment sucesssssssssssssssss");
  //   Fluttertoast.showToast(
  //     msg: 'SUCCESS: ${response.paymentId}',
  //     toastLength: Toast.LENGTH_LONG,
  //   );
  //   ambulance_book();
  // }
  //
  // void _handlePaymentError(PaymentFailureResponse response) {
  //   print("payment failllllllllllllllll");
  //
  //   Fluttertoast.showToast(
  //     msg: 'ERROR: ${response.code} - ${response.message}',
  //     toastLength: Toast.LENGTH_LONG,
  //   );
  // }
  //
  void _handleRadioValueChange(var value) {
    setState(() {
      _selectedRadio = value;
    });
  }
  var state;
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
    appBar: AppBar(
      toolbarHeight: 70,
      flexibleSpace: Container(
      padding: EdgeInsets.only( left: 10, right: 5, bottom: 5),
      child:Column(
        children: [
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
                        Text("HealthCrad",  style: TextStyle(fontSize: 23, color: Colors.black, fontWeight: FontWeight.w700,),),
                        Text("Save More, Serve More",  style: TextStyle(fontSize: 11, color: Colors.black, fontWeight: FontWeight.bold,),),
                      ],
                    ),
                  ),
                ],
              ),
               ],
              ),
             ],
            )
      ) ,
        titleSpacing: 20,
       automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 10,left: 10, right: 10,),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).backgroundColor,
                ),
                child: Column(
                  children: [
                    Container(
                      alignment:Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      // height: 30,
                      child: Text(widget.fromlocation, style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(child: Text("------------------------------------------------", style: TextStyle(color: Colors.black.withOpacity(0.3)),),),
                    Container(
                      alignment:Alignment.center,
                      padding: EdgeInsets.only(bottom: 10),
                      width: MediaQuery.of(context).size.width,
                      // height: 50,
                      child: Text(widget.tolocation, style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height/25,),
              Container(
                padding: EdgeInsets.only(left: 8, right: 8),
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:Theme.of(context).backgroundColor,
                    border: Border.all(width: 1, color: Colors.black)),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Ambulance Type: ", style: TextStyle(fontSize:17, color:Colors.black ),),
                    Center(child: Text(widget.type, style: TextStyle(fontSize:17, color:Theme.of(context).primaryColor ),)),
                  ],
                ) ,
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.02,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    // width:MediaQuery.of(context).size.width/2.2,
                    padding: EdgeInsets.only(top: 8, bottom: 8,left: 8, right: 8),
                    decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        border: Border.all(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: RichText(
                      text: TextSpan(
                          children: [
                            TextSpan(text:"Distance: ", style: TextStyle(fontSize: 17, color:Colors.black)),
                            TextSpan(text:widget.distance, style: TextStyle(fontSize: 17, color:Theme.of(context).primaryColor, fontWeight:FontWeight.w800)),
                          ]
                      ),),
                  ),
                  // Container(
                  //   // width:MediaQuery.of(context).size.width/2.2,
                  //   padding: EdgeInsets.only(top: 8, bottom: 8,left: 8, right: 8),
                  //   decoration: BoxDecoration(
                  //       color: Theme.of(context).backgroundColor,
                  //       border: Border.all(width: 1, color: Colors.black),
                  //       borderRadius: BorderRadius.circular(10)
                  //   ),
                  //   child: RichText(
                  //     text: TextSpan(
                  //         children: [
                  //           TextSpan(text:"Amount: ", style: TextStyle(fontSize: 17, color:Colors.black)),
                  //           TextSpan(text:widget.amount, style: TextStyle(fontSize: 17, color:Theme.of(context).primaryColor, fontWeight:FontWeight.w800)),
                  //         ]
                  //     ),),
                  // ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.02,),
              Container(
                padding: EdgeInsets.only(left: 8, right: 8),
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:Theme.of(context).backgroundColor,
                    border: Border.all(width: 1, color: Colors.black)),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Name: ", style: TextStyle(fontSize:18, color:Colors.black ),),
                    SizedBox(width: 10,),
                    Center(child: Text(widget.name, style: TextStyle(fontSize:20, color:Theme.of(context).primaryColor ),)),
                  ],
                ) ,
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.02,),
              Container(
                padding: EdgeInsets.only(left: 8, right: 8),
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:Theme.of(context).backgroundColor,
                    border: Border.all(width: 1, color: Colors.black)),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Phone: ", style: TextStyle(fontSize:18, color:Colors.black ),),
                    SizedBox(width: 10,),
                    Center(child: Text(widget.phone, style: TextStyle(fontSize:20, color:Theme.of(context).primaryColor ),)),
                  ],
                ) ,
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.02,),
              // Container(
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(10),
              //       color:Theme.of(context).backgroundColor,
              //       border: Border.all(width: 1, color: Colors.black)),
              //   child:  Column(
              //     children: [
              //       SizedBox(height: 8,),
              //       Text("Payment Methods",style: TextStyle(fontSize: 22, color: Colors.black),),
              //       SizedBox(height: 15,),
              //       RadioListTile(
              //         activeColor: Theme.of(context).primaryColor,
              //         value: 0,
              //         groupValue: _selectedRadio,
              //         title: Text("Cash on Delivery",style: TextStyle(fontSize: 18, color:_selectedRadio==0?Theme.of(context).primaryColor: Colors.black)),
              //         onChanged: _handleRadioValueChange,
              //       ),
              //       // RadioListTile(
              //       //   activeColor: Theme.of(context).primaryColor,
              //       //   value: 1,
              //       //   groupValue: _selectedRadio,
              //       //   title: Text("Digital Payment Mode",style: TextStyle(fontSize: 18, color:_selectedRadio==1?Theme.of(context).primaryColor: Colors.black)),
              //       //   onChanged: _handleRadioValueChange,
              //       // ),
              //     ],
              //   ),
              // ),
              SizedBox(height: MediaQuery.of(context).size.height/20,),
              state==true?Container(
                height: 45,
                  padding: EdgeInsets.all( 5),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade600,
                      spreadRadius: 0,
                        blurRadius: 2.5,
                      offset: Offset(2,2)
                    )
                  ],
                  borderRadius: BorderRadius.circular(8),
                  // border: Border.all(width: 1, color: Colors.white),
                  color: Theme.of(context).primaryColor
                ),
                child: Center(child: CircularProgressIndicator(
                  semanticsLabel: "loading",
                 backgroundColor: Colors.white,
                 color: Theme.of(context).primaryColor,
                ),),
              ):
              CustomButton(onTap: () {
                if(widget.fromlocation !=null || widget.tolocation !=null || widget.type !=null || widget.distance !=null || widget.amount !=null ){
                  // if(_selectedRadio==1){
                  //   setState(() {
                  //     state=true;
                  //   });
                  //   // token();
                  //   //   flutterOpenmoney = FlutterOpenmoney();
                  //   //   flutterOpenmoney.on(
                  //   //     FlutterOpenmoney.eventPaymentSuccess,
                  //   //     _handlePaymentSuccess,
                  //   //   );
                  //   //   flutterOpenmoney.on(
                  //   //     FlutterOpenmoney.eventPaymentError,
                  //   //     _handlePaymentError,
                  //   //   );
                  //   token();
                  //   flutterOpenmoney = FlutterOpenmoney();
                  //   flutterOpenmoney.on(
                  //     FlutterOpenmoney.eventPaymentSuccess,
                  //     _handlePaymentSuccess,
                  //   );
                  //   flutterOpenmoney.on(
                  //     FlutterOpenmoney.eventPaymentError,
                  //     _handlePaymentError,
                  //   );
                  // }
                  // if(_selectedRadio==0){
                  //   ambulance_book();
                  // }
                  ambulance_book();
                }
                else
                {
                  Fluttertoast.showToast(
                      msg: "all Informations must required",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }

              },
                label: "Confirm Booking",
              ),
            ],
          ),
        ),
      ),
    ));
  }
  ambulance_book() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'user_id';
    final user_id = prefs.getString(key) ?? 0;
    print(user_id);
    print("hhhhhhhh");
    print(widget.name);
    print(widget.phone);
    print(widget.fromlocation);
    print(widget.tolocation);
    print(widget.type);
    print(widget.distance);
    print(widget.from_lat);
    print(widget.from_lan);
    print(widget.to_lat);
    print(widget.to_lan);
    print("aaaaaaaaa");
    final response = await http.post(
      Uri.parse("https://app.healthcrad.com/api/index.php/api/Mobile_app/book_ambulance"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'amount':widget.amount,
        'user_id':'$user_id',
        'username': widget.name,
        'phone': widget.phone,
        'address':widget.fromlocation,
        'pickup_address': widget.fromlocation,
        'drop_address': widget.tolocation,
        'ambulance_type': widget.type,
        'distance': widget.distance,
        'paymode': "COD",
        'originlat': widget.from_lat,
        'originlong': widget.from_lan,
        'destilat': widget.to_lat,
        'destilong': widget.to_lan,

      }),
    );
    final data = jsonDecode(response.body);
    print(data);
    if (data['error'] == '200') {
      Fluttertoast.showToast(
          msg: "Ambulance Booked Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xff00ff44),
          textColor: Color(0xffffffff),
          fontSize: 16.0);
      print("Register SucessFully");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ambulance_view()));
    }
    else {
      Fluttertoast.showToast(
          msg: data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor:  Color(0xffff0000),
          textColor:  Color(0xffffffff),
          fontSize: 16.0);
    }
  }
}
