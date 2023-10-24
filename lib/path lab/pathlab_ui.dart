import 'package:flutter/material.dart';
import 'package:healthcrad_user/BottomNavigation/Medicine/my_cart.dart';
import 'package:healthcrad_user/ambulance/searchlocation.dart';
import 'package:healthcrad_user/path%20lab/my%20report.dart';
import 'package:healthcrad_user/path%20lab/request_report.dart';

class pathlab_ui extends StatefulWidget {
  const pathlab_ui({Key? key}) : super(key: key);

  @override
  State<pathlab_ui> createState() => _pathlab_uiState();
}

class _pathlab_uiState extends State<pathlab_ui> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        // backgroundColor: Colors.red,
        flexibleSpace: Container(
          // color: Colors.grey,
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 0.5, color: Colors.black26)
              )
            ),
            padding: EdgeInsets.only(top:5, left: 5, right: 5, bottom: 0),
            // height: 220,
            // width: MediaQuery.of(context).size.width/1,
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
                            // margin: EdgeInsets.only(right: 5, left: 25),
                            width:70,
                            // height: 100,
                            // color: Colors.blueGrey,
                            child: Image.asset("assets/doctor_logo.png")),
                        Container(
                          height: 50,
                          // color: Colors.red,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("HealthCrad",  style: TextStyle(fontSize: 23, color: Color(0xff000000), fontWeight: FontWeight.w700,),),
                              Text("Save More, Serve More",  style: TextStyle(fontSize: 11, color: Color(0xff000000), fontWeight: FontWeight.bold,),),
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
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>CartPage()));
                          }, icon: Icon(Icons.shopping_cart_outlined, color: Color(0xff000000),size: 30,)),
                          // IconButton(onPressed: (){}, icon: Icon(Icons.notifications_none_outlined, color: Color(0xff000000),size: 30,))
                        ],
                      ) ,
                    )
                  ],
                ),
                // Container(
                //   height: 40,
                //   width:MediaQuery.of(context).size.width/1.12,
                //   padding: EdgeInsets.only(left: 5, right: 5),
                //   // alignment: Alignment.bottomLeft,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(10),
                //     color: Colors.grey.shade200.withOpacity(0.5),
                //     // border: Border(
                //     //   bottom: BorderSide(width: 0.3, color: Colors.black)
                //     // )
                //   ),
                //   child:
                //   Row(
                //     children: [
                //       Icon(Icons.location_on_outlined, size: 28,color: Theme.of(context).primaryColor,),
                //       SizedBox(width: 12,),
                //       Container(
                //         width:MediaQuery.of(context).size.width/1.3,
                //         child: DropdownButtonHideUnderline(
                //           child:DropdownButton(
                //             icon: Icon(Icons.arrow_drop_down_outlined, size: 35, color: Colors.black,),
                //             hint: Text(
                //               deta.first,
                //               style: TextStyle(
                //                 fontSize: 18,
                //                 color: Theme
                //                     .of(context)
                //                     .hintColor,
                //               ),
                //             ),
                //             items: deta
                //                 .map((item) =>
                //                 DropdownMenuItem<String>(
                //                   value: item,
                //                   child: Text(
                //                     item,
                //                     style: const TextStyle(
                //                       fontSize: 18,
                //                     ),
                //                   ),
                //                 ))
                //                 .toList(),
                //             value: selectValue,
                //             onChanged: (value) {
                //               selectValue = value as String;
                //               setState(() {
                //                 selectValue;
                //               });
                //             },
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // InkWell(
                //   onTap: (){
                //     Navigator.push(context, MaterialPageRoute(builder: (context)=>doctor_search()));
                //   },
                //   child: Container(
                //     height: 45,
                //     width: MediaQuery.of(context).size.width/1.1,
                //     padding: EdgeInsets.only(left: 10, right: 10),
                //     margin: EdgeInsets.only(left: 15, right: 15),
                //     // padding: EdgeInsets.all(5),
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       boxShadow: [
                //         BoxShadow(
                //             offset: Offset(0,2),
                //             color: Colors.grey.shade600.withOpacity(0.6),
                //             spreadRadius: 0, blurRadius: 3
                //         )
                //       ],
                //       borderRadius: BorderRadius.circular(25.0),
                //     ),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Text("Search", style: TextStyle(color: Colors.black, fontSize: 18, ),),
                //         Icon(Icons.search, size: 25, color: Colors.black,)
                //       ],
                //     ),
                //   ),
                // ),
              ],
            )
        ) ,
        // backgroundColor: Theme.of(context).primaryColor,
        titleSpacing: 20,
        automaticallyImplyLeading: false,
        // title: Text(
        //   'HealthCrad',
        //   style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        // ),
        // // centerTitle: true,
        // actions: <Widget>[
        //   Stack(
        //     children: [
        //       IconButton(
        //         icon: Icon(
        //           Icons.shopping_cart,
        //           size: 20, color: Colors.white,
        //         ),
        //         onPressed: () {
        //           Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage()));
        //         },
        //       ),
        //       Positioned.directional(
        //         textDirection: Directionality.of(context),
        //         top: 8,
        //         end: 12,
        //         child: CircleAvatar(
        //           backgroundColor: Colors.red,
        //           radius: 5.5,
        //           child: Center(
        //               child: Text(
        //             '3',
        //             style: Theme.of(context).textTheme.bodyText2!.copyWith(
        //                 color: Theme.of(context).scaffoldBackgroundColor,
        //                 fontSize: 9),
        //           )),
        //         ),
        //       )
        //     ],
        //   ),
        // ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 50),
        child: Column(

          children: [
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>myreport()));
              },
              child: Container(
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
                    Text("My Reports", style:TextStyle(fontSize: 25, ),),
                    Icon(Icons.arrow_right, size: 50, color: Theme.of(context).primaryColor,)
                  ],
                ),
              ),
            ),
            SizedBox(height: 30,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>passient_detail()));
              },
              child: Container(
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
                    Text("Request a report", style:TextStyle(fontSize: 25, ),),
                    Icon(Icons.arrow_right, size: 50, color: Theme.of(context).primaryColor,)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
