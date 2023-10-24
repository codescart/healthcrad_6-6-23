// //
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// //
// // import 'package:razorpay_flutter/razorpay_flutter.dart';
// // import 'package:fluttertoast/fluttertoast.dart';
// //
// // class Payment extends StatefulWidget {
// //   const Payment();
// //   @override
// //   State<StatefulWidget> createState() {
// //     return _MyAppState();
// //   }
// // }
// //
// // class _MyAppState extends State<Payment> {
// //   _MyAppState();
// //   // late Future<Order> futureAlbum;
// //
// //   static const platform = MethodChannel("Sagar sandwich");
// //   late Razorpay _razorpay;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor: Colors.transparent,
// //         shadowColor: Colors.transparent,
// //         title: const Center(
// //           child: Text(
// //             'Razorpay',
// //             style: TextStyle(
// //               color: Colors.black,
// //             ),
// //           ),
// //         ),
// //         automaticallyImplyLeading: false,
// //       ),
// //       body: Column(
// //         children: [
// //
// //           const SizedBox(
// //             height: 20,
// //           ),
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //               ElevatedButton(
// //                 style: ElevatedButton.styleFrom(
// //                     foregroundColor: Colors.white,
// //                     backgroundColor:
// //                     const Color.fromARGB(255, 233, 168, 244), // foreground
// //                     shadowColor: Colors.transparent),
// //                 onPressed: openCheckout,
// //                 child: const Text(
// //                   'Pay total price:-totalPrice',
// //                   style: TextStyle(color: Colors.black),
// //                 ),
// //               )
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     //  (UserSimplePref.getTotalPrice() ?? 1) *
// //     var prices = 100;
// //     print(prices);
// //     _razorpay = Razorpay();
// //     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
// //     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
// //     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
// //   }
// //
// //   @override
// //   void dispose() {
// //     super.dispose();
// //     _razorpay.clear();
// //   }
// //
// //   void openCheckout() async {
// //     var prices = 100;
// //     print(prices);
// //     var options = {
// //       //  double.parse(something) *
// //       'key': 'rzp_live_6PzrGWFzbKwqUN',
// //       'amount': 100,
// //       'name': 'Sagar Sandwich',
// //       'description': "dhfjf",
// //       'retry': {'enabled': true, 'max_count': 1},
// //       'send_sms_hash': true,
// //       'prefill': {'contact': '', 'email': ''},
// //       'external': {
// //         'wallets': ['paytm']
// //       }
// //     };
// //
// //     try {
// //       _razorpay.open(options);
// //     } catch (e) {
// //       debugPrint('Error: e');
// //     }
// //   }
// //
// //   void _handlePaymentSuccess(PaymentSuccessResponse response) {
// //     print('Success Response: $response');
// //
// //     // postOrder(
// //     //   id, price, count, sizee, response.paymentId.toString(), 'upi',
// //     //     totalPrice.toString(), 'success', addressid, context);
// //     Text(response.paymentId.toString());
// //   }
// //
// //   void _handlePaymentError(PaymentFailureResponse response) {
// //     print('Error Response: $response');
// //
// //     Fluttertoast.showToast(
// //         msg: "ERROR: ${response.code} - ${response.message!}",
// //         toastLength: Toast.LENGTH_SHORT);
// //   }
// //
// //   void _handleExternalWallet(ExternalWalletResponse response) {
// //     print('External SDK Response: $response');
// //     Fluttertoast.showToast(
// //         msg: "EXTERNAL_WALLET: ${response.walletName!}",
// //         toastLength: Toast.LENGTH_SHORT);
// //   }
// // }
// //
// // // Future<OrderDetail> postOrder(
// // //   String productId,
// // //   String productprice,
// // //   String count,
// // //   String size,
// // //   String transationId,
// // //   String paymentType,
// // //   String amount,
// // //   String paymentStatus,
// // //   String addressId,
// // //   context,
// // // ) async {
// // //   final prefs = await SharedPreferences.getInstance();
// // //   final token = prefs.getString('logintoken');
// // //   final response = await http.post(
// // //     Uri.parse('https://rbarnsoft.com/sagaradmin/api/create-order'),
// // //     headers: <String, String>{
// // //       "Authorization": 'Bearer $token',
// // //       "Content-Type": 'application/json'
// // //     },
// // //     body: jsonEncode(<String, String>{
// // //       "product_id": productId,
// // //       "product_price": productprice,
// // //       "count": count,
// // //       "size": size,
// // //       "transation_id": transationId,
// // //       "payment_type": paymentType,
// // //       "amount": amount,
// // //       "payment_status": paymentStatus,
// // //       "address_id": addressId,
// // //     }),
// // //   );
// // //   print('ProductID:- $productId');
// // //   print('Productprice:- $productprice');
// // //   print('count:- $count');
// // //   print('size:- $size');
// // //   print('transationId:- $transationId');
// // //   print('paymentType:- $paymentType');
// // //   print('amount:- $amount');
// // //   print('paymentStatus:- $paymentStatus');
// // //   print('addressId:- $addressId');
// // //   print(response.statusCode);
// // //   print(response.request);
// // //   // Fluttertoast.showToast(
// // //   //     msg:
// // //   //         "SUCCESS: $productId productprice $productprice count $count size $size transationId $transationId paymentType $paymentType amount $amount paymentStatus $paymentStatus addressId $addressId",
// // //   //     toastLength: Toast.LENGTH_LONG);
// // //   if (response.statusCode == 200) {
// // //     Navigator.push(
// // //       context,
// // //       MaterialPageRoute(
// //
// // //         builder: (context) => const ThankYouPage(
// // //           title: 'Home',//         ),
// // //       ),
// // //     );
// //
// // //     return OrderDetail.fromJson(jsonDecode(response.body));
// // //   } else {
// // //     // then throw an exception.
// // //     throw Exception('Failed to create order');
// // //   }
// // // }
//
//
//
// import 'package:flutter/material.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
//
//
// class Payment extends StatefulWidget {
//   @override
//   _PaymentState createState() => _PaymentState();
// }
//
// class _PaymentState extends State<Payment> {
//   late Razorpay _razorpay;
//
//   @override
//   void initState() {
//     super.initState();
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _razorpay.clear();
//   }
//
//   void openCheckout() async {
//     var options = {
//       "key": "rzp_live_6PzrGWFzbKwqUN",
//       "amount": 1*100,
//       "name": "Merchant Name",
//       "description": "Purchase Description",
//       "prefill": {
//         "contact": "9123456789",
//         "email": "test@test.com",
//       },
//       "external": {
//         "wallets": ["paytm"]
//       }
//     };
//
//     try {
//       _razorpay.open(options);
//     } catch (e){
//       debugPrint('Error: e');
//     }
//   }
//
//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     Fluttertoast.showToast(
//         msg: "SUCCESS: ",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.green,
//         textColor: Colors.white,
//         fontSize: 16.0);
//   }
//
//   void _handlePaymentError(PaymentFailureResponse response) {
//     Fluttertoast.showToast(
//         msg: "ERROR: " + response.code.toString() + " - ",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//         fontSize: 16.0);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Razorpay Payment Gateway Example'),
//         ),
//         body: Center(
//           child: FloatingActionButton(
//             onPressed: openCheckout,
//             child: Text('Pay with Razorpay'),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class apitest extends StatefulWidget {
  const apitest({Key? key}) : super(key: key);

  @override
  State<apitest> createState() => _apitestState();
}

