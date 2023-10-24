import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:healthcrad_user/Components/custom_button.dart';
import 'package:healthcrad_user/Components/entry_field.dart';
import 'package:healthcrad_user/Locale/locale.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SupportPage extends StatefulWidget {
  @override
  _SupportPageState createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  TextEditingController _name=TextEditingController();
  TextEditingController _phone=TextEditingController();
  TextEditingController _message=TextEditingController();
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.chevron_left)),
        title: Text(
          locale.support!,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        toolbarTextStyle: Theme.of(context).textTheme.bodyText2,
        titleTextStyle: Theme.of(context).textTheme.headline6,
      ),
      body: FadedSlideAnimation(
        Padding(
          padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height -
                  AppBar().preferredSize.height -
                  MediaQuery.of(context).padding.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    locale.howMayWeHelpYou!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Requeat a call",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Color(0xff7c7c7c)),
                  ),
                  Spacer(),
                  EntryField(
                      controller: _name,
                      prefixIcon: Icons.person, hint:"your name"),
                  SizedBox(height: 12.0),
                  EntryField(
                      controller: _phone,
                      prefixIcon: Icons.phone, hint:"phone no."),
                  SizedBox(height: 12.0),
                  EntryField(
                    controller: _message,
                    prefixIcon: Icons.edit,
                    hint: locale.writeYourMsg,
                    maxLines: 4,
                  ),
                  Spacer(),
                  CustomButton(
                    label: locale.submit,
                    onTap: () {
                      help(_name.text, _phone.text, _message.text);
                    },
                  ),
                  Spacer(),
                  Expanded(
                    flex: 4,
                    child: FadedScaleAnimation(
                      Image.asset(
                        'assets/hero_image.png',
                      ),
                      durationInMilliseconds: 400,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
  help(String _name, String _phone, String _message) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'user_id';
    final user_id = prefs.getString(key) ?? 0;
    final response = await http.post(
      Uri.parse("https://app.healthcrad.com/api/index.php/api/Mobile_app/help"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'user_id': "$user_id",
        'name': _name,
        'phone': _phone,
        'message': _message,
      }),
    );
    final data = jsonDecode(response.body);
    if (data['error'] == '200') {
      Fluttertoast.showToast(
          msg: "Call request submit successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor:Colors.green.withOpacity(0.7),
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pop(context);
    }
    else {
      Fluttertoast.showToast(
          msg: data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor:  Color(0xffff0000),
          textColor:  Color(0xffffffff),
          fontSize: 16.0);
    }
  }
}
