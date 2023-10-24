import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:healthcrad_user/Locale/locale.dart';
import 'package:healthcrad_user/Routes/routes.dart';
import 'package:healthcrad_user/Theme/colors.dart';
import 'package:flutter/material.dart';

class AppointmentDetail extends StatefulWidget {
  @override
  _AppointmentDetailState createState() => _AppointmentDetailState();
}

class _AppointmentDetailState extends State<AppointmentDetail> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          locale.appointmentDetails!,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.chevron_left)),
        actions: [
          IconButton(
            icon: Icon(
              Icons.more_vert,
              size: 20,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              //Navigator.pop(context);
            },
          ),
        ],
      ),
      body: FadedSlideAnimation(
        Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: FadedScaleAnimation(
                                Image.asset(
                                  'assets/Doctors/doc1.png',
                                ),
                                durationInMilliseconds: 400,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(top: 22),
                              child: RichText(
                                text: TextSpan(
                                  style: Theme.of(context).textTheme.subtitle2,
                                  children: [
                                    TextSpan(
                                        text: 'Dr.\nJoseph\nWilliamson\n\n',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                height: 1.5,
                                                color: black2)),
                                    TextSpan(
                                        text: locale.cardiacSurgeon! +
                                            ' \n' +
                                            locale.at! +
                                            'Apple Hospital',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                color: lightGreyColor,
                                                fontSize: 13.3,
                                                height: 1.6))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            locale.appointmentOn!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: lightGreyColor, fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            '12 June 2020 | 12:00 pm',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontSize: 18.3,
                                    fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            locale.location!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: lightGreyColor, fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            'Apple Hospital',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontSize: 18.3,
                                    fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Walter street, New York.',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontSize: 13.5, color: lightGreyColor),
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.navigation,
                              size: 20,
                              color: Theme.of(context).primaryColor,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            locale.appointmentFor!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: lightGreyColor, fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            'Chest Pain',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontSize: 18.3, color: Color(0xff3d3d3d)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 80,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 60,
                      color: Theme.of(context).backgroundColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.call,
                            size: 18.5,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            locale.call!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontSize: 16.7,
                                    color: Theme.of(context).primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, PageRoutes.doctorChat);
                      },
                      child: Container(
                        height: 60,
                        color: Theme.of(context).primaryColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.message,
                              size: 18.5,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              locale.chat!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      fontSize: 16.7,
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
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
}
