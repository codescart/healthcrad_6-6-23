// import 'package:flutter/material.dart';
// import 'verification_interator.dart';
// import 'verification_ui.dart';
//
// class VerificationPage extends StatefulWidget {
//   final VoidCallback onVerificationDone;
//
//   VerificationPage(this.onVerificationDone);
//
//   @override
//   _VerificationPageState createState() => _VerificationPageState();
// }
//
// class _VerificationPageState extends State<VerificationPage>
//     implements VerificationInteractor {
//   @override
//   Widget build(BuildContext context) {
//     return VerificationUI(status: '', mobile: '', otp: '',);
//   }
//
//   @override
//   void verificationDone() {
//     widget.onVerificationDone();
//   }
//
//   @override
//   void verifyNumber() {}
// }