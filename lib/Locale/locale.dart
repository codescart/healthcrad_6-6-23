import 'package:healthcrad_user/Locale/Languages/italian.dart';
import 'package:healthcrad_user/Locale/Languages/swahili.dart';
import 'package:healthcrad_user/Locale/Languages/turkish.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'Languages/arabic.dart';
import 'Languages/portuguese.dart';
import 'Languages/spanish.dart';
import 'Languages/indonesian.dart';
import 'Languages/english.dart';
import 'Languages/french.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': english(),
    'ar': arabic(),
    'pt': portuguese(),
    'fr': french(),
    'id': indonesian(),
    'es': spanish(),
    'tr': turkish(),
    'it': italian(),
    'sw': swahili(),
  };

  String? get enterMobileNumber {
    return _localizedValues[locale.languageCode]!['enterMobileNumber'];
  }

  String? get orQuickContinueWith {
    return _localizedValues[locale.languageCode]!['orQuickContinueWith'];
  }

  String? get facebook {
    return _localizedValues[locale.languageCode]!['facebook'];
  }

  String? get gmail {
    return _localizedValues[locale.languageCode]!['gmail'];
  }

  String? get yourPhoneNumberNotRegistered {
    return _localizedValues[locale.languageCode]![
        'yourPhoneNumberNotRegistered'];
  }

  String? get mobileNumber {
    return _localizedValues[locale.languageCode]!['mobileNumber'];
  }

  String? get sendToBank {
    return _localizedValues[locale.languageCode]!['sendToBank'];
  }

  String? get changeLanguage {
    return _localizedValues[locale.languageCode]!['changeLanguage'];
  }

  String? get fullName {
    return _localizedValues[locale.languageCode]!['fullName'];
  }

  String? get emailAddress {
    return _localizedValues[locale.languageCode]!['emailAddress'];
  }

  String? get continuee {
    return _localizedValues[locale.languageCode]!['continuee'];
  }

  String? get backToSignIn {
    return _localizedValues[locale.languageCode]!['backToSignIn'];
  }

  String? get wellSendAnOTP {
    return _localizedValues[locale.languageCode]!['wellSendAnOTP'];
  }

  String? get phoneVerification {
    return _localizedValues[locale.languageCode]!['phoneVerification'];
  }

  String? get weveSentAnOTP {
    return _localizedValues[locale.languageCode]!['weveSentAnOTP'];
  }

  String? get enter4DigitOTP {
    return _localizedValues[locale.languageCode]!['enter4DigitOTP'];
  }

  String? get submit {
    return _localizedValues[locale.languageCode]!['submit'];
  }

  String? get bankInfo {
    return _localizedValues[locale.languageCode]!['bankInfo'];
  }

  String? get accountHolderName {
    return _localizedValues[locale.languageCode]!['accountHolderName'];
  }

  String? get bankName {
    return _localizedValues[locale.languageCode]!['bankName'];
  }

  String? get branchCode {
    return _localizedValues[locale.languageCode]!['branchCode'];
  }

  String? get accountNumber {
    return _localizedValues[locale.languageCode]!['accountNumber'];
  }

  String? get amountToTransfer {
    return _localizedValues[locale.languageCode]!['amountToTransfer'];
  }

  String? get secLeft {
    return _localizedValues[locale.languageCode]!['secLeft'];
  }

  String? get resend {
    return _localizedValues[locale.languageCode]!['resend'];
  }

  String? get hello {
    return _localizedValues[locale.languageCode]!['hello'];
  }

  String? get findYourMedicines {
    return _localizedValues[locale.languageCode]!['findYourMedicines'];
  }

  String? get searchMedicines {
    return _localizedValues[locale.languageCode]!['searchMedicines'];
  }

  String? get shopByCategory {
    return _localizedValues[locale.languageCode]!['shopByCategory'];
  }

  String? get viewAll {
    return _localizedValues[locale.languageCode]!['viewAll'];
  }

  String? get offers {
    return _localizedValues[locale.languageCode]!['offers'];
  }

  String? get sellerNearYou {
    return _localizedValues[locale.languageCode]!['sellerNearYou'];
  }

  String? get medicine {
    return _localizedValues[locale.languageCode]!['medicine'];
  }

  String? get doctors {
    return _localizedValues[locale.languageCode]!['doctors'];
  }

  String? get hospitals {
    return _localizedValues[locale.languageCode]!['hospitals'];
  }

  String? get appointments {
    return _localizedValues[locale.languageCode]!['appointments'];
  }

  String? get more {
    return _localizedValues[locale.languageCode]!['more'];
  }

  String? get registerNow {
    return _localizedValues[locale.languageCode]!['registerNow'];
  }

  String? get office {
    return _localizedValues[locale.languageCode]!['office'];
  }

  String? get other {
    return _localizedValues[locale.languageCode]!['other'];
  }

  String? get setLocation {
    return _localizedValues[locale.languageCode]!['setLocation'];
  }

  String? get heathCare {
    return _localizedValues[locale.languageCode]!['healthCare'];
  }

  String? get coldFever {
    return _localizedValues[locale.languageCode]!['coldFever'];
  }

  String? get headache {
    return _localizedValues[locale.languageCode]!['headache'];
  }

  String? get reviews {
    return _localizedValues[locale.languageCode]!['reviews'];
  }

  String? get averageReviews {
    return _localizedValues[locale.languageCode]!['averageReviews'];
  }

  String? get avgReview {
    return _localizedValues[locale.languageCode]!['avgReview'];
  }

  String? get wellLifeStore {
    return _localizedValues[locale.languageCode]!['wellLifeStore'];
  }

  String? get confirmOrder {
    return _localizedValues[locale.languageCode]!['confirmOrder'];
  }

  String? get deliveryAt {
    return _localizedValues[locale.languageCode]!['deliveryAt'];
  }

  String? get home {
    return _localizedValues[locale.languageCode]!['home'];
  }

  String? get itemsInCart {
    return _localizedValues[locale.languageCode]!['itemsInCart'];
  }

  String? get pack {
    return _localizedValues[locale.languageCode]!['pack'];
  }

  String? get packs {
    return _localizedValues[locale.languageCode]!['packs'];
  }

  String? get prescriptionUploaded {
    return _localizedValues[locale.languageCode]!['prescriptionUploaded'];
  }

  String? get subTotal {
    return _localizedValues[locale.languageCode]!['subTotal'];
  }

  String? get promoCodeApplied {
    return _localizedValues[locale.languageCode]!['promoCodeApplied'];
  }

  String? get serviceCharge {
    return _localizedValues[locale.languageCode]!['serviceCharge'];
  }

  String? get amountToPay {
    return _localizedValues[locale.languageCode]!['amountToPay'];
  }

  String? get continueToPay {
    return _localizedValues[locale.languageCode]!['continueToPay'];
  }

  String? get readAll {
    return _localizedValues[locale.languageCode]!['readAll'];
  }

  String? get description {
    return _localizedValues[locale.languageCode]!['description'];
  }

  String? get soldBy {
    return _localizedValues[locale.languageCode]!['soldBy'];
  }

  String? get viewProfile {
    return _localizedValues[locale.languageCode]!['viewProfile'];
  }

  String? get packOf {
    return _localizedValues[locale.languageCode]!['packOf'];
  }

  String? get addToCart {
    return _localizedValues[locale.languageCode]!['addToCart'];
  }

  String? get myCart {
    return _localizedValues[locale.languageCode]!['myCart'];
  }

  String? get addPromoCode {
    return _localizedValues[locale.languageCode]!['addPromoCode'];
  }

  String? get viewOffers {
    return _localizedValues[locale.languageCode]!['viewOffers'];
  }

  String? get amountPayable {
    return _localizedValues[locale.languageCode]!['amountPayable'];
  }

  String? get checkout {
    return _localizedValues[locale.languageCode]!['checkout'];
  }

  String? get prescriptionRequire {
    return _localizedValues[locale.languageCode]!['prescriptionRequire'];
  }

  String? get yourOrderContains2items {
    return _localizedValues[locale.languageCode]!['yourOrderContains2items'];
  }

  String? get uploadPrescription {
    return _localizedValues[locale.languageCode]!['uploadPrescription'];
  }

  String? get cancel {
    return _localizedValues[locale.languageCode]!['cancel'];
  }

  String? get orderPlaced {
    return _localizedValues[locale.languageCode]!['orderPlaced'];
  }

  String? get yourOrderPlaced {
    return _localizedValues[locale.languageCode]!['yourOrderPlaced'];
  }

  String? get faq1 {
    return _localizedValues[locale.languageCode]!['faq1'];
  }

  String? get faq2 {
    return _localizedValues[locale.languageCode]!['faq2'];
  }

  String? get faq3 {
    return _localizedValues[locale.languageCode]!['faq3'];
  }

  String? get howMayWeHelpYou {
    return _localizedValues[locale.languageCode]!['howMayWeHelpYou'];
  }

  String? get letUsKnowUrQueriesFeedbacks {
    return _localizedValues[locale.languageCode]![
        'letUsKnowUrQueriesFeedbacks'];
  }

  String? get writeYourMsg {
    return _localizedValues[locale.languageCode]!['writeYourMsg'];
  }

  String? get faq4 {
    return _localizedValues[locale.languageCode]!['faq4'];
  }

  String? get faq5 {
    return _localizedValues[locale.languageCode]!['faq5'];
  }

  String? get faq6 {
    return _localizedValues[locale.languageCode]!['faq6'];
  }

  String? get faq7 {
    return _localizedValues[locale.languageCode]!['faq7'];
  }

  String? get faq8 {
    return _localizedValues[locale.languageCode]!['faq8'];
  }

  String? get faq9 {
    return _localizedValues[locale.languageCode]!['faq9'];
  }

  String? get faq {
    return _localizedValues[locale.languageCode]!['faq'];
  }

  String? get yourOrderHasBeenPlaced {
    return _localizedValues[locale.languageCode]!['yourOrderHasBeenPlaced'];
  }

  String? get myOrders {
    return _localizedValues[locale.languageCode]!['myOrders'];
  }
  String? get ambulance {
    return _localizedValues[locale.languageCode]!['ambulance'];
  }

  String? get continueShopping {
    return _localizedValues[locale.languageCode]!['continueShopping'];
  }

  String? get wallet {
    return _localizedValues[locale.languageCode]!['wallet'];
  }

  String? get cashOnDelivery {
    return _localizedValues[locale.languageCode]!['cashOnDelivery'];
  }

  String? get payPal {
    return _localizedValues[locale.languageCode]!['payPal'];
  }

  String? get payUMoney {
    return _localizedValues[locale.languageCode]!['payUMoney'];
  }

  String? get stripe {
    return _localizedValues[locale.languageCode]!['stripe'];
  }

  String? get selectPaymentMethod {
    return _localizedValues[locale.languageCode]!['selectPaymentMethod'];
  }

  String? get paymentModes {
    return _localizedValues[locale.languageCode]!['paymentModes'];
  }

  String? get msg1 {
    return _localizedValues[locale.languageCode]!['msg1'];
  }

  String? get msg2 {
    return _localizedValues[locale.languageCode]!['msg2'];
  }

  String? get findDoctors {
    return _localizedValues[locale.languageCode]!['findDoctors'];
  }

  String? get searchDoctors {
    return _localizedValues[locale.languageCode]!['searchDoctors'];
  }

  String? get findBySpecialities {
    return _localizedValues[locale.languageCode]!['findBySpecialities'];
  }

  String? get sponsorAd {
    return _localizedValues[locale.languageCode]!['sponsorAd'];
  }

  String? get listOfSpec {
    return _localizedValues[locale.languageCode]!['listOfSpec'];
  }

  String? get searchDoc {
    return _localizedValues[locale.languageCode]!['searchDoc'];
  }

  String? get recentSearch {
    return _localizedValues[locale.languageCode]!['recentSearch'];
  }

  String? get searchExpertInField {
    return _localizedValues[locale.languageCode]!['searchExpertInField'];
  }

  String? get mapView {
    return _localizedValues[locale.languageCode]!['mapView'];
  }

  String? get sortFilter {
    return _localizedValues[locale.languageCode]!['sortFilter'];
  }

  String? get reset {
    return _localizedValues[locale.languageCode]!['reset'];
  }

  String? get sortBy {
    return _localizedValues[locale.languageCode]!['sortBy'];
  }

  String? get consultancyFees {
    return _localizedValues[locale.languageCode]!['consultancyFees'];
  }

  String? get rating {
    return _localizedValues[locale.languageCode]!['rating'];
  }

  String? get distance {
    return _localizedValues[locale.languageCode]!['distance'];
  }

  String? get gender {
    return _localizedValues[locale.languageCode]!['gender'];
  }

  String? get male {
    return _localizedValues[locale.languageCode]!['male'];
  }

  String? get female {
    return _localizedValues[locale.languageCode]!['female'];
  }

  String? get applyNow {
    return _localizedValues[locale.languageCode]!['applyNow'];
  }

  String? get experience {
    return _localizedValues[locale.languageCode]!['experience'];
  }

  String? get consulFees {
    return _localizedValues[locale.languageCode]!['consulFees'];
  }

  String? get feedback {
    return _localizedValues[locale.languageCode]!['feedback'];
  }

  String? get availability {
    return _localizedValues[locale.languageCode]!['availability'];
  }

  String? get servicesAt {
    return _localizedValues[locale.languageCode]!['servicesAt'];
  }

  String? get specifications {
    return _localizedValues[locale.languageCode]!['specifications'];
  }

  String? get bookAppointmentNow {
    return _localizedValues[locale.languageCode]!['bookAppointmentNow'];
  }

  String? get selectDateAndTime {
    return _localizedValues[locale.languageCode]!['selectDateAndTime'];
  }

  String? get selectDate {
    return _localizedValues[locale.languageCode]!['selectDate'];
  }

  String? get selectTime {
    return _localizedValues[locale.languageCode]!['selectTime'];
  }

  String? get appointmentFor {
    return _localizedValues[locale.languageCode]!['appointmentFor'];
  }

  String? get confirmAppointment {
    return _localizedValues[locale.languageCode]!['confirmAppointment'];
  }

  String? get appointmentBooked {
    return _localizedValues[locale.languageCode]!['appointmentBooked'];
  }

  String? get yourAppointmentBooked {
    return _localizedValues[locale.languageCode]!['yourAppointmentBooked'];
  }

  String? get checkMyAppointment {
    return _localizedValues[locale.languageCode]!['checkMyAppointment'];
  }

  String? get myAppointments {
    return _localizedValues[locale.languageCode]!['myAppointments'];
  }

  String? get findHospital {
    return _localizedValues[locale.languageCode]!['findHospital'];
  }

  String? get searchHospital {
    return _localizedValues[locale.languageCode]!['searchHospital'];
  }

  String? get searchByCategory {
    return _localizedValues[locale.languageCode]!['searchByCategory'];
  }

  String? get hospitalsNearYou {
    return _localizedValues[locale.languageCode]!['hospitalsNearYou'];
  }

  String? get callNow {
    return _localizedValues[locale.languageCode]!['callNow'];
  }

  String? get about {
    return _localizedValues[locale.languageCode]!['about'];
  }

  String? get departments {
    return _localizedValues[locale.languageCode]!['departments'];
  }

  String? get facilitites {
    return _localizedValues[locale.languageCode]!['facilitites'];
  }

  String? get address {
    return _localizedValues[locale.languageCode]!['address'];
  }

  String? get upcoming {
    return _localizedValues[locale.languageCode]!['upcoming'];
  }

  String? get past {
    return _localizedValues[locale.languageCode]!['past'];
  }

  String? get appointmentDetails {
    return _localizedValues[locale.languageCode]!['appointmentDetails'];
  }

  String? get appointmentOn {
    return _localizedValues[locale.languageCode]!['appointmentOn'];
  }

  String? get location {
    return _localizedValues[locale.languageCode]!['location'];
  }

  String? get call {
    return _localizedValues[locale.languageCode]!['call'];
  }

  String? get chat {
    return _localizedValues[locale.languageCode]!['chat'];
  }

  String? get account {
    return _localizedValues[locale.languageCode]!['account'];
  }

  String? get recent {
    return _localizedValues[locale.languageCode]!['recent'];
  }

  String? get availableBalance {
    return _localizedValues[locale.languageCode]!['availableBalance'];
  }

  String? get addMoney {
    return _localizedValues[locale.languageCode]!['addMoney'];
  }

  String? get setReminder {
    return _localizedValues[locale.languageCode]!['setReminder'];
  }

  String? get addMoneyVia {
    return _localizedValues[locale.languageCode]!['addMoneyVia'];
  }

  String? get enterMoneyToAdd {
    return _localizedValues[locale.languageCode]!['enterMoneyToAdd'];
  }

  String? get recentOrders {
    return _localizedValues[locale.languageCode]!['recentOrders'];
  }

  String? get inProcess {
    return _localizedValues[locale.languageCode]!['inProcess'];
  }

  String? get reviewNow {
    return _localizedValues[locale.languageCode]!['reviewNow'];
  }

  String? get orderConfirmed {
    return _localizedValues[locale.languageCode]!['orderConfirmed'];
  }

  String? get orderPicked {
    return _localizedValues[locale.languageCode]!['orderPicked'];
  }

  String? get track {
    return _localizedValues[locale.languageCode]!['track'];
  }

  String? get orderDelivered {
    return _localizedValues[locale.languageCode]!['orderDelivered'];
  }

  String? get yetToDeliver {
    return _localizedValues[locale.languageCode]!['yetToDeliver'];
  }

  String? get orderedItems {
    return _localizedValues[locale.languageCode]!['orderedItems'];
  }

  String? get presciptionUploaded {
    return _localizedValues[locale.languageCode]!['presciptionUploaded'];
  }

  String? get subbTotal {
    return _localizedValues[locale.languageCode]!['subbTotal'];
  }

  String? get amountVaiCOD {
    return _localizedValues[locale.languageCode]!['amountVaiCOD'];
  }

  String? get orderTrack {
    return _localizedValues[locale.languageCode]!['orderTrack'];
  }

  String? get deliveryPartner {
    return _localizedValues[locale.languageCode]!['deliveryPartner'];
  }

  String? get pillReminder {
    return _localizedValues[locale.languageCode]!['pillReminder'];
  }

  String? get createPillReminder {
    return _localizedValues[locale.languageCode]!['createPillReminder'];
  }

  String? get pillName {
    return _localizedValues[locale.languageCode]!['pillName'];
  }

  String? get enterPillName {
    return _localizedValues[locale.languageCode]!['enterPillName'];
  }

  String? get selectDays {
    return _localizedValues[locale.languageCode]!['selectDays'];
  }

  String? get days {
    return _localizedValues[locale.languageCode]!['days'];
  }

  String? get savedAddresses {
    return _localizedValues[locale.languageCode]!['savedAddresses'];
  }

  String? get done {
    return _localizedValues[locale.languageCode]!['done'];
  }

  String? get addNewAddress {
    return _localizedValues[locale.languageCode]!['addNewAddress'];
  }

  String? get time {
    return _localizedValues[locale.languageCode]!['time'];
  }

  String? get selectAddressType {
    return _localizedValues[locale.languageCode]!['selectAddressType'];
  }

  String? get enterAddressDetails {
    return _localizedValues[locale.languageCode]!['enterAddressDetails'];
  }

  String? get saved {
    return _localizedValues[locale.languageCode]!['saved'];
  }

  String? get offer1 {
    return _localizedValues[locale.languageCode]!['offer1'];
  }

  String? get offer2 {
    return _localizedValues[locale.languageCode]!['offer2'];
  }

  String? get offer3 {
    return _localizedValues[locale.languageCode]!['offer3'];
  }

  String? get support {
    return _localizedValues[locale.languageCode]!['support'];
  }

  String? get faqs {
    return _localizedValues[locale.languageCode]!['faqs'];
  }

  String? get termsAndCond {
    return _localizedValues[locale.languageCode]!['termsAndCond'];
  }

  String? get for1 {
    return _localizedValues[locale.languageCode]!['for1'];
  }

  String? get resultsFound {
    return _localizedValues[locale.languageCode]!['resultsFound'];
  }

  String? get at {
    return _localizedValues[locale.languageCode]!['at'];
  }

  String? get exp {
    return _localizedValues[locale.languageCode]!['exp'];
  }

  String? get years {
    return _localizedValues[locale.languageCode]!['years'];
  }

  String? get fee {
    return _localizedValues[locale.languageCode]!['fee'];
  }

  String? get searchDoctor {
    return _localizedValues[locale.languageCode]!['searchDoctor'];
  }

  String? get cardio {
    return _localizedValues[locale.languageCode]!['cardio'];
  }

  String? get ophtha {
    return _localizedValues[locale.languageCode]!['ophtha'];
  }

  String? get derma {
    return _localizedValues[locale.languageCode]!['derma'];
  }

  String? get cardiacSurgeon {
    return _localizedValues[locale.languageCode]!['cardiacSurgeon'];
  }

  String? get to {
    return _localizedValues[locale.languageCode]!['to'];
  }

  String? get visitedFor {
    return _localizedValues[locale.languageCode]!['visitedFor'];
  }

  String? get heartPain {
    return _localizedValues[locale.languageCode]!['heartPain'];
  }

  String? get bodyAche {
    return _localizedValues[locale.languageCode]!['bodyAche'];
  }

  String? get quickPayment {
    return _localizedValues[locale.languageCode]!['quickPayment'];
  }

  String? get orderStatus {
    return _localizedValues[locale.languageCode]!['orderStatus'];
  }
  String? get services {
    return _localizedValues[locale.languageCode]!['services'];
  }

  String? get takePillOnTime {
    return _localizedValues[locale.languageCode]!['takePillOnTime'];
  }

  String? get saveAddress {
    return _localizedValues[locale.languageCode]!['saveAddress'];
  }

  String? get medsAndDoctors {
    return _localizedValues[locale.languageCode]!['medsAndDoctors'];
  }

  String? get contactUs {
    return _localizedValues[locale.languageCode]!['contactUs'];
  }

  String? get letUsHelpYou {
    return _localizedValues[locale.languageCode]!['letUsHelpYou'];
  }

  String? get companyPolicy {
    return _localizedValues[locale.languageCode]!['companyPolicy'];
  }

  String? get tandc {
    return _localizedValues[locale.languageCode]!['tandc'];
  }

  String? get quickAnswer {
    return _localizedValues[locale.languageCode]!['quickAnswer'];
  }

  String? get myAddress {
    return _localizedValues[locale.languageCode]!['myAddress'];
  }

  String? get items {
    return _localizedValues[locale.languageCode]!['items'];
  }

  String? get orderNum {
    return _localizedValues[locale.languageCode]!['orderNum'];
  }

  String? get reviewOrder {
    return _localizedValues[locale.languageCode]!['reviewOrder'];
  }

  String? get overallExp {
    return _localizedValues[locale.languageCode]!['overallExp'];
  }

  String? get addFeedback {
    return _localizedValues[locale.languageCode]!['addFeedback'];
  }

  String? get writeYourFeedback {
    return _localizedValues[locale.languageCode]!['writeYourFeedback'];
  }

  String? get logout {
    return _localizedValues[locale.languageCode]!['logout'];
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => [
        'en',
        'ar',
        'id',
        'pt',
        'fr',
        'es',
        'tr',
        'it',
        'sw'
      ].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of AppLocalizations.
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
