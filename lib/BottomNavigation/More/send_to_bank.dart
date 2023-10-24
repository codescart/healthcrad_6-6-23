import 'package:healthcrad_user/BottomNavigation/More/add_money.dart';
import 'package:healthcrad_user/Components/custom_button.dart';
import 'package:healthcrad_user/Components/entry_field.dart';
import 'package:healthcrad_user/Locale/locale.dart';
import 'package:healthcrad_user/Theme/colors.dart';
import 'package:flutter/material.dart';

class SendToBank extends StatelessWidget {
  const SendToBank({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        ],
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.chevron_left)),
        centerTitle: true,
        title: Text(
          locale.sendToBank!,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        toolbarTextStyle: Theme.of(context).textTheme.bodyText2,
        titleTextStyle: Theme.of(context).textTheme.headline6,
      ),
      body: Container(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ListView(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 4),
                  child: Text(
                    locale.availableBalance!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 13.5, color: Color(0xff999999)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    '\₹ 520.50',
                    style: theme.textTheme.headline6!.copyWith(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: black2),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 15),
                  child: Divider(
                    thickness: 6,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        locale.bankInfo!.toUpperCase(),
                        style: theme.textTheme.bodyText1!
                            .copyWith(fontSize: 13.5, color: Color(0xff999e93)),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      EntryField(
                        label: locale.accountHolderName,
                        hint: 'Ajay Kumar',
                      ),
                      EntryField(
                        label: locale.bankName,
                        hint: 'HDFC Bank',
                      ),
                      EntryField(
                        label: locale.branchCode,
                        hint: 'CDR13E34',
                      ),
                      EntryField(
                        label: locale.accountNumber,
                        hint: '4312 5467 7685 8643',
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 5),
                        child: Divider(
                          thickness: 6,
                        ),
                      ),
                      EntryField(
                        label: locale.amountToTransfer,
                        hint: '\₹500',
                      ),
                      SizedBox(
                        height: 70,
                      ),
                    ],
                  ),
                )
              ],
            ),
            CustomButton(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddMoney()));
              },
              label: locale.sendToBank,
            )
          ],
        ),
      ),
    );
  }
}
