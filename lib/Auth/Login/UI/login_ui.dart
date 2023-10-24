import 'dart:convert';
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:healthcrad_user/Auth/Verification/UI/verification_ui.dart';
import 'package:healthcrad_user/Components/custom_button.dart';
import 'package:healthcrad_user/Components/entry_field.dart';
import 'package:healthcrad_user/Locale/locale.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_interactor.dart';
import 'package:http/http.dart' as http;

class LoginUI extends StatefulWidget {
  final LoginInteractor loginInteractor;

  LoginUI(this.loginInteractor);

  @override
  _LoginUIState createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  final TextEditingController _numberController = TextEditingController();

  bool isClicked = false;
  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: FadedSlideAnimation(
        SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height + 20,
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.6,
                  color: Theme.of(context).splashColor,
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Spacer(),
                      Expanded(
                          flex: 2, child: Image.asset('assets/logo_user.png')),
                      Spacer(),
                      Expanded(
                          flex: 4, child: Image.asset('assets/hero_image.png')),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.555),
                      EntryField(
                        hint: locale.enterMobileNumber,
                        textInputType: TextInputType.number,
                        prefixIcon: Icons.phone_iphone,
                        color: Theme.of(context).scaffoldBackgroundColor,
                        controller: _numberController,
                      ),
                      SizedBox(height: 20.0),
                      isClicked== false? CustomButton(onTap: () {
                        if (_numberController.text.isNotEmpty) {
                          setState(() {
                            isClicked= true;
                          });
                          login(_numberController.text);
                        }
                      }):CircularProgressIndicator(color: Theme.of(context).primaryColor,),
                    ],
                  ),
                ),
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

  login(_numberController) async {
    final response = await http.post(
      Uri.parse(
          "https://app.healthcrad.com/api/index.php/api/Mobile_app/userlogin"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'mobile': _numberController,
      }),
    );
    final data = jsonDecode(response.body);
    print(data);
    print("aaaaaassssssssssssssss");
    if (data['error'] == '200') {
      setState(() {
        isClicked= false;
      });
      final otp = data['otp'];
      final status = data['error'];
      final user_id = data['id'];
      final email = data['email'];
      final phone = data['phone'];
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => VerificationUI(
                  otp: otp, mobile: phone, status: status,email:email,userId:user_id)));
    } else {
      setState(() {
        isClicked= false;
      });
      final otp = data['otp'];
      final status = data['error'];
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => VerificationUI(
                  otp: otp, mobile: _numberController, status: status,email:'',userId:'')));
    }
  }
}
