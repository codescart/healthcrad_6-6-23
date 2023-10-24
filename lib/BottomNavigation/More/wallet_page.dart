import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:healthcrad_user/BottomNavigation/More/send_to_bank.dart';
import 'package:healthcrad_user/Components/custom_button.dart';
import 'package:healthcrad_user/Locale/locale.dart';
import 'package:healthcrad_user/Theme/colors.dart';
import 'package:flutter/material.dart';

class WalletCard {
  final String name;
  final String orderDetails;
  final String payment;
  final String earnings;

  WalletCard(this.name, this.orderDetails, this.payment, this.earnings);
}

class WalletPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        ],
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.chevron_left)),
        centerTitle: true,
        title: Text(
          locale.wallet!,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        toolbarTextStyle: Theme.of(context).textTheme.bodyText2,
        titleTextStyle: Theme.of(context).textTheme.headline6,
      ),
      body: FadedSlideAnimation(
        Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 120),
                Container(
                  color: Theme.of(context).backgroundColor,
                  padding:
                      EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0),
                  child: Text(
                    locale.recent!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Color(0xff6a6c74)),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 172.0),
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 15,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20, vertical: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            buildRowChildWallet(theme, 'Well Life Store',
                                '30 June 2018, 11.59 am'),
                            Spacer(),
                            buildRowChildWallet(theme, '\$80.00',
                                '3 ' + locale.items! + ' | COD',
                                alignment: CrossAxisAlignment.end),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 6,
                        color: Theme.of(context).backgroundColor,
                      ),
                    ],
                  );
                },
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 4),
                  child: Text(
                    locale.availableBalance!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 13.5, color: Color(0xff999999)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    '\₹ 520.50',
                    style: theme.textTheme.headline6!.copyWith(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: black2),
                  ),
                ),
              ],
            ),
            Positioned.directional(
              textDirection: Directionality.of(context),
              end: 15,
              top: 90,
              child: CustomButton(
                textSize: 15,
                radius: 0,
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SendToBank()));
                },
                label: locale.addMoney,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }

  Widget buildRowChildWallet(ThemeData theme, String text1, String text2,
      {CrossAxisAlignment? alignment}) {
    return Column(
      crossAxisAlignment: alignment ?? CrossAxisAlignment.start,
      children: <Widget>[
        Text(text1, style: theme.textTheme.bodyText1!),
        SizedBox(height: 6.0),
        Text(
          text2,
          style: theme.textTheme.subtitle2!
              .copyWith(fontSize: 12, color: Color(0xff6a6c74)),
        ),
      ],
    );
  }
}
