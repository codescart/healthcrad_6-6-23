import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:healthcrad_user/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:healthcrad_user/Routes/routes.dart';
import 'package:healthcrad_user/Locale/locale.dart';

class SearchHistoryPage extends StatefulWidget {
  @override
  _SearchHistoryPageState createState() => _SearchHistoryPageState();
}

class _SearchHistoryPageState extends State<SearchHistoryPage> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      body: FadedSlideAnimation(
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20.0, left: 14, right: 14),
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none),
                    hintText: locale.searchDoctors,
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: textFieldColor, fontSize: 15),
                    filled: true,
                    fillColor: Theme.of(context).backgroundColor,
                    prefixIcon: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: 20,
                        )),
                    suffixIcon: Icon(Icons.search)),
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).backgroundColor,
                padding: const EdgeInsets.only(left: 12.0, top: 16, right: 12),
                margin: const EdgeInsets.only(top: 14),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          locale.recentSearch!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Color(0xffacacac), fontSize: 14.5),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, PageRoutes.listOfDoctorsPage);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  locale.cardio!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color: black2,
                                          fontSize: 13.5,
                                          fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  locale.ophtha!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color: black2,
                                          fontSize: 13.5,
                                          fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  locale.derma!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color: black2,
                                          fontSize: 13.5,
                                          fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/search_experts.png',
                            scale: 2.5,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            locale.searchExpertInField!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: Color(0xffd4d4d4), fontSize: 14.5),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
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
