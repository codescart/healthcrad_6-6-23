import 'package:healthcrad_user/BottomNavigation/doctors_page.dart';
import 'package:healthcrad_user/BottomNavigation/appointments_page.dart';
import 'package:healthcrad_user/Locale/locale.dart';
import 'package:flutter/material.dart';

import 'medicine_find_page.dart';
import 'more_options.dart';

class BottomNavigation extends StatefulWidget {
  final int ?pageIndex;
  BottomNavigation({this.pageIndex});
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;
  double start = 0;
  @override
  void initState() {
    setState(() {
      _currentIndex=widget.pageIndex ??0;
    });
    super.initState();
  }
  final List<Widget> _children = [
    MedicinePage(),
    DoctorsHome(),
    AppointmentPage(),
    MoreOptions(),
  ];

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    final List<BottomNavigationBarItem> _bottomBarItems = [
      BottomNavigationBarItem(
        icon: ImageIcon(AssetImage('assets/FooterIcons/ic_medicine.png')),
        activeIcon:
            ImageIcon(AssetImage('assets/FooterIcons/ic_medicineact.png')),
        label: locale.medicine,
      ),
      BottomNavigationBarItem(
        icon: ImageIcon(AssetImage('assets/FooterIcons/ic_doctors.png')),
        activeIcon:
            ImageIcon(AssetImage('assets/FooterIcons/ic_doctorsact.png')),
        label: locale.doctors,
      ),
      BottomNavigationBarItem(
        icon: ImageIcon(AssetImage('assets/FooterIcons/ic_appointments.png')),
        activeIcon:
            ImageIcon(AssetImage('assets/FooterIcons/ic_appointmentsact.png')),
        label: locale.appointments,
      ),
      BottomNavigationBarItem(
        icon: ImageIcon(AssetImage('assets/FooterIcons/ic_more.png')),
        activeIcon: ImageIcon(AssetImage('assets/FooterIcons/ic_moreact.png')),
        label: locale.more,
      ),
    ];
    return StreamBuilder<Object>(
      stream: null,
      builder: (context, snapshot) {
        return
           Scaffold(
            body: Stack(
              children: <Widget>[
                _children[_currentIndex],
                AnimatedPositionedDirectional(
                  bottom: 0,
                  start: start,
                  child: Container(
                    color: Theme.of(context).primaryColor,
                    height: 2,
                    width: MediaQuery.of(context).size.width / 5,
                  ),
                  duration: Duration(milliseconds: 200),
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 20.0,
              type: BottomNavigationBarType.fixed,
              iconSize: 22.0,
              selectedItemColor: Theme.of(context).primaryColor,
              selectedFontSize: 12,
              unselectedFontSize: 10,
              unselectedItemColor: Theme.of(context).disabledColor,
              items: _bottomBarItems,
              onTap: (int index) {
                setState(() {
                  _currentIndex = index;
                  start = MediaQuery.of(context).size.width *
                      index /
                      _bottomBarItems.length;
                });
              },
            ),
        );
      }
    );
  }
}
// WillPopScope(
// onWillPop: ()async {
// final shouldPop = await showDialog<bool>(
// context: context,
// builder: (context) {
// return AlertDialog(
// title: Text('Are you sure?'),
// content: Text('Do you want to exit an App'),
// actionsAlignment: MainAxisAlignment.spaceBetween,
// actions: [
// TextButton(
// onPressed: () {
// Navigator.pop(context, true);
// },
// child: const Text('Yes'),
// ),
// TextButton(
// onPressed: () {
// Navigator.pop(context, false);
// },
// child: const Text('No'),
// ),
// ],
// );
// },
// );
// return shouldPop!;
// },