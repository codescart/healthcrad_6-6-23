import 'package:healthcrad_user/Components/custom_button.dart';
import 'package:healthcrad_user/Locale/locale.dart';
import 'package:healthcrad_user/Theme/colors.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.only(bottom: 60),
            physics: NeverScrollableScrollPhysics(),
            children: [
              Divider(thickness: 8),
              Padding(
                padding:
                    EdgeInsets.only(top: 10, left: 20, bottom: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Facilities',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Color(0xffb3b3b3)),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Minor OT/Dressing Room',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 13.3, height: 2, color: black2),
                    ),
                    Text(
                      'Emergency Ward',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 13.3, height: 2, color: black2),
                    ),
                    Text(
                      'DRadiology/X-ray facility',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 13.3, height: 2, color: black2),
                    ),
                    Text(
                      'Laboratory Services',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 13.3, height: 2, color: black2),
                    ),
                    Text(
                      'Ambulance Services',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 13.3, height: 2, color: black2),
                    ),
                    Text(
                      '+5 ' + locale.more!,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontSize: 15,
                          height: 2),
                    ),
                  ],
                ),
              ),
              Divider(thickness: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: Text(
                      locale.address!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Color(0xffb3b3b3)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_pin,
                          color: Color(0xff808080),
                          size: 10,
                        ),
                        SizedBox(width: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Walter street, Wallington, New York.',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                      fontSize: 13.5, color: Color(0xff979797)),
                            ),
                            Icon(
                              Icons.navigation,
                              size: 20,
                              color: Theme.of(context).primaryColor,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    child: Image.asset(
                      'assets/map.png',
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomButton(
              onTap: () {
                //Navigator.pushNamed(context, PageRoutes.bookAppointment);
              },
              icon: Icon(
                Icons.call,
                color: Colors.white,
                size: 16,
              ),
              label: locale.callNow,
              radius: 0,
            ),
          ),
        ],
      ),
    );
  }
}
