import 'package:flutter/material.dart';
import '../../login_navigator.dart';
import 'login_interactor.dart';
import 'login_ui.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginInteractor {
  @override
  Widget build(BuildContext context) {
    return LoginUI(this);
  }

  @override
  void loginWithFacebook() {
    Navigator.pushNamed(context, LoginRoutes.registration);
  }

  @override
  void loginWithGoogle() {
    Navigator.pushNamed(context, LoginRoutes.registration);
  }

  @override
  void loginWithMobile(String isoCode, String mobileNumber) {
    Navigator.pushNamed(context, LoginRoutes.registration,
        arguments: isoCode + mobileNumber);
  }
}
