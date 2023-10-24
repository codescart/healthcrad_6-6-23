import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:healthcrad_user/BottomNavigation/Medicine/order_payment.dart';
import 'package:healthcrad_user/BottomNavigation/Medicine/order_summary.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:healthcrad_user/BottomNavigation/bottom_navigation.dart';
import 'package:healthcrad_user/Components/custom_button.dart';
import 'package:healthcrad_user/Locale/locale.dart';
import 'package:healthcrad_user/Location/location_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ordr_opt extends StatefulWidget {
  final String subtotal;
   ordr_opt({required this.subtotal});

  @override
  State<ordr_opt> createState() => _ordr_optState();
}
var  selectedIndex;
var _name;
var _address;
var _landmark;
var _city;
var _pincode;
var _phone;
class _ordr_optState extends State<ordr_opt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNavigation(pageIndex:3)));
            },
            icon: Icon(Icons.chevron_left, color: Colors.white,)),
        title: Text(
          "My Address",
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontSize: 17, fontWeight: FontWeight.w700, color:Colors.white),
        ),
        centerTitle: true,
        toolbarTextStyle: Theme.of(context).textTheme.bodyText2,
        titleTextStyle: Theme.of(context).textTheme.headline6,
      ),
      body: Container(
        color: Theme.of(context).dividerColor,
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[
            CustomButton(
                icon: Icon(Icons.add, color: Theme.of(context).primaryColor),
                label: AppLocalizations.of(context)!.addNewAddress,
                textColor: Theme.of(context).primaryColor,
                color: Theme.of(context).scaffoldBackgroundColor,
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => order_summary(subtotal: widget.subtotal,)));
                }),
            Container(
              height: MediaQuery.of(context).size.height/1.42,
              margin:EdgeInsets.only(top: 10,left: 10, right: 10),
              padding:EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1, color: Colors.black26),
                  borderRadius: BorderRadius.circular(5)
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text("Select from Saved Addresses", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Theme.of(context).disabledColor),),
                    ),
                    SizedBox(height: 10,),
                    FutureBuilder<List<Address>>(
                        future: UpcomingAppot(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) print(snapshot.error);
                          return snapshot.hasData
                              ? ListView.builder(
                              itemCount: snapshot.data!.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.only(top: 6.0),
                                  child: GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        selectedIndex = snapshot.data![index].id.toString();
                                        _name = snapshot.data![index].name;
                                        _phone = snapshot.data![index].phone;
                                        _address = snapshot.data![index].address;
                                        _landmark = snapshot.data![index].landmark;
                                        _city = snapshot.data![index].city;
                                        _pincode = snapshot.data![index].pincode;
                                        _phone = snapshot.data![index].phone;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:BorderRadius.circular(5),
                                        border:selectedIndex == snapshot.data![index].id? Border.all(width:2, color: Theme.of(context).primaryColor ):
                                        Border.all(width:1, color: Colors.black26 )
                                      ),
                                      child: ListTile(
                                        tileColor: Colors.white,
                                        contentPadding:
                                        EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                        leading: Column(
                                          children: [
                                            Icon(
                                              Icons.location_city_outlined,
                                              color:selectedIndex == snapshot.data![index].id? Theme
                                                  .of(context)
                                                  .primaryColor:Colors.black54,
                                              size: 24,
                                            ),
                                          ],
                                        ),
                                        title: Text("${snapshot.data![index].name}",
                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .bodyText1!),
                                        subtitle: Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${snapshot.data![index].address}"+" , "+"${snapshot.data![index].city}",
                                                style: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(fontSize: 13, color: Color(0xff666666)),
                                              ),
                                              Text(
                                                "${snapshot.data![index].landmark}"+" , "+"${snapshot.data![index].pincode}",
                                                style: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(fontSize: 13, color: Color(0xff666666)),
                                              ),
                                              Text(
                                                "+91 "+"${snapshot.data![index].phone}",
                                                style: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(fontSize: 13, color: Color(0xff666666)),
                                              ),
                                              // Divider(color:Colors.black26,  thickness: 2,)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }):Text("");
                        })
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Align(
              // alignment: Alignment.bottomCenter,
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
                          if(selectedIndex != null){
                            Fluttertoast.showToast(
                                msg: "Proceed to Payment",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>order_pay(
                                discription:"none",
                                amount:widget.subtotal,
                                address:_name+', '+_address+', '+_landmark+', '+_city+', '+ _pincode+', mob -'+_phone

                            )));
                          }
                          else{
                            Fluttertoast.showToast(
                                msg: "Must be select address ",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        },
                        radius: 10,
                        label:"Continue ",
                        textSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
      ,);
  }
  Future<List<Address>> UpcomingAppot() async{
    final prefs = await SharedPreferences.getInstance();
    final key = 'user_id';
    final user_id = prefs.getString(key) ?? 0;
    final response = await http.post(
      Uri.parse('https://app.healthcrad.com/api/index.php/api/Mobile_app/get_addresss?user_id=$user_id'),
    );

    var jsond = json.decode(response.body)["data"];
    List<Address> allround = [];
    for (var o in jsond)  {
      Address al = Address(
        o["id"],
        o["user_id"],
        o["pincode"],
        o["city"],
        o["name"],
        o["address"],
        o["landmark"],
        o["phone"],
      );

      allround.add(al);
    }
    return allround;
  }
}
class Address{
  String? id;
  String? user_id;
  String? pincode;
  String? city;
  String? name;
  String? address;
  String? landmark;
  String? phone;

  Address(
      this.id,
      this.user_id,
      this.pincode,
      this.city,
      this.name,
      this.address,
      this.landmark,
      this.phone
      );
}
