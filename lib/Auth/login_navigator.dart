import 'package:flutter/material.dart';
import 'Login/UI/login_page.dart';
import 'Registration/UI/registration_page.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class LoginRoutes {
  static const String root = 'language/';
  static const String loginRoot = 'login/';
  static const String registration = 'login/registration';
  static const String verification = 'login/verification';
}

class LoginNavigator extends StatefulWidget {
  @override
  _LoginNavigatorState createState() => _LoginNavigatorState();
}

class _LoginNavigatorState extends State<LoginNavigator> {
  @override
  Widget build(BuildContext context) {
    return
      Navigator(
        key: navigatorKey,
        initialRoute: LoginRoutes.root,
        onGenerateRoute: (RouteSettings settings) {
          late WidgetBuilder builder;
          switch (settings.name) {
            case LoginRoutes.root:
              builder = (BuildContext _) => LoginPage();
              break;
            case LoginRoutes.loginRoot:
              builder = (BuildContext _) => LoginPage();
              break;
            case LoginRoutes.registration:
              builder = (BuildContext _) =>
                  RegistrationPage(settings.arguments as String?);
              break;

          }
          return MaterialPageRoute(builder: builder, settings: settings);
        },
        onPopPage: (Route<dynamic> route, dynamic result) {
          return route.didPop(result);
        },
    );
  }
}
// WillPopScope(
// onWillPop: () async {
// var canPop = navigatorKey.currentState!.canPop();
// if (canPop) {
// navigatorKey.currentState!.pop();
// }
// return !canPop;
// },)