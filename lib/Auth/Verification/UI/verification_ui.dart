import 'dart:async';
import 'dart:convert';
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:healthcrad_user/Auth/Registration/UI/registration_ui.dart';
import 'package:healthcrad_user/BottomNavigation/bottom_navigation.dart';
import 'package:healthcrad_user/Components/custom_button.dart';
import 'package:healthcrad_user/Components/entry_field.dart';
import 'package:healthcrad_user/Locale/locale.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class VerificationUI extends StatefulWidget {
  //final VerificationInteractor verificationInteractor;
  final String? otp;
  final String? mobile;
  final String? status;
  final String? email;
  final String? userId;
  VerificationUI({this.otp, this.mobile, this.status, this.email, this.userId});

  @override
  _VerificationUIState createState() => _VerificationUIState();

  //VerificationUI(this.verificationInteractor);
}

class _VerificationUIState extends State<VerificationUI> {
  final TextEditingController _controller = TextEditingController();
  int _counter = 20;
  late Timer _timer;
bool isClicked= false;
  _startTimer() {
    _counter = 60; //time counter
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _counter > 0 ? _counter-- : _timer.cancel();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
    //widget.verificationInteractor.verifyNumber();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  otpvalid(String _controller) {
    if (widget.otp == _controller) {
      if (widget.status == '200') {
        setState(() {
          isClicked= false;
        });
        navs();
      } else {
        setState(() {
          isClicked= false;
        });
        Fluttertoast.showToast(
            msg: "Please Register",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => RegistrationUI(mobila: widget.mobile!)));
      }
    }
    else {
      setState(() {
        isClicked= false;
      });
      Fluttertoast.showToast(
          msg: "Wrong Otp",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
navs()async{
  final value=widget.userId!;
  final key='user_id';
  final prefs= await SharedPreferences.getInstance();
  prefs.setString(key, value);

  final value1=widget.mobile!;
  final key1='phone';
  final prefs1= await SharedPreferences.getInstance();
  prefs1.setString(key1, value1);

  final value2=widget.email!;
  final key2='email';
  final prefs2= await SharedPreferences.getInstance();
  prefs2.setString(key2, value2);

  Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (context) => BottomNavigation()));

  Fluttertoast.showToast(
      msg: "Login Successfully",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0);
}

// otp resend..
  resend() async {
    final response = await http.post(
      Uri.parse(
          "https://app.healthcrad.com/api/index.php/api/Mobile_app/resendotp"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'phone': widget.mobile.toString(),
      }),
    );
    }



  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'OTP Verification',
          //locale.phoneVerification!,
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
          child: Container(
            height: MediaQuery.of(context).size.height -
                AppBar().preferredSize.height -
                MediaQuery.of(context).padding.vertical,
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Spacer(),
                Text(
                  'We have sent an OTP verification code\non your given mobile no : +91 ' +
                      widget.mobile!,
                  //locale.weveSentAnOTP!,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Theme.of(context).disabledColor, fontSize: 15),
                  textAlign: TextAlign.center,
                ),
                Spacer(flex: 2),
                EntryField(
                  controller: _controller,
                  hint: locale.enter4DigitOTP,
                  textAlign: TextAlign.center,
                  textInputType:TextInputType.number,
                ),
                SizedBox(height: 20.0),
                isClicked==false?
                CustomButton(
                  onTap: () {
                    setState(() {
                      isClicked= true;
                    });
                    otpvalid(_controller.text);
                    //widget.verificationInteractor.verificationDone();
                  },
                  label: locale.submit,
                ):CircularProgressIndicator(color: Theme.of(context).primaryColor,),
                SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '0:${_counter.toString().padLeft(2, '0')} ' + "min left",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    _counter<1?CustomButton(
                        label: "Resend OTP".toUpperCase(),
                        color: Theme.of(context).scaffoldBackgroundColor,
                        textColor: Theme.of(context).hintColor,
                        padding: 0.0,
                        onTap: _counter < 1
                            ? () {
                          _startTimer();
                          resend();
                          // widget.verificationInteractor.verifyNumber();
                        }
                            : null):Text("OTP Sent")
                  ],
                ),
                Spacer(flex: 12),
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
