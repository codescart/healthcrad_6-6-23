import 'package:healthcrad_user/BottomNavigation/Doctors/doctor_search.dart';
import 'package:healthcrad_user/BottomNavigation/Doctors/list_of_doctors.dart';
import 'package:healthcrad_user/BottomNavigation/Medicine/my_cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthcrad_user/apiconstant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DoctorsHome extends StatefulWidget {
  @override
  _DoctorsHomeState createState() => _DoctorsHomeState();
}

class _DoctorsHomeState extends State<DoctorsHome> {
  String? value = 'Wallington';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.16,
          flexibleSpace: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 0.5, color: Colors.black26))),
              // padding: EdgeInsets.only(top:10, left: 10, right: 5, bottom: 5),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                              padding: EdgeInsets.only(left: 5, right: 5),
                              width: 70,
                              child: Image.asset("assets/doctor_logo.png")),
                          Container(
                            height: 50,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Health",
                                      style: TextStyle(
                                        fontSize: 21.5,
                                        color: Color(0xff084fa1),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      "CRAD",
                                      style: TextStyle(
                                        fontSize: 20.5,
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "Save More, Serve More",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CartPage()));
                                },
                                icon: Icon(
                                  Icons.shopping_cart_outlined,
                                  color: Colors.black,
                                  size: 30,
                                )),
                            // IconButton(onPressed: (){}, icon: Icon(Icons.notifications_none_outlined, color: Colors.black,size: 30,))
                          ],
                        ),
                      )
                    ],
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => doctor_search()));
                    },
                    child: Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width / 1.1,
                      padding: EdgeInsets.only(left: 10, right: 10),
                      margin: EdgeInsets.only(left: 15, right: 15),
                      // padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 2),
                              color: Colors.grey.shade600.withOpacity(0.6),
                              spreadRadius: 0,
                              blurRadius: 3)
                        ],
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Search",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          Icon(
                            Icons.search,
                            size: 25,
                            color: Colors.black,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 8)
                ],
              )),
          // titleSpacing: 20,
          automaticallyImplyLeading: false,
        ),
        body: DoctorsBody());
  }
}

class DoctorsBody extends StatefulWidget {
  @override
  _DoctorsBodyState createState() => _DoctorsBodyState();
}

class _DoctorsBodyState extends State<DoctorsBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(physics: BouncingScrollPhysics(), children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
        ),
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: FutureBuilder<List<Album>>(
              future: bow(),
              builder: (context, snapshot) {
                if (snapshot.hasError) print(snapshot.error);
                return snapshot.hasData
                    ? GridView.count(
                        physics: BouncingScrollPhysics(),
                        childAspectRatio: 2.5,
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        shrinkWrap: true,
                        children: List.generate(
                          snapshot.data!.length,
                          (index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DoctorsPage(
                                            catid: snapshot.data![index].id
                                                .toString())));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(context).backgroundColor,
                                ),
                                child: Center(
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      radius: 30,
                                      backgroundImage: NetworkImage(
                                          "https://app.healthcrad.com/api//uploads/" +
                                              snapshot.data![index].image
                                                  .toString()),
                                    ),
                                    title: Text(
                                      snapshot.data![index].name.toString(),
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.035),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : Center(child: Text("No Doctors Available"));
              }),
        ),
        SizedBox(
          height: 5,
        ),
      ]),
    );
  }
}

class Album {
  String? id;
  String? name;
  String? email;
  String? description;
  String? hospital_id;
  String? image;
  String? department;
  String? profile;
  Album(this.id, this.name, this.email, this.description, this.hospital_id,
      this.image, this.department, this.profile);
}

Future<List<Album>> bow() async {
  final response = await http.post(
    Uri.parse(Api.baseurl + 'doctorcategory'),
  );

  var jsond = json.decode(response.body)["data"];
  List<Album> allround = [];
  for (var o in jsond) {
    Album al = Album(
      o["id"],
      o["name"],
      o["email"],
      o["description"],
      o["hospital_id"],
      o["image"],
      o["department"],
      o["profile"],
    );

    allround.add(al);
  }
  return allround;
}
