import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:healthcrad_user/Routes/routes.dart';
import 'package:healthcrad_user/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:healthcrad_user/Locale/locale.dart';

class HospitalMapView extends StatefulWidget {
  @override
  _HospitalMapViewState createState() => _HospitalMapViewState();
}

class HospitalDetail {
  String image;
  String name;
  String type;
  String location;

  HospitalDetail(this.image, this.name, this.type, this.location);
}

final List<String> categories = [
  'assets/DoctorCategory/Doctors.png',
  'assets/DoctorCategory/Dentists.png',
  'assets/DoctorCategory/Ayurvadic.png',
  'assets/DoctorCategory/Therapist.png',
  'assets/DoctorCategory/Doctors.png',
  'assets/DoctorCategory/Dentists.png',
  'assets/DoctorCategory/Ayurvadic.png',
  'assets/DoctorCategory/Therapist.png',
];

class _HospitalMapViewState extends State<HospitalMapView> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    List<HospitalDetail> _hospitals = [
      HospitalDetail('assets/ProfilePics/dp1.png', 'Apple Hospital',
          'General Hospital', 'Walter street, Wallington, New York.'),
      HospitalDetail('assets/ProfilePics/dp1.png', 'City Light Eye Care',
          'General Hospital', 'Jespora Bridge, Wallington, New York.'),
      HospitalDetail('assets/ProfilePics/dp1.png', 'Silver Soul Hospital',
          'General Hospital', 'Walter street, Wallington, New York.'),
      HospitalDetail('assets/ProfilePics/dp1.png', 'Apple Hospital',
          'General Hospital', 'Walter street, Wallington, New York.'),
      HospitalDetail('assets/ProfilePics/dp1.png', 'City Light Eye Care',
          'General Hospital', 'Jespora Bridge, Wallington, New York.'),
      HospitalDetail('assets/ProfilePics/dp1.png', 'Silver Soul Hospital',
          'General Hospital', 'Walter street, Wallington, New York.'),
    ];
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.chevron_left)),
        title: Text(
          locale.hospitalsNearYou!,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
        ),
      ),
      body: FadedSlideAnimation(
        Stack(
          children: [
            Image.asset(
              'assets/map.png',
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
            Positioned.directional(
              textDirection: TextDirection.ltr,
              child: FadedScaleAnimation(
                Image.asset('assets/map_pin.png'),
                durationInMilliseconds: 400,
              ),
              top: 100,
              start: 250,
              height: 50,
            ),
            Positioned.directional(
              textDirection: TextDirection.ltr,
              child: FadedScaleAnimation(
                Image.asset('assets/map_pin.png'),
                durationInMilliseconds: 400,
              ),
              top: 200,
              start: 70,
              height: 50,
            ),
            Positioned.directional(
              textDirection: TextDirection.ltr,
              child: FadedScaleAnimation(
                Image.asset('assets/map_pin.png'),
                durationInMilliseconds: 400,
              ),
              top: 200,
              start: 300,
              height: 50,
            ),
            Positioned.directional(
              textDirection: TextDirection.ltr,
              child: FadedScaleAnimation(
                Image.asset('assets/map_pin_act.png'),
                durationInMilliseconds: 400,
              ),
              top: 300,
              start: 220,
              height: 50,
            ),
            Positioned.directional(
              textDirection: TextDirection.ltr,
              child: FadedScaleAnimation(
                Image.asset('assets/map_pin.png'),
                durationInMilliseconds: 400,
              ),
              top: 350,
              start: 70,
              height: 50,
            ),
            Positioned.directional(
              textDirection: TextDirection.ltr,
              child: FadedScaleAnimation(
                Image.asset('assets/map_pin.png'),
                durationInMilliseconds: 400,
              ),
              top: 400,
              start: 200,
              height: 50,
            ),
            Positioned.directional(
              textDirection: TextDirection.ltr,
              child: FadedScaleAnimation(
                Image.asset('assets/map_pin.png'),
                durationInMilliseconds: 400,
              ),
              top: 450,
              start: 350,
              height: 50,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 115.3,
                margin: EdgeInsets.only(bottom: 30),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: _hospitals.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, PageRoutes.hospitalInfo);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          margin: EdgeInsets.only(left: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          width: 300,
                          child: Column(
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.only(left: 16),
                                title: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(_hospitals[index].name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    color: black2,
                                                    height: 1.7,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                        Row(
                                          children: [
                                            Text(_hospitals[index].type,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                      fontSize: 11.2,
                                                      color: Color(0xff999999),
                                                    )),
                                            SizedBox(
                                              width: 100,
                                            ),
                                            Icon(
                                              Icons.call,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: 10,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              locale.callNow!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2!
                                                  .copyWith(
                                                      fontSize: 10,
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 14, right: 16.0, top: 15),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.location_pin,
                                      color: Theme.of(context).disabledColor,
                                      size: 10,
                                    ),
                                    Text(
                                      _hospitals[index].location,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                              fontSize: 10,
                                              color: Theme.of(context)
                                                  .disabledColor),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
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
//done
