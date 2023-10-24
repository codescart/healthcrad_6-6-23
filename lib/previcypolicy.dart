import 'package:flutter/material.dart';

import 'package:flutter_tawk/flutter_tawk.dart';

class PrevicyPolicy extends StatefulWidget {
  @override
  _PrevicyPolicyState createState() => _PrevicyPolicyState();
}

class _PrevicyPolicyState extends State<PrevicyPolicy> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.chevron_left, color: Colors.grey,)),
            title: Text(
              "Privacy Policy",
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
            ),
            textTheme: Theme.of(context).textTheme,
            centerTitle: true,
          ),
          body: Tawk(
            directChatLink: 'https://app.healthcrad.com/api/index.php/admin/userapp_policy',
            placeholder:  Center(
              child: CircularProgressIndicator(color: Theme.of(context).primaryColor),
            ),
          )
      ),
    );
  }
}



//
// import 'dart:convert';
//
// import 'package:animation_wrappers/animation_wrappers.dart';
// import 'package:health_crad_doctor/Theme/colors.dart';
// import 'package:health_crad_doctor/Locale/locale.dart';
// import 'package:flutter/material.dart';
// // import 'package:health_crad_doctor/Theme/colors.dart';
// import 'package:http/http.dart'as http;
//
// class Policy extends StatefulWidget {
//   @override
//   _PolicyState createState() => _PolicyState();
// }
//
// class _PolicyState extends State<Policy> {
//   @override
//   Widget build(BuildContext context) {
//     var locale = AppLocalizations.of(context)!;
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//             onPressed: () => Navigator.pop(context),
//             icon: Icon(Icons.chevron_left, color: Colors.grey,)),
//         title: Text(
//           locale.policies!,
//           style: Theme.of(context)
//               .textTheme
//               .bodyText2!
//               .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
//         ),
//         textTheme: Theme.of(context).textTheme,
//         centerTitle: true,
//       ),
//       body: FadedSlideAnimation(
//         ListView(
//           children: [
//             Padding(
//               padding:
//               const EdgeInsets.symmetric(horizontal: 25.0, vertical: 18),
//               child:data==null?Container(
//                   height: MediaQuery.of(context).size.height/1.2,
//                   width: MediaQuery.of(context).size.width,
//                   alignment: Alignment.center,
//                   child: CircularProgressIndicator()): Container(
//                 width: MediaQuery.of(context).size.width,
//                    child: Text(
//                   data["privacy_policy"].toString(),
//                   style: Theme.of(context)
//                       .textTheme
//                       .subtitle1!
//                       .copyWith(fontWeight: FontWeight.w400, fontSize: 17),
//                   textAlign: TextAlign.justify,
//                 ),
//               ),
//             )
//           ],
//         ),
//         beginOffset: Offset(0, 0.3),
//         endOffset: Offset(0, 0),
//         slideCurve: Curves.linearToEaseOut,
//       ),
//     );
//   }
//   @override
//   void initState() {
//     leader();
//     super.initState();
//   }
//   var data;
//   var datal;
//   Future leader() async{
//     final response = await http.post(
//       Uri.parse(BASE_URL+'privacy_policy'),
//     );
//     var datas = jsonDecode(response.body);
//     if (datas['error'] == "200") {
//       setState(() {
//         datal=datas["country"];
//         data=datal[0];
//       });
//     }
//   }
// }
//