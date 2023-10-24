import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:healthcrad_user/Locale/locale.dart';
import 'package:flutter/material.dart';

class FAQPage extends StatefulWidget {
  @override
  _FAQPageState createState() => _FAQPageState();
}

class FAQ {
  String? question;
  String answer;

  FAQ(this.question, this.answer);
}

class _FAQPageState extends State<FAQPage> {
  List<double> _isActive = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  ];
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    List<FAQ> _questionList = [
      FAQ("How to login to App?",
          'To lgin the App, simply enter your phone number to generate OTP, then enter the OTO to proceed.'),
      FAQ("How to book an Appointment?",
          ' Open the HealthCRAD app, go to doctor and choose the category of which you want to book doctor from, then search the doctor using name, place, and once you have selected the doctor the choose the day and date of your convenience and then provide patient\'s details and proceed.'),
      FAQ("How to cancel an Appointment?",
          'Go to More > My Appointments > Cancel Appointment.'),
      FAQ(" What if I failed to book?",
          ' If the selected doctor is not available on the selected date and day, the booking might fail.'),
      FAQ(" How to payment?",
          'For now we are only providing offline payment method, either you book an appointment, order any product or book an ambulance you can payment by cash.'),
      FAQ("Payments mode available?",
          'For now we are providing only payment by cash/offline payment.'),
      FAQ(" How to order medicines and othe Medical products?",
          ' Go to medicine and essentials feature, then search the medicine or the medical products you want to buy, then aad to cart buy selecting the quantity, then provide your address and proceed'
              ' If you\'re ordering by prescription, simply go to \'orde by prescription\' option available on the top of medicine and essentials feature, upload the valid prescription then add address and proceed.'),
      FAQ("How to cancel the order?",
          'To cancel the order go to Help section and the write your query and phone number and request callback we will cancel the order after calling.'),
      FAQ("How to book an ambulance?",
          ' To book an ambulance go to ambulance feature the search the pickup and destination, after then select the type of ambulance you want to book provided the necessary details and proceed.'),
      FAQ(" How to cancel the ambulance booking?",
          'Once you book an ambulance we will call you tk confirm the booking, you can cancel the booking at that time, or if you want to cancel the booking in between the.'),
       ];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.chevron_left)),
        title: Text(
          locale.faqs!,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        toolbarTextStyle: Theme.of(context).textTheme.bodyText2,
        titleTextStyle: Theme.of(context).textTheme.headline6,
      ),
      body: FadedSlideAnimation(
        ListView.builder(
            itemCount: _questionList.length,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isActive[index] = _isActive[index] == 0 ? 70 : 0;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16),
                      child: Text(
                        (index + 1).toString() +
                            '. ' +
                            _questionList[index].question!,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    padding: EdgeInsets.only(
                        left: 34, right: 34, top: 10, bottom: 10),
                    height: _isActive[index],
                    child: Text(
                      _questionList[index].answer,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(fontSize: 15, color: Color(0xff666666)),
                    ),
                  ),
                  Divider(
                    thickness: 4,
                    color: Theme.of(context).backgroundColor,
                  ),
                ],
              );
            }),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
