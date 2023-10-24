import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:healthcrad_user/Components/custom_button.dart';
import 'package:healthcrad_user/Components/entry_field.dart';
import 'package:healthcrad_user/Locale/locale.dart';
import 'package:healthcrad_user/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class CreatePillReminderPage extends StatefulWidget {
  @override
  _CreatePillReminderPageState createState() => _CreatePillReminderPageState();
}

class _CreatePillReminderPageState extends State<CreatePillReminderPage> {
  TextEditingController selectedDaysController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  var time;
  final List<String> days = [
    'Mon',
    'Tues',
    'Wed',
    'Thurs',
    'Fri',
    'Sat',
    'Sun',
  ];

  @override
  void dispose() {
    selectedDaysController.dispose();
    timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.chevron_left)),
        title: Text(
          locale.createPillReminder!,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: FadedSlideAnimation(
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  EntryField(
                    label: locale.pillName,
                    hint: locale.enterPillName,
                  ),
                  EntryField(
                    controller: selectedDaysController,
                    label: locale.selectDays,
                    hint: locale.days,
                    prefixIcon: Icons.event,
                    readOnly: true,
                    onTap: () async {
                      await showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          List<String> selected = [];
                          return Container(
                            height: 300,
                            child: Column(
                              children: [
                                AppBar(
                                  automaticallyImplyLeading: false,
                                  title: Text(
                                    locale.selectDays!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(color: Color(0xff2e2e2e)),
                                  ),
                                  centerTitle: true,
                                  actions: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.close,
                                        size: 18,
                                      ),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                GridView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: days.length,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.all(20),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: 3,
                                    mainAxisSpacing: 12,
                                  ),
                                  itemBuilder: (context, index) => DaysGridItem(
                                    days[index],
                                    (value) {
                                      setState(() {
                                        if (value)
                                          selected.add(days[index]);
                                        else
                                          selected.remove(days[index]);
                                      });
                                    },
                                  ),
                                ),
                                Spacer(),
                                CustomButton(
                                  radius: 0,
                                  label: locale.done,
                                  onTap: () {
                                    setState(() {
                                      selectedDaysController.text =
                                          selected.join(', ');
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                  EntryField(
                    controller: timeController,
                    label: locale.selectTime,
                    hint: locale.time,
                    suffix: Icons.add,
                    readOnly: true,
                    prefixIcon: Icons.notifications,
                    onTap: () {
                      // await showModalBottomSheet(
                      //   context: context,
                      //   enableDrag: false,
                      //   builder: (context) {
                      //     String? time;
                      //     return Container(
                      //       height: 300,
                      //       child: Column(
                      //         children: [
                      //           AppBar(
                      //             automaticallyImplyLeading: false,
                      //             title: Text(
                      //               locale.selectTime!,
                      //               style: Theme.of(context).textTheme.headline6,
                      //             ),
                      //             centerTitle: true,
                      //             actions: [
                      //               IconButton(
                      //                 icon: Icon(Icons.close),
                      //                 onPressed: () => Navigator.pop(context),
                      //               ),
                      //             ],
                      //           ),
                      //           Spacer(),
                      //
                      //           // TimePickerSpinner(
                      //           //   is24HourMode: false,
                      //           //   alignment: Alignment.center,
                      //           //   highlightedTextStyle: Theme.of(context)
                      //           //       .textTheme
                      //           //       .headline4!
                      //           //       .copyWith(fontWeight: FontWeight.w600),
                      //           //   normalTextStyle: Theme.of(context)
                      //           //       .textTheme
                      //           //       .headline5!
                      //           //       .copyWith(
                      //           //           color: Theme.of(context).disabledColor),
                      //           //   spacing: 40,
                      //           //   isForce2Digits: true,
                      //           //   itemHeight: 40,
                      //           //   onTimeChange: (dateTime) {
                      //           //     setState(() {
                      //           //       time = DateFormat.jm().format(dateTime);
                      //           //     });
                      //           //   },
                      //           // ),
                      //           Spacer(),
                      //           CustomButton(
                      //             label: locale.done,
                      //             onTap: () {
                      //               setState(() {
                      //                 timeController.text = time!;
                      //               });
                      //               Navigator.pop(context);
                      //             },
                      //           ),
                      //         ],
                      //       ),
                      //     );
                      DatePicker.showTime12hPicker(context,
                          showTitleActions: true, onChanged: (date) {
                        setState(() {
                          //  time = DatePickerDateOrder.dmy;
                        });
                        //date.timeZoneOffset.inHours.toString();
                      }, onConfirm: (dateTime) {
                        setState(() {
                          //  timeController.text = time;
                        });
                      }, currentTime: DateTime.now());
                    },
                  ),
                ],
              ),
            ),
            CustomButton(
              onTap: () {
                Navigator.pop(context);
              },
              label: locale.setReminder,
              radius: 0,
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

class DaysGridItem extends StatefulWidget {
  final String text;
  final ValueChanged<bool> isSelected;

  DaysGridItem(this.text, this.isSelected);

  @override
  _DaysGridItemState createState() => _DaysGridItemState();
}

class _DaysGridItemState extends State<DaysGridItem> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return FadedSlideAnimation(
      InkWell(
        onTap: () {
          setState(() {
            isSelected = !isSelected;
            widget.isSelected(isSelected);
          });
        },
        child: Text(
          widget.text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color:
                  isSelected ? Theme.of(context).primaryColor : kMainTextColor,
              fontWeight: FontWeight.bold,
              fontSize: 25.2),
        ),
      ),
      beginOffset: Offset(0, 0.3),
      endOffset: Offset(0, 0),
      slideCurve: Curves.linearToEaseOut,
    );
  }
}
