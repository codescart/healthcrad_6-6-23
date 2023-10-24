import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:healthcrad_user/BottomNavigation/More/Order/order_tracking_page.dart';
import 'package:healthcrad_user/Models/order_card_model.dart';
import 'package:healthcrad_user/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:healthcrad_user/Locale/locale.dart';

class OrderInfoPage extends StatelessWidget {
  final OrderCardModel? orderCard;

  OrderInfoPage({this.orderCard});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: theme.dividerColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.chevron_left)),
        backgroundColor: theme.scaffoldBackgroundColor,
        title: Text(
          locale.orderNum! + ' 221451',
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.more_vert_sharp,
                  size: 20, color: theme.primaryColor),
              onPressed: () {})
        ],
        toolbarTextStyle: theme.textTheme.bodyText2,
        titleTextStyle: theme.textTheme.headline6,
      ),
      body: FadedSlideAnimation(
        ListView(
          physics: BouncingScrollPhysics(),
          children: [
            ListTile(
              tileColor: theme.scaffoldBackgroundColor,
              leading: Image.asset(orderCard!.image, height: 40),
              title: Row(
                children: [
                  Text(
                    orderCard!.storeName,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: black2, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Text(
                    orderCard!.status.toUpperCase(),
                    style: theme.textTheme.bodyText1!.copyWith(
                        fontSize: 13.5,
                        color: orderCard!.status.toLowerCase() == 'in transit'
                            ? inProcessColor
                            : orderCard!.status.toLowerCase() == 'confirmed'
                                ? kMainColor
                                : kMainTextColor),
                  ),
                ],
              ),
              subtitle: Row(
                children: [
                  Text(orderCard!.date,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 12, color: Color(0xffb3b3b3))),
                  Spacer(),
                  Text(
                      '\₹' +
                          orderCard!.totalPrice +
                          ' | ' +
                          orderCard!.paymentType,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 12, color: Color(0xffb3b3b3))),
                ],
              ),
            ),
            Stack(
              children: [
                Column(
                  children: [
                    ListTile(
                      leading:
                          Icon(Icons.check_circle, color: theme.primaryColor),
                      title: Text(locale.orderConfirmed!,
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: black2,
                                  )),
                      subtitle: Text('2:00 pm, 11 June 2020',
                          style: theme.textTheme.bodyText1!.copyWith(
                              fontSize: 12, color: Color(0xffb3b3b3))),
                    ),
                    Container(
                      margin: EdgeInsetsDirectional.only(end: 20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Theme.of(context).dividerColor,
                              Theme.of(context).scaffoldBackgroundColor,
                            ],
                            stops: [
                              0.15,
                              0.15
                            ]),
                      ),
                      child: ListTile(
                        leading:
                            Icon(Icons.check_circle, color: theme.primaryColor),
                        title: Text(locale.orderPicked!,
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: black2,
                                    )),
                        subtitle: Text('4:13 pm, 11 June 2020',
                            style: theme.textTheme.caption),
                        trailing: TextButton.icon(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            icon: Icon(
                              Icons.navigation,
                              color: Theme.of(context).primaryColor,
                              size: 17,
                            ),
                            label: Text(
                              locale.track!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color: Theme.of(context).primaryColor),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          OrderTrackingPage()));
                            }
                            // => Navigator.pushNamed(context, PageRoutes.orderTracking),
                            ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.check_circle_outline_outlined,
                          color: theme.disabledColor),
                      title: Text(locale.orderDelivered!,
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Color(0xffcccccc),
                                  )),
                      subtitle: Text(locale.yetToDeliver!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Color(0xffcccccc), fontSize: 12)),
                    ),
                  ],
                ),
                PositionedDirectional(
                  top: 48,
                  start: 16,
                  child: Column(
                    children: [
                      Icon(Icons.more_vert_sharp, color: theme.primaryColor),
                      SizedBox(height: 48),
                      Icon(Icons.more_vert_sharp, color: theme.primaryColor),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              color: theme.scaffoldBackgroundColor,
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(locale.orderedItems!,
                      style: theme.textTheme.caption!.copyWith(fontSize: 13)),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: orderCard!.medicines.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        orderCard!.medicines[index],
                        style: theme.textTheme.bodyText1!
                            .copyWith(color: Color(0xff5b5b5b)),
                      ),
                      subtitle: Text('2 ' + locale.packs!,
                          style: theme.textTheme.bodyText1!.copyWith(
                              fontSize: 11.5, color: Color(0xffb2b2b2))),
                      trailing:
                          Text('\₹8.00', style: theme.textTheme.bodyText1),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              tileColor: theme.scaffoldBackgroundColor,
              leading: ImageIcon(
                AssetImage('assets/ic_prescription.png'),
                size: 20,
                color: theme.primaryColor,
              ),
              title: Text(locale.presciptionUploaded!,
                  style: theme.textTheme.bodyText1!
                      .copyWith(color: Color(0xff2e2b2b))),
              trailing: Icon(Icons.remove_red_eye,
                  size: 20, color: theme.primaryColor),
            ),
            Container(
              margin: EdgeInsets.only(top: 8),
              color: theme.scaffoldBackgroundColor,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(locale.subbTotal!,
                            style: theme.textTheme.bodyText1!.copyWith(
                                fontSize: 13.5, color: Color(0xff5b5b5b))),
                        Text('\₹24.00',
                            style: theme.textTheme.bodyText2!.copyWith(
                                fontSize: 16.7, color: Color(0xff5b5b5b))),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(locale.promoCodeApplied!,
                            style: theme.textTheme.bodyText1!.copyWith(
                                fontSize: 13.5, color: Color(0xff5b5b5b))),
                        Text('- \₹2.00',
                            style: theme.textTheme.bodyText2!.copyWith(
                                fontSize: 16.7, color: Color(0xff5b5b5b))),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(locale.serviceCharge!,
                            style: theme.textTheme.bodyText1!.copyWith(
                                fontSize: 13.5, color: Color(0xff5b5b5b))),
                        Text('\₹4.00',
                            style: theme.textTheme.bodyText2!.copyWith(
                                fontSize: 16.7, color: Color(0xff5b5b5b))),
                      ],
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(locale.amountVaiCOD!,
                        style: theme.textTheme.bodyText1!.copyWith(
                          fontSize: 16.7,
                        )),
                    trailing: Text('\₹ 26.00',
                        style: theme.textTheme.bodyText1!.copyWith(
                          fontSize: 16.7,
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
