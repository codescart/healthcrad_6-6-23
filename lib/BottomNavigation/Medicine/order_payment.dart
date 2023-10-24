import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_openmoney/flutter_openmoney.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:healthcrad_user/BottomNavigation/Medicine/allmedi.dart';
import 'package:healthcrad_user/BottomNavigation/bottom_navigation.dart';
import 'package:healthcrad_user/Components/custom_button.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class order_pay extends StatefulWidget {
  final String discription;
  final String amount;
  final String address;

  order_pay({  required this.discription, required this.amount, required this.address});
  @override
  State<order_pay> createState() => _order_payState();
}
var _selectedRadio=3;

class _order_payState extends State<order_pay> {
  late final FlutterOpenmoney flutterOpenmoney;

  @override
  // void initState() {
  //   super.initState();
  //   token();
  //
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
        "amount": widget.amount,
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
    final resd=await http.post(Uri.parse('https://app.healthcrad.com/api/index.php/api/Check_out/update_address'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "userid":"$user_id",
        "address":widget.address,
        "paymod":"Online Payment",
        "amount":widget.amount,
        "description":widget.discription,
        "tansaction_id":response.paymentId.toString()

      }),
    );
    final data= jsonDecode(resd.body);
    if(data['error']=='200'){
      Fluttertoast.showToast(
          msg: "Order Placed Successfully",
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
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNavigation()));

    Fluttertoast.showToast(
      msg: 'ERROR: ${response.code} - ${response.message}',
      toastLength: Toast.LENGTH_LONG,
    );
  }

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
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.chevron_left, color: Colors.white,)),
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Payments",
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontSize: 19, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body:Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              height: 50, width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 1, color: Colors.black.withOpacity(0.5)
                  ),
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Payment Methods", style:TextStyle(fontSize: 25, ),),
                  Icon(Icons.arrow_drop_down, size: 50, color: Theme.of(context).primaryColor,)
                ],
              ),
            ),
            SizedBox(height: 30,),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color:Theme.of(context).backgroundColor,
                  border: Border.all(width: 1, color: Colors.black)),
              child:  Column(
                children: [
                  RadioListTile(
                    activeColor: Theme.of(context).primaryColor,
                    value: 0,
                    groupValue: _selectedRadio,
                    title: Text("Cash on Delivery",style: TextStyle(fontSize: 18, color:_selectedRadio==0?Theme.of(context).primaryColor: Colors.black)),
                    onChanged: _handleRadioValueChange,
                  ),
                  // RadioListTile(
                  //   activeColor: Theme.of(context).primaryColor,
                  //   value: 1,
                  //   groupValue: _selectedRadio,
                  //   title: Text("Online/Digital ",style: TextStyle(fontSize: 18, color:_selectedRadio==1?Theme.of(context).primaryColor: Colors.black)),
                  //   onChanged: _handleRadioValueChange,
                  // ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Container(
              width: MediaQuery.of(context).size.width/2.5,
              child:state==true?Container(
                height: 35,
                padding: EdgeInsets.all( 5),
                width: MediaQuery.of(context).size.width/2.8,
                decoration:BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade600,
                        spreadRadius: 0,
                        blurRadius: 2.5,
                        offset: Offset(2,2)
                    )
                  ],
                  color: Theme.of(context).primaryColor,
                  //

                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(child: CircularProgressIndicator(
                  semanticsLabel: "loading",
                  backgroundColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                ),),
              ):
              CustomButton(
                onTap: () async{
                  // if(_selectedRadio==1){
                  //   state=true;
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
                  //   // Fluttertoast.showToast(
                  //   //     msg: "Order successfuly placed",
                  //   //     toastLength: Toast.LENGTH_SHORT,
                  //   //     gravity: ToastGravity.CENTER,
                  //   //     timeInSecForIosWeb: 1,
                  //   //     backgroundColor: Colors.green,
                  //   //     textColor: Colors.white,
                  //   //     fontSize: 16.0);
                  //   // Navigator.push(context, MaterialPageRoute(builder: (context)=>Paymenthec()));
                  // }
                  // if(_selectedRadio==0)
                  // else{
                    final prefs = await SharedPreferences.getInstance();
                    final user_id = prefs.getString('user_id') ?? 0;
                    final resd=await http.post(Uri.parse('https://app.healthcrad.com/api/index.php/api/Check_out/update_address'),
                      headers: <String, String>{
                        'Content-Type': 'application/json; charset=UTF-8',
                      },
                      body: jsonEncode(<String, String>{
                        "userid":"$user_id",
                        "address":widget.address,
                        "paymod":"cod",
                        "amount":widget.amount,
                        "description":widget.discription,
                        "tansaction_id":'Cod'
                      }),
                    );
                    final data= jsonDecode(resd.body);
                    if(data['error']=='200'){
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNavigation(pageIndex: 0,)));
                      Fluttertoast.showToast(
                          msg: "Order successfuly placed",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  // }
                  // else{
                  //   Fluttertoast.showToast(
                  //       msg: "Please select payment option",
                  //       toastLength: Toast.LENGTH_SHORT,
                  //       gravity: ToastGravity.CENTER,
                  //       timeInSecForIosWeb: 1,
                  //       backgroundColor: Colors.red,
                  //       textColor: Colors.white,
                  //       fontSize: 16.0);
                  // }
                  // showDialog(
                  //   context: context,
                  //   builder: (BuildContext context) =>
                  //       _prescriptionRequired(context),
                  // );
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>calculator()));
                },
                radius: 8,
                label:"Place Order",
                textSize: 20,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
