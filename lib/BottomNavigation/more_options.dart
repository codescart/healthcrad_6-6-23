import 'dart:convert';
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:healthcrad_user/Auth/Login/UI/login_page.dart';
import 'package:healthcrad_user/BottomNavigation/More/Order/recent_orders_page.dart';
import 'package:healthcrad_user/BottomNavigation/More/change_language_page.dart';
import 'package:healthcrad_user/BottomNavigation/More/faq_page.dart';
import 'package:healthcrad_user/BottomNavigation/More/profile_view.dart';
import 'package:healthcrad_user/BottomNavigation/More/saved_addresses_page.dart';
import 'package:healthcrad_user/BottomNavigation/More/support_page.dart';
import 'package:healthcrad_user/BottomNavigation/More/tnc.dart';
import 'package:healthcrad_user/BottomNavigation/appointments_page.dart';
import 'package:healthcrad_user/Locale/locale.dart';
import 'package:healthcrad_user/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:healthcrad_user/apiconstant.dart';
import 'package:healthcrad_user/previcypolicy.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MoreOptions extends StatefulWidget {
  @override
  _MoreOptionsState createState() => _MoreOptionsState();
}

class MenuTile {
  String? title;
  String? subtitle;
  IconData iconData;
  Function onTap;
  MenuTile(this.title, this.subtitle, this.iconData, this.onTap);
}

class _MoreOptionsState extends State<MoreOptions> {

  @override
  void initState() {
    super.initState();
    getData();
  }

  var data;
  Future<void> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'user_id';
    final user_id = prefs.getString(key) ?? 0;
    final response = await http.post(
      Uri.parse(Api.baseurl+"profile"),
      body: json.encode(
        {
          "id": "$user_id",
        },
      ),
    );
   final datas = jsonDecode(response.body)["data"];
    if (response.statusCode == 200) {

        data = datas;
      print('Got Data');
      print(data);
    } else {
      // print('Failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    List<MenuTile> _menu = [
      MenuTile("My Profile", "Update Account", Icons.person,
              () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => profile_view(
              Name: data['username'].toString(),
              Phone: data['phone'].toString(),
              Email: data['email'].toString(),
              Image: data['image'].toString(),
              em_no1: data['emergency_mobile_no_1'].toString(),
              em_no2: data['emergency_mobile_no_2'].toString(),
              em_no3: data['emergency_mobile_no_3'].toString(),
            )));
          }),
      MenuTile("Appointments", "Appointment History",
          Icons.access_alarms_outlined, () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AppointmentPage()));
          }),
      MenuTile("Ambulance", "Booking History", Icons.car_repair,
              () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ambulance_view()));
          }),
      MenuTile(locale.myOrders, locale.orderStatus, Icons.motorcycle, () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => RecentOrdersPage()));
      }),
      MenuTile(locale.myAddress, locale.saveAddress, Icons.location_pin, () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SavedAddressesPage()));
      }),
      MenuTile("Policy", "Privacy Policy", Icons.policy, () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => PrevicyPolicy()));
          }),
      MenuTile(locale.tandc, locale.companyPolicy, Icons.assignment, () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => TnCPage()));
      }),
      MenuTile(locale.faqs, locale.quickAnswer, Icons.announcement, () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => FAQPage()));
      }),
      MenuTile("Help", locale.letUsHelpYou, Icons.message_sharp, () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SupportPage()));
      }),

      MenuTile(locale.logout, locale.logout, Icons.exit_to_app, ()async {
        final prefs= await SharedPreferences.getInstance();
        await prefs.remove("user_id");
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()));
      }),
    ];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          locale.account!,
          style: Theme
              .of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        toolbarTextStyle: Theme
            .of(context)
            .textTheme
            .bodyText2,
        titleTextStyle: Theme
            .of(context)
            .textTheme
            .headline6,
      ),
      body: FutureBuilder(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            else {
              return ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 1),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 20),
                          child: FadedScaleAnimation(
                              Stack(
                                children: [
                                  Container(
                                      height: 100,
                                      width: 100,
                                      child:data['image']==null?CircleAvatar(): CircleAvatar(
                                          backgroundImage:NetworkImage("https://app.healthcrad.com/api/uploads/"+data['image'].toString()),
                                      )
                                  ),
                                ],
                              )
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 40),
                          child: RichText(
                              text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                  text: data['username'] ?? 'Your Name',
                                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600, color: Colors.black)
                                ),
                                TextSpan(text: '\n'),
                                TextSpan(
                                    text: '+91' + data['phone'].toString(),
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(color: lightGreyColor)),
                              ])),
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: Theme
                        .of(context)
                        .backgroundColor,
                    child: GridView.builder(
                        itemCount: _menu.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.all(8.0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 1.6,
                            crossAxisCount: 2,
                            mainAxisExtent: 102),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: _menu[index].onTap as void Function()?,
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 6),
                              padding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color:
                                Theme
                                    .of(context)
                                    .scaffoldBackgroundColor,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FadedScaleAnimation(
                                    Text(
                                      _menu[index].title!,
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    durationInMilliseconds: 400,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          _menu[index].subtitle!,
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(
                                              fontSize: 12,
                                              color: lightGreyColor),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Icon(
                                        _menu[index].iconData,
                                        size: 32,
                                        color: Theme
                                            .of(context)
                                            .highlightColor,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              );
            }
          })
    );
  }
}
