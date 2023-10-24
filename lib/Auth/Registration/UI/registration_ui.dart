import 'dart:convert';
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:healthcrad_user/Auth/Login/UI/login_page.dart';
import 'package:healthcrad_user/BottomNavigation/bottom_navigation.dart';
import 'package:healthcrad_user/Components/custom_button.dart';
import 'package:healthcrad_user/Components/entry_field.dart';
import 'package:healthcrad_user/Locale/locale.dart';
import 'package:flutter/material.dart';
import 'package:healthcrad_user/apiconstant.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationUI extends StatefulWidget {

  final String mobila;
  RegistrationUI({Key? key, required this.mobila}) : super(key: key);
  @override
  _RegistrationUIState createState() => _RegistrationUIState();
}

class _RegistrationUIState extends State<RegistrationUI> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  Regisr(String _nameController, String _emailController) async {
    final response = await http.post(
      Uri.parse(Api.baseurl+"reg"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': _nameController,
        'email': _emailController,
        'phone': widget.mobila,
      }),
    );
    final data = jsonDecode(response.body);
    print(data);
    if (data['error'] == '200') {
      print(data);
      print("user id yaha print hai");
      final prefs1 = await SharedPreferences.getInstance();
      final key1 = 'user_id';
      final key2 = 'email';
      final key3 = 'phone';
      final user_id = data['id'];
      final email = data['email'];
      final phone = data['mobile'];
      prefs1.setString(key1, user_id);
      prefs1.setString(key2, email);
      prefs1.setString(key3, phone);
      Fluttertoast.showToast(
          msg: "Register SucessFully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      print("Register SucessFully");
      // final prefs1 = await SharedPreferences.getInstance();
      // final key1 = 'user_id';
      // final mobile = data['id'];
      // prefs1.setString(key1, mobile);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavigation()));
    }
    else {
      Fluttertoast.showToast(
          msg: data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          locale.registerNow!,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.chevron_left)),
        toolbarTextStyle: Theme.of(context).textTheme.bodyText2,
        titleTextStyle: Theme.of(context).textTheme.headline6,
      ),
      body: FadedSlideAnimation(
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            // height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  locale.yourPhoneNumberNotRegistered!,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Theme.of(context).disabledColor, fontSize: 15),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 53,
                ),
                EntryField(
                  prefixIcon: Icons.phone_iphone,
                  // hint: locale.mobileNumber,
                  hint: widget.mobila,
                  initialValue: widget.mobila,
                  readOnly: true,
                ),
                SizedBox(height: 20.0),
                EntryField(
                  controller: _name,
                  prefixIcon: Icons.person,
                  hint: locale.fullName,
                ),
                SizedBox(height: 20.0),
                EntryField(
                  controller: _email,
                  prefixIcon: Icons.mail,
                  hint: locale.emailAddress,
                ),
                SizedBox(height: 20.0),
                CustomButton(onTap: () {
                  Regisr(_name.text, _email.text);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavigation()));
                }),
                SizedBox(height: 19),
                CustomButton(
                    label: locale.backToSignIn,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    textColor: Theme.of(context).hintColor,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                    }),
                SizedBox(
                  height: 60,
                ),
                Text(
                  locale.wellSendAnOTP!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Theme.of(context).disabledColor),
                ),
                // Spacer(flex: 4,),
              ],
            ),
          ),
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
