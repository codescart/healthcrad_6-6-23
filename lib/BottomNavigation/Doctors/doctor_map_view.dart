import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:healthcrad_user/Routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:healthcrad_user/Theme/colors.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:healthcrad_user/Locale/locale.dart';

class DoctorMapView extends StatefulWidget {
  @override
  _DoctorMapViewState createState() => _DoctorMapViewState();
}

class SearchDoctorTile {
  String image;
  String name;
  String speciality;
  String hospital;
  String experience;
  String fee;
  String reviews;

  SearchDoctorTile(this.image, this.name, this.speciality, this.hospital,
      this.experience, this.fee, this.reviews);
}

class _DoctorMapViewState extends State<DoctorMapView> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    List<SearchDoctorTile> searchList = [
      SearchDoctorTile('assets/Doctors/doc1.png', 'Dr. Joseph Williamson',
          'Cardiac Surgeon', 'Apple Hospital', '22', '30', '152'),
      SearchDoctorTile('assets/Doctors/doc2.png', 'Dr. Anglina Taylor',
          'Cardiac Surgeon', 'Operum Clinics', '22', '30', '201'),
      SearchDoctorTile('assets/Doctors/doc3.png', 'Dr. Anthony Peterson',
          'Cardiac Surgeon', 'Opus Hospital', '22', '30', '135'),
      SearchDoctorTile('assets/Doctors/doc4.png', 'Dr. Elina George',
          'Cardiac Surgeon', 'Lismuth Hospital', '22', '30', '438'),
      SearchDoctorTile('assets/Doctors/doc1.png', 'Dr. Joseph Williamson',
          'Cardiac Surgeon', 'Apple Hospital', '22', '30', '152'),
      SearchDoctorTile('assets/Doctors/doc2.png', 'Dr. Anglina Taylor',
          'Cardiac Surgeon', 'Operum Clinics', '22', '30', '201'),
      SearchDoctorTile('assets/Doctors/doc3.png', 'Dr. Anthony Peterson',
          'Cardiac Surgeon', 'Opus Hospital', '22', '30', '135'),
      SearchDoctorTile('assets/Doctors/doc4.png', 'Dr. Elina George',
          'Cardiac Surgeon', 'Lismuth Hospital', '22', '30', '438'),
    ];

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.chevron_left)),
        title: FadedScaleAnimation(
          Text(
            locale.mapView! + '\"' + locale.cardio! + '\"',
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
          ),
          durationInMilliseconds: 400,
        ),
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/map.png',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
          ),
          Positioned.directional(
            textDirection: TextDirection.ltr,
            child: FadedScaleAnimation(
              Image.asset('assets/Doctors/doc1.png'),
              durationInMilliseconds: 400,
            ),
            top: 200,
            start: 300,
            height: 50,
          ),
          Positioned.directional(
            textDirection: TextDirection.ltr,
            child: FadedScaleAnimation(
              Image.asset('assets/Doctors/doc2.png'),
              durationInMilliseconds: 400,
            ),
            top: 300,
            start: 220,
            height: 50,
          ),
          Positioned.directional(
            textDirection: TextDirection.ltr,
            child: FadedScaleAnimation(
              Image.asset('assets/Doctors/doc3.png'),
              durationInMilliseconds: 400,
            ),
            top: 350,
            start: 70,
            height: 50,
          ),
          Positioned.directional(
            textDirection: TextDirection.ltr,
            child: FadedScaleAnimation(
              Image.asset('assets/Doctors/doc4.png'),
              durationInMilliseconds: 400,
            ),
            top: 450,
            start: 350,
            height: 50,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 115,
              margin: EdgeInsets.only(bottom: 30),
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: searchList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, PageRoutes.doctorInfo);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        margin: EdgeInsets.only(left: 15),
                        width: 300,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, PageRoutes.doctorInfo);
                              },
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 12,
                                      ),
                                      RichText(
                                          text: TextSpan(
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2,
                                              children: <TextSpan>[
                                            TextSpan(
                                                text: searchList[index].name +
                                                    '\n',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                        color: black2,
                                                        height: 1.7,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                            TextSpan(
                                                text: searchList[index]
                                                    .speciality,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                      fontSize: 11.2,
                                                      color: Color(0xff999999),
                                                    )),
                                            TextSpan(
                                                text: locale.at,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                      fontSize: 11.2,
                                                      color: Color(0xffcccccc),
                                                    )),
                                            TextSpan(
                                                text:
                                                    searchList[index].hospital,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                      fontSize: 11.2,
                                                      color: Color(0xff999999),
                                                    )),
                                          ])),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            locale.exp!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2!
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .disabledColor,
                                                    fontSize: 12),
                                          ),
                                          Text(
                                            searchList[index].experience +
                                                locale.years!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1!
                                                .copyWith(fontSize: 12),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Text(
                                            locale.fee!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2!
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .disabledColor,
                                                    fontSize: 12),
                                          ),
                                          Text(
                                            '\$' + searchList[index].fee,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1!
                                                .copyWith(fontSize: 12),
                                          ),
                                          SizedBox(
                                            width: 35,
                                          ),
                                          RatingBar.builder(
                                              itemSize: 12,
                                              initialRating: 4,
                                              direction: Axis.horizontal,
                                              itemCount: 5,
                                              itemBuilder: (context, _) => Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                              onRatingUpdate: (rating) {
                                              }),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            '(${searchList[index].reviews})',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2!
                                                .copyWith(
                                                    fontSize: 10,
                                                    color: Theme.of(context)
                                                        .disabledColor),
                                          )
                                        ],
                                      ),
                                    ],
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
    );
  }
}
