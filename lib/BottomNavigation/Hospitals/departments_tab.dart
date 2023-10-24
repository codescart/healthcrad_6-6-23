import 'package:healthcrad_user/Components/custom_button.dart';
import 'package:healthcrad_user/Locale/locale.dart';
import 'package:healthcrad_user/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Departments extends StatefulWidget {
  @override
  _DepartmentsState createState() => _DepartmentsState();
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

class _DepartmentsState extends State<Departments> {
  List<double> _isActive = [
    0,
    250,
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
    List<String> _departmentList = [
      'Oncology Department',
      'Cardiology Department',
      'Oncology Department',
      'Oncology Department',
      'Oncology Department',
      'Oncology Department'
    ];
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
      body: Stack(
        children: [
          ListView.builder(
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _departmentList.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Divider(
                      thickness: 4,
                      color: Theme.of(context).backgroundColor,
                    ),
                    ListTile(
                      onTap: () {
                        setState(() {
                          _isActive[index] = _isActive[index] == 0 ? 250 : 0;
                        });
                      },
                      title: Text(
                        _departmentList[index],
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 13.5, color: Color(0xff3d3d3d)),
                      ),
                      trailing: Icon(
                        Icons.keyboard_arrow_down_sharp,
                        color: Theme.of(context).primaryColor,
                      ),
                      dense: true,
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      // padding: EdgeInsets.only(top: 4),
                      height: _isActive[index],
                      child: Container(
                        child: ListView(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: searchList.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8, bottom: 18.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          //Navigator.pushNamed(context, PageRoutes.doctorInfo);
                                        },
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              searchList[index].image,
                                              height: 80,
                                              width: 80,
                                            ),
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
                                                          text:
                                                              searchList[index]
                                                                      .name +
                                                                  '\n',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyText1!
                                                              .copyWith(
                                                                  fontSize: 15,
                                                                  color: black2,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                      TextSpan(
                                                        text: searchList[index]
                                                            .speciality,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText2!
                                                            .copyWith(
                                                                color: Color(
                                                                    0xff999999),
                                                                fontSize: 11.7),
                                                      ),
                                                      TextSpan(
                                                        text: locale.at,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .caption!
                                                            .copyWith(
                                                                color: Color(
                                                                    0xffcccccc),
                                                                fontSize: 11.7),
                                                      ),
                                                      TextSpan(
                                                        text: searchList[index]
                                                            .hospital,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText2!
                                                            .copyWith(
                                                                color: Color(
                                                                    0xff999999),
                                                                fontSize: 11.7,
                                                                height: 1.5),
                                                      ),
                                                    ])),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      locale.exp!,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                              color: Color(
                                                                  0xff979797),
                                                              fontSize: 10),
                                                    ),
                                                    Text(
                                                      searchList[index]
                                                              .experience +
                                                          locale.years!,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                              fontSize: 10),
                                                    ),
                                                    Text(
                                                      locale.fee!,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                              color: Color(
                                                                  0xff979797),
                                                              fontSize: 10),
                                                    ),
                                                    Text(
                                                      '\$' +
                                                          searchList[index].fee,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                              fontSize: 10),
                                                    ),
                                                    RatingBar.builder(
                                                        itemSize: 12,
                                                        initialRating: 4,
                                                        direction:
                                                            Axis.horizontal,
                                                        itemCount: 5,
                                                        itemBuilder: (context,
                                                                _) =>
                                                            Icon(
                                                              Icons.star,
                                                              color:
                                                                  Colors.amber,
                                                            ),
                                                        onRatingUpdate:
                                                            (rating) {
                                                          print(rating);
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
                                                              color: Theme.of(
                                                                      context)
                                                                  .disabledColor),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }),
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
