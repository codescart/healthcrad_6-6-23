import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:healthcrad_user/Locale/locale.dart';
import 'package:healthcrad_user/Theme/colors.dart';
import 'package:flutter/material.dart';

import 'about_tab.dart';
import 'departments_tab.dart';

class HospitalInfo extends StatefulWidget {
  @override
  _HospitalInfoState createState() => _HospitalInfoState();
}

class _HospitalInfoState extends State<HospitalInfo> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          physics: BouncingScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                leading: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.chevron_left)),
                expandedHeight: 200.0,
                floating: false,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 0,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: FadedScaleAnimation(
                    Image.asset(
                      'assets/img_hospital.png',
                      fit: BoxFit.cover,
                    ),
                    durationInMilliseconds: 400,
                  ),
                ),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    indicatorColor: Colors.transparent,
                    unselectedLabelColor: Theme.of(context).disabledColor,
                    labelColor: Theme.of(context).primaryColor,
                    labelStyle: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 15),
                    unselectedLabelStyle: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 15),
                    isScrollable: true,
                    labelPadding: EdgeInsetsDirectional.only(end: 20, top: 10),
                    tabs: [
                      Tab(text: locale!.about),
                      Tab(text: locale.departments),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(children: [
            FadedSlideAnimation(
              About(),
              beginOffset: Offset(0, 0.3),
              endOffset: Offset(0, 0),
              slideCurve: Curves.linearToEaseOut,
            ),
            FadedSlideAnimation(
              Departments(),
              beginOffset: Offset(0, 0.3),
              endOffset: Offset(0, 0),
              slideCurve: Curves.linearToEaseOut,
            ),
          ]),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => 148;
  @override
  double get maxExtent => 148;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 20, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Apple Hospital',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 21.7,
                height: 2,
                color: black2,
                fontWeight: FontWeight.bold),
          ),
          Text(
            'General Hospital',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontSize: 13.5, color: Color(0xffb3b3b3), height: 2),
          ),
          _tabBar,
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
