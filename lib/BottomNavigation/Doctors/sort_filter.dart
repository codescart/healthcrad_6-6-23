import 'dart:core';
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:healthcrad_user/Components/custom_button.dart';
import 'package:healthcrad_user/Locale/locale.dart';
import 'package:healthcrad_user/Routes/routes.dart';
import 'package:flutter/material.dart';

class SortFilter extends StatefulWidget {
  @override
  _SortFilterState createState() => _SortFilterState();
}

enum RadioList { consultancyfee, ratings, distance }

class _SortFilterState extends State<SortFilter> {
  RadioList? _character = RadioList.consultancyfee;
  String? _selectedRadioButton = 'Consultancy fees';
  RangeValues _currentRangeValues = RangeValues(40, 80);
  bool? maleValue = false;
  bool? femaleValue = false;

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          locale.sortFilter!,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _character = RadioList.consultancyfee;
                _selectedRadioButton = locale.consultancyFees;
                maleValue = false;
                femaleValue = false;
                _currentRangeValues = RangeValues(40, 80);
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Text(
                locale.reset!,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).primaryColor),
              ),
            ),
          ),
        ],
        toolbarTextStyle: Theme.of(context).textTheme.bodyText2,
        titleTextStyle: Theme.of(context).textTheme.headline6,
      ),
      body: FadedSlideAnimation(
        Stack(
          children: [
            Container(
              constraints: BoxConstraints.expand(),
              color: Theme.of(context).backgroundColor,
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            locale.sortBy!,
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Color(0xffb3b3b3),
                                    ),
                          ),
                        ),
                        ListTile(
                          dense: true,
                          title: Text(locale.consultancyFees!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: Color(0xff6c6c6c),
                                  )),
                          trailing: Radio(
                            activeColor: Colors.amber,
                            value: RadioList.consultancyfee,
                            groupValue: _character,
                            onChanged: (RadioList? value) {
                              setState(() {
                                _character = value;
                                _selectedRadioButton = locale.consultancyFees;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          dense: true,
                          title: Text(locale.rating!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: Color(0xff6c6c6c),
                                  )),
                          trailing: Radio(
                            activeColor: Colors.amber,
                            value: RadioList.ratings,
                            groupValue: _character,
                            onChanged: (RadioList? value) {
                              setState(() {
                                _character = value;
                                _selectedRadioButton = locale.rating;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          dense: true,
                          title: Text(locale.distance!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: Color(0xff6c6c6c),
                                  )),
                          trailing: Radio(
                            activeColor: Colors.amber,
                            value: RadioList.distance,
                            groupValue: _character,
                            onChanged: (RadioList? value) {
                              setState(() {
                                _character = value;
                                _selectedRadioButton = locale.distance;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            _selectedRadioButton!,
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Color(0xffb3b3b3),
                                    ),
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              '1 \$',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      fontSize: 15,
                                      color: Color(0xff6c6c6c),
                                      fontWeight: FontWeight.bold),
                            ),
                            Spacer(
                              flex: 1,
                            ),
                            Text(
                              '100 \$',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 15),
                            ),
                          ],
                        ),
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                              thumbColor: Colors.amber,
                              activeTrackColor: Theme.of(context).primaryColor),
                          child: RangeSlider(
                            inactiveColor: Theme.of(context).backgroundColor,
                            values: _currentRangeValues,
                            min: 1,
                            max: 100,
                            divisions: 99,
                            labels: RangeLabels(
                              _currentRangeValues.start.round().toString(),
                              _currentRangeValues.end.round().toString(),
                            ),
                            onChanged: (RangeValues values) {
                              setState(() {
                                _currentRangeValues = values;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            locale.gender!,
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Color(0xffb3b3b3),
                                    ),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            // [Monday] checkbox
                            SizedBox(
                              width: 4,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Checkbox(
                                  activeColor: Colors.amber,
                                  value: maleValue,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      maleValue = value;
                                    });
                                  },
                                ),
                                Text(
                                  locale.male!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color: Color(0xff6c6c6c),
                                      ),
                                ),
                              ],
                            ),
                            // [Tuesday] checkbox
                            Spacer(
                              flex: 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Checkbox(
                                  activeColor: Colors.amber,
                                  value: femaleValue,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      femaleValue = value;
                                    });
                                  },
                                ),
                                Text(
                                  locale.female!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color: Color(0xff6c6c6c),
                                      ),
                                ),
                              ],
                            ),
                            Spacer(
                              flex: 3,
                            ),
                            // [Wednesday] checkbox
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomButton(
                onTap: () {
                  Navigator.pushNamed(context, PageRoutes.listOfDoctorsPage);
                },
                label: locale.applyNow,
                radius: 0,
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
//done
