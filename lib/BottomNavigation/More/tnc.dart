import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter_tawk/flutter_tawk.dart';
import 'package:healthcrad_user/Locale/locale.dart';
import 'package:flutter/material.dart';

class TnCPage extends StatefulWidget {
  @override
  _TnCPageState createState() => _TnCPageState();
}

class _TnCPageState extends State<TnCPage> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.chevron_left)),
        title: Text(
          locale.termsAndCond!,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        toolbarTextStyle: Theme.of(context).textTheme.bodyText2,
        titleTextStyle: Theme.of(context).textTheme.headline6,
      ),
      body: Tawk(
        directChatLink: 'https://app.healthcrad.com/api/index.php/admin/usersapp_terms',
        placeholder:  Center(
          child: CircularProgressIndicator(color: Theme.of(context).primaryColor),
        ),
      )
    );
  }
}
