import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:healthcrad_user/Components/custom_button.dart';
import 'package:healthcrad_user/Components/entry_field.dart';
import 'package:healthcrad_user/Locale/locale.dart';
import 'package:healthcrad_user/Theme/colors.dart';
import 'package:flutter/material.dart';

class ReviewOrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Theme.of(context).dividerColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.chevron_left)),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          locale.reviewOrder!,
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
            itemCount: 4,
            itemBuilder: (context, index) => Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  margin: EdgeInsets.only(top: 8),
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.only(bottom: 16),
                        title: Text(
                          'Well Life Store',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Color(0xffb3b3b3),
                                  fontSize: 13.5,
                                  height: 1.7),
                        ),
                        subtitle: Text(
                          'Salospir 100mg\nTablet',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: black2),
                        ),
                        trailing: FadedScaleAnimation(
                          Image.asset('assets/Medicines/11.png'),
                          durationInMilliseconds: 400,
                        ),
                      ),
                      Text(
                        locale.overallExp!,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(color: Color(0xffb3b3b3)),
                      ),
                      Container(
                        height: 56,
                        child: ListView.builder(
                          itemCount: 5,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, iconIndex) => Icon(
                            Icons.star,
                            size: 40,
                            color: inProcessColor,
                          ),
                        ),
                      ),
                      EntryField(
                        label: locale.addFeedback,
                        hint: locale.writeYourFeedback,
                        maxLines: 4,
                      ),
                      SizedBox(height: 16),
                      CustomButton(label: locale.submit)
                    ],
                  ),
                )),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