class _apitestState extends State<apitest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder<List<doctor>>(
            future: medicine(),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){},
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              width: 1, color: Theme.of(context).primaryColor
                          )
                      ),
                      width: MediaQuery.of(context).size.width/1.5,
                      padding: EdgeInsets.only(left: 0, right: 5, top: 0,bottom: 0),
                      margin: EdgeInsets.only(left: 5, right: 5, bottom: 5),

                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color:Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(9),
                                  bottomLeft: Radius.circular(9),
                                )
                            ),
                            height:135,
                            width: MediaQuery.of(context).size.width/6,
                            child: Padding(
                              padding:
                              EdgeInsets.only(top: 8, bottom: 10.0),
                              child: GestureDetector(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Id: "+snapshot.data![index].id.toString(), style: TextStyle(fontSize: 15, color: Colors.white),),
                                    CircleAvatar(
                                      radius: 35,
                                      backgroundImage: AssetImage("assets/doctor_logo.png"),
                                      backgroundColor: Colors.white,
                                    ), // Text(snapshot.data)
                                    Text("₹: "+snapshot.data![index].amount.toString(), style: TextStyle(fontSize: 10, color: Colors.white),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            child: Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width/1.4,
                                  padding: EdgeInsets.only(right: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Name:  "+snapshot.data![index].id.toString().toUpperCase(), style: TextStyle(fontSize: 13, ),),
                                      Text("Phone:  "+snapshot.data![index].uid.toString(), style: TextStyle(fontSize: 13, ),),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Container(
                                  width: MediaQuery.of(context).size.width/1.4,
                                  padding: EdgeInsets.only(right: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Type:  "+snapshot.data![index].productid.toString(), style: TextStyle(fontSize: 13, ),),
                                      Text("Dist:  "+snapshot.data![index].amount.toString(), style: TextStyle(fontSize: 13, ),),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10,),
                                // Container(
                                //   width: MediaQuery.of(context).size.width/1.4,
                                //   padding: EdgeInsets.only(right: 15),
                                //   child: Column(
                                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //     children: [
                                //       Text("from:  "+snapshot.data![index].pickup_address.toString(), style: TextStyle(fontSize: 12, ),),
                                //       SizedBox(height: 5,),
                                //       Text("To:  "+snapshot.data![index].drop_address.toString(), style: TextStyle(fontSize: 12, ),),
                                //     ],
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );

                },
              ):Center(child:CircularProgressIndicator(color: Theme.of(context).primaryColor,));
            })
        ,
      ),
    );
  }
  Future<List<doctor>> medicine() async{
    // final catgId = widget.catid;
    final prefs = await SharedPreferences.getInstance();
    final key = 'user_id';
    final user_id = prefs.getString(key) ?? 0;
    print(user_id);
    final response = await http.get(
      Uri.parse('https://app.healthcrad.com/api/index.php/api/Mobile_app/medicart?userid=1069'),
      // headers:{
      //   'Content-Type': 'application/json; charset=UTF-8',
      // },
      // body: jsonEncode({
      //   "userid":"$user_id"
      // }),
    );
    var jsond = json.decode(response.body);
    print(jsond);
    print("hhhhhhhhhhh");
    List<doctor> allround = [];
    for (var o in jsond)  {
      doctor al = doctor(
        o["id"],
        o["uid"],
        o["productid"],
        o["amount"],
      );
      allround.add(al);
    }
    return allround;
  }

}
class doctor {
  String? id;
  String? uid;
  String? productid;
  String? amount;

  doctor(
      this.id,
      this.uid,
      this.productid,
      this.amount,

      );
}
