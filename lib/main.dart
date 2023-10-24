import 'package:healthcrad_user/Auth/login_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:healthcrad_user/BottomNavigation/bottom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Locale/locale.dart';
import 'Theme/style.dart';
import 'Locale/language_cubit.dart';
import 'map_utils.dart';

void main() async{
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
  MapUtils.getMarkerPic();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final phone = prefs.getString('user_id')??'0';
  runApp(Phoenix(child: Docto(phone: phone)));
}
class Docto extends StatelessWidget {
  String? phone;
  Docto({Key? key,  this.phone}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LanguageCubit>(
      create: (context) => LanguageCubit(),
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (_, locale) {
          return MaterialApp(
            localizationsDelegates: [
              const AppLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            locale: locale,
            theme: appTheme,
            home: phone == '0' ? LoginNavigator() : BottomNavigation(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
