import 'dart:convert';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:healthcrad_user/BottomNavigation/bottom_navigation.dart';
import 'package:healthcrad_user/Components/custom_button.dart';
import 'package:healthcrad_user/Locale/locale.dart';
import 'package:healthcrad_user/Location/location_page.dart';
import 'package:flutter/material.dart';
import 'package:healthcrad_user/edit_address.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;


class SavedAddressesPage extends StatelessWidget {
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
              icon: Icon(Icons.chevron_left,color: Colors.white)),
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
                        MaterialPageRoute(builder: (context) => LocationPage()));
                  }),
              Container(
                margin:EdgeInsets.only(top: 10,left: 10, right: 10),
                padding:EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1, color: Colors.black26),
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Text("Saved Addresses", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Theme.of(context).primaryColor),),
                    ),
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
                                  child: ListTile(
                                      tileColor: Colors.white,
                                      contentPadding:
                                      EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                                      leading: Icon(
                                        Icons.location_city_outlined,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,
                                        size: 24,
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
                                            Divider(color:Colors.black26,  thickness: 2,)

                                          ],
                                        ),
                                      ),
                                    trailing: IconButton(
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>editSavedAddress(
                                          id: snapshot.data![index].id.toString(),
                                          pincode:snapshot.data![index].pincode.toString(),
                                          name:snapshot.data![index].name.toString(),
                                          city:snapshot.data![index].city.toString(),
                                          address:snapshot.data![index].address.toString(),
                                          landmark:snapshot.data![index].landmark.toString(),
                                          phone:snapshot.data![index].phone.toString(),
                                        )));
                                      }, icon: Icon(Icons.edit),),
                                  ),
                                );
                              }):Text("");
                        })
                  ],
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