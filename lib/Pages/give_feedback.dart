import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:healthcrad_user/Components/custom_button.dart';

class GiveFeedback extends StatefulWidget {
  @override
  _GiveFeedbackState createState() => _GiveFeedbackState();
}

class _GiveFeedbackState extends State<GiveFeedback> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Give Feedback',
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FadedSlideAnimation(
        Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
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
                                        .subtitle2!
                                        .copyWith(
                                            fontSize: 30,
                                            fontWeight: FontWeight.w500,
                                            height: 1.4)),
                                TextSpan(
                                    text: 'Cardiac Surgeon \nat Apple Hospital',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(
                                            color:
                                                Theme.of(context).disabledColor,
                                            fontSize: 18,
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
                        'Overall Experience',
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            color: Theme.of(context).disabledColor,
                            fontSize: 22),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: List.generate(
                      5,
                      (index) => Icon(
                        Icons.star,
                        size: 40,
                        color: Color(0xffF29F19),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Brief your experience',
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            color: Theme.of(context).disabledColor,
                            fontSize: 22),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Write your experience',
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 70.0, horizontal: 10.0),
                        filled: true,
                        fillColor: Theme.of(context).backgroundColor,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none)),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomButton(
                onTap: () {
                  //Navigator.pushNamed(context, PageRoutes.appointmentBooked);
                },
                label: 'Confirm Appointment',
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
