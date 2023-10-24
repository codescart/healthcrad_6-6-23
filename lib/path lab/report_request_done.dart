import 'dart:async';

import 'package:flutter/material.dart';
import 'package:healthcrad_user/path%20lab/my%20report.dart';

class request_confirm extends StatefulWidget {
  const request_confirm({Key? key}) : super(key: key);

  @override
  State<request_confirm> createState() => _request_confirmState();
}

class _request_confirmState extends State<request_confirm> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(
        seconds: 2,
      ),
          () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => myreport(),
        ),
      ),
    );
  }
  @override

  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        flexibleSpace: Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 0.5, color: Colors.black26)
                )
            ),
            padding: EdgeInsets.only(top:5, left: 5, right: 5, bottom: 0),
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
                          IconButton(onPressed: (){}, icon: Icon(Icons.shopping_cart_outlined, color: Color(0xff000000),size: 30,)),
                          IconButton(onPressed: (){}, icon: Icon(Icons.notifications_none_outlined, color: Color(0xff000000),size: 30,))
                        ],
                      ) ,
                    )
                  ],
                ),
              ],
            )
        ) ,
        // backgroundColor: Theme.of(context).primaryColor,
        titleSpacing: 20,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, right: 15, top: 25),
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
                  Text("Request a report", style:TextStyle(fontSize: 25, ),),
                  Icon(Icons.arrow_drop_down, size: 50, color: Theme.of(context).primaryColor,)
                ],
              ),
            ),
            SizedBox(height: 100,),
            CircleAvatar(
              radius: 150,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage("assets/scs.gif"),
            ),
            SizedBox(height: 20,),
            Text("Successfull", style: TextStyle(fontSize: 30, color: Theme.of(context).primaryColor),)
          ],
        ),
      ),
    ));
  }
}
