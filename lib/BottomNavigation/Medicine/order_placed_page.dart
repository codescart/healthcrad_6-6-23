import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:healthcrad_user/Components/custom_button.dart';
import 'package:healthcrad_user/Locale/locale.dart';
import 'package:healthcrad_user/Routes/routes.dart';
import 'package:flutter/material.dart';

class OrderPlacedPage extends StatefulWidget {
  @override
  _OrderPlacedPageState createState() => _OrderPlacedPageState();
}

class _OrderPlacedPageState extends State<OrderPlacedPage> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            locale.orderPlaced!,
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
          ),
          automaticallyImplyLeading: false,
        ),
        body: FadedSlideAnimation(
          Stack(
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Spacer(),
                    FadedScaleAnimation(
                      Image.asset(
                        'assets/img_orderplaced.png',
                        scale: 2.7,
                      ),
                      durationInMilliseconds: 400,
                    ),
                    Spacer(),
                    Text(
                      locale.yourOrderPlaced!,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 16.8,
                            color: Theme.of(context).primaryColor,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 27,
                    ),
                    Text(
                      locale.yourOrderHasBeenPlaced!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Color(0xff6c6c6c)),
                      textAlign: TextAlign.center,
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, PageRoutes.recentOrder);
                      },
                      child: Text(
                        locale.myOrders!,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: CustomButton(
                  onTap: () {
                    Navigator.pushNamed(context, PageRoutes.bottomNavigation);
                  },
                  label: locale.continueShopping,
                  radius: 0,
                ),
              ),
            ],
          ),
          beginOffset: Offset(0, 0.3),
          endOffset: Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
        ));
  }
}
