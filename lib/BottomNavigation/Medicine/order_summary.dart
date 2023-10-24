import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:healthcrad_user/BottomNavigation/Medicine/order_payment.dart';
import 'package:healthcrad_user/Components/custom_button.dart';

class order_summary extends StatefulWidget {
  final String subtotal;
  order_summary({required this.subtotal});

  @override
  State<order_summary> createState() => _order_summaryState();
}
class _order_summaryState extends State<order_summary> {
  final  _pincode=TextEditingController();
  final  _city=TextEditingController();
  final  _name=TextEditingController();
  final  _address=TextEditingController();
  final  _landmark=TextEditingController();
  final  _phonenumber=TextEditingController();
  final discription=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.chevron_left, color: Colors.white,)),
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            "Order Summary",
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(fontSize: 19, fontWeight: FontWeight.w700, color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: FadedSlideAnimation(
          Stack(
            children: [
              ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 5, right: 5, top: 15),
                        alignment: Alignment.centerLeft,
                        child: Text("Add Address: ", style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black, fontSize: 25),),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                        margin: EdgeInsets.only(left: 5, right: 5, top: 15),

                        // height: MediaQuery.of(context).size.height/2,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(8)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    width:MediaQuery.of(context).size.width/2.4,
                                    child: TextField(
                                      controller: _pincode,
                                      decoration: InputDecoration(hintText: "Pincode",
                                          hintStyle: TextStyle(fontSize: 15, color: Colors.grey.withOpacity(0.8), fontWeight: FontWeight.w400)

                                      ),
                                    )),
                                Container(
                                    width:MediaQuery.of(context).size.width/2.4,
                                    child: TextField(
                                      controller: _city,
                                      decoration: InputDecoration(hintText: "City/State",
                                          hintStyle: TextStyle(fontSize: 15, color: Colors.grey.withOpacity(0.8), fontWeight: FontWeight.w400)

                                      ),
                                    )),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                    width:MediaQuery.of(context).size.width/1.1,
                                    child: TextField(
                                      controller: _name,
                                      decoration: InputDecoration(hintText: "Name",
                                          hintStyle: TextStyle(fontSize: 15, color: Colors.grey.withOpacity(0.8), fontWeight: FontWeight.w400)

                                      ),
                                    )),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                    width:MediaQuery.of(context).size.width/1.1,
                                    child: TextField(
                                      controller: _address,
                                      decoration: InputDecoration(hintText: "Address",
                                          hintStyle: TextStyle(fontSize: 15, color: Colors.grey.withOpacity(0.8), fontWeight: FontWeight.w400)

                                      ),
                                    )),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                    width:MediaQuery.of(context).size.width/1.1,
                                    child: TextField(
                                      controller: _landmark,
                                      decoration: InputDecoration(hintText: "Landmark",
                                          hintStyle: TextStyle(fontSize: 15, color: Colors.grey.withOpacity(0.8), fontWeight: FontWeight.w400)
                                      ),
                                    )),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                    width:MediaQuery.of(context).size.width/1.1,
                                    child: TextField(
                                      controller:_phonenumber,
                                      decoration: InputDecoration(hintText: "Phone No",
                                          hintStyle: TextStyle(fontSize: 15, color: Colors.grey.withOpacity(0.8), fontWeight: FontWeight.w400)
                                      ),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        margin: EdgeInsets.only(left: 5, right: 5, top: 15),
                        // height: 100,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(8)
                        ),
                        child: TextField(
                          maxLines: 5,
                          controller: discription,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              hintText: "If you want to add any additional comments regarding your order,\nPlease write here..",
                              hintStyle: TextStyle(fontSize: 15, color: Colors.grey.withOpacity(0.8), fontWeight: FontWeight.w400)
                          ),
                        ),
                      ),
                      // SizedBox(height: MediaQuery.of(context).size.height/15,),
                    ],
                  ),
                  // Container(
                  //     padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                  //     color: Colors.white,
                  //     child:Container(
                  //       height: 40,
                  //       child: Row(
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Container(
                  //             width: MediaQuery.of(context).size.width/1.35,
                  //             child: Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //               children: [
                  //                 Container(
                  //                   child: Row(
                  //                     children: [
                  //                       Text("Deliver to: ", style: TextStyle(fontSize: 12, color:Colors.black),),
                  //                       Text("Ashutosh Tripathi, 202230  ", style: TextStyle(fontSize: 13, color:Colors.black,overflow: TextOverflow.ellipsis,),),
                  //                       Container(
                  //                           alignment: Alignment.center,
                  //                           height: 15, width: 35,
                  //                           decoration: BoxDecoration(
                  //                             // border: Border.all(width: 0.5, color: Colors.black),
                  //                               borderRadius: BorderRadius.circular(5),
                  //                               color: Colors.grey.shade300
                  //                           ),
                  //                           child: Text(" Home ", style: TextStyle(fontSize: 10, color:Colors.black54, fontWeight: FontWeight.bold,),)),
                  //                     ],
                  //                   ),
                  //                 ),
                  //                 Row(
                  //                   children: [
                  //                     Text("16,Near Shiv Mandir,Hospital Road Ballia" ,style: Theme.of(context).textTheme.subtitle1!.
                  //                     copyWith(fontSize: 13, color:Colors.grey.shade500), overflow: TextOverflow.ellipsis,)
                  //                   ],
                  //                 )
                  //               ],
                  //             ),
                  //           ),
                  //           Column(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               InkWell(
                  //                 onTap: () {
                  //                   showDialog(
                  //                       context: context,
                  //                       builder: (BuildContext context) =>
                  //                           _changeAddress(context)
                  //                   );
                  //                 },
                  //                 child: Container(
                  //                   alignment: Alignment.center,
                  //                   height: 30,
                  //                   width: 65,
                  //                   decoration: BoxDecoration(
                  //                     border: Border.all(
                  //                       width: 1, color: Colors.blueGrey,
                  //                     ),
                  //                     borderRadius: BorderRadius.circular(5),
                  //                   ),
                  //                   child: Text("change", style: TextStyle(color: Colors.blue, fontSize: 13),),
                  //                 ),
                  //               )
                  //             ],
                  //           )
                  //         ],
                  //       ),
                  //     )
                  // ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 60,
                  padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                      border: Border(
                        bottom: BorderSide(width: 1, color: Colors.black),
                        top: BorderSide(width: 1, color: Colors.black),
                      )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(text: TextSpan(
                          children: [
                            TextSpan(text: "Total:  ", style: TextStyle(fontSize: 20, color: Colors.black)),
                            TextSpan(text:"Rs. "+ widget.subtotal,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600, color:Theme.of(context).primaryColor))
                          ]
                      )),
                      Container(
                        width: MediaQuery.of(context).size.width/2.5,
                        child: CustomButton(
                          onTap: () async{
                            if(_name.text.isNotEmpty && _phonenumber.text.isNotEmpty && _city.text.isNotEmpty && _address.text.isNotEmpty && _landmark.text.isNotEmpty && _pincode.text.isNotEmpty){
                              Fluttertoast.showToast(
                                  msg: "Proceed to next step",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>order_pay(
                                  discription:discription.text,
                                amount:widget.subtotal,
                                address:_name.text+', '+_address.text+', '+_landmark.text+', '+_city.text+', '+ _pincode.text+', mob -'+_phonenumber.text

                              )));
                            }
                            else{
                              Fluttertoast.showToast(
                                  msg: "fill all details",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          },
                          radius: 10,
                          label:"Place Order",
                          textSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          beginOffset: Offset(0, 0.3),
          endOffset: Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
        ),
      ),
    );
  }
}
