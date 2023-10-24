import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:healthcrad_user/Locale/locale.dart';
import 'package:healthcrad_user/Theme/colors.dart';
import 'package:flutter/material.dart';

class Offer {
  Offer(this.offerContent, this.offerCode);
  String? offerContent;
  String offerCode;
}

class OffersPage extends StatefulWidget {
  @override
  _OffersPageState createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    List<Offer> offers = [
      Offer(locale.offer1, 'GET50'),
      Offer(locale.offer2, 'ELECT3'),
      Offer(locale.offer3, 'BUY2G1'),
      Offer(locale.offer1, 'GET50'),
      Offer(locale.offer2, 'ELECT3'),
      Offer(locale.offer3, 'BUY2G1'),
      Offer(locale.offer1, 'GET50'),
      Offer(locale.offer2, 'ELECT3'),
      Offer(locale.offer3, 'BUY2G1'),
    ];
    return Scaffold(
      backgroundColor: Theme.of(context).dividerColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.chevron_left)),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          locale.offers!,
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
        Center(child: Text("No offers available")),
        // ListView.builder(
        //     physics: BouncingScrollPhysics(),
        //     padding: EdgeInsets.all(16),
        //     itemCount: offers.length,
        //     itemBuilder: (context, index) {
        //       return buildOfferCard(context, offers[index].offerContent!,
        //           offers[index].offerCode);
        //     }),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }

  Card buildOfferCard(
      BuildContext context, String offerContent, String offerCode) {
    return
      Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      margin: EdgeInsets.only(bottom: 8),
      color: Theme.of(context).cardColor,
      child:
      ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        title: Text(
          offerContent,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
              fontSize: 13.5, fontWeight: FontWeight.w700, color: black2),
        ),
        trailing: TextButton(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2.0),
            ),
            backgroundColor: Theme.of(context).dividerColor,
          ),
          onPressed: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 5),
            child: Text(
              offerCode,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Theme.of(context).primaryColor, fontSize: 13.5),
            ),
          ),
        ),
      ),
    );
  }
}
