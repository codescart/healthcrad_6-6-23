import 'package:healthcrad_user/Auth/login_navigator.dart';
import 'package:healthcrad_user/BottomNavigation/Doctors/appointment_booked.dart';
import 'package:healthcrad_user/BottomNavigation/Doctors/book_appointment.dart';
import 'package:healthcrad_user/BottomNavigation/Doctors/doctor_info.dart';
import 'package:healthcrad_user/BottomNavigation/Doctors/doctor_map_view.dart';
import 'package:healthcrad_user/BottomNavigation/Doctors/doctor_review_page.dart';
import 'package:healthcrad_user/BottomNavigation/Doctors/list_of_doctors.dart';
import 'package:healthcrad_user/BottomNavigation/Doctors/search_doctors.dart';
import 'package:healthcrad_user/BottomNavigation/Doctors/search_history.dart';
import 'package:healthcrad_user/BottomNavigation/Doctors/sort_filter.dart';
import 'package:healthcrad_user/BottomNavigation/Hospitals/hospital_info.dart';
import 'package:healthcrad_user/BottomNavigation/Hospitals/hospital_map_view.dart';
import 'package:healthcrad_user/BottomNavigation/Medicine/medicine_info.dart';
import 'package:healthcrad_user/BottomNavigation/Medicine/medicines.dart';
import 'package:healthcrad_user/BottomNavigation/Medicine/my_cart.dart';
import 'package:healthcrad_user/BottomNavigation/Medicine/offers.dart';
import 'package:healthcrad_user/BottomNavigation/Medicine/order_placed_page.dart';
import 'package:healthcrad_user/BottomNavigation/Medicine/reviews_page.dart';
import 'package:healthcrad_user/BottomNavigation/Medicine/select_payment_method.dart';
import 'package:healthcrad_user/BottomNavigation/Medicine/seller_profile.dart';
import 'package:healthcrad_user/BottomNavigation/Medicine/shop_by_category_page.dart';
import 'package:healthcrad_user/BottomNavigation/More/add_money.dart';
import 'package:healthcrad_user/BottomNavigation/More/change_language_page.dart';
import 'package:healthcrad_user/BottomNavigation/More/faq_page.dart';
import 'package:healthcrad_user/BottomNavigation/More/saved_addresses_page.dart';
import 'package:healthcrad_user/BottomNavigation/More/saved_page.dart';
import 'package:healthcrad_user/BottomNavigation/More/send_to_bank.dart';
import 'package:healthcrad_user/BottomNavigation/More/support_page.dart';
import 'package:healthcrad_user/BottomNavigation/More/tnc.dart';
import 'package:healthcrad_user/BottomNavigation/More/wallet_page.dart';
import 'package:healthcrad_user/BottomNavigation/appointments_page.dart';
import 'package:healthcrad_user/BottomNavigation/bottom_navigation.dart';
import 'package:healthcrad_user/BottomNavigation/hospitals_page.dart';
import 'package:healthcrad_user/BottomNavigation/medicine_find_page.dart';
import 'package:healthcrad_user/Checkout/confirm_order.dart';
import 'package:healthcrad_user/Location/location_page.dart';
import 'package:healthcrad_user/Pages/appointment_detail.dart';
import 'package:healthcrad_user/Pages/chat_with_doctor.dart';
import 'package:healthcrad_user/Pages/give_feedback.dart';
import 'package:healthcrad_user/BottomNavigation/More/PillReminder/create_pill_reminder_page.dart';
import 'package:healthcrad_user/BottomNavigation/More/PillReminder/pill_reminder_page.dart';
import 'package:healthcrad_user/BottomNavigation/More/Order/recent_orders_page.dart';
import 'package:healthcrad_user/BottomNavigation/More/Order/review_order_page.dart';
import 'package:healthcrad_user/BottomNavigation/More/Order/order_info.dart';
import 'package:healthcrad_user/BottomNavigation/More/Order/order_tracking_page.dart';
import 'package:healthcrad_user/BottomNavigation/More/Order/chat_screen.dart';
import 'package:flutter/material.dart';

class PageRoutes {
  static const String findMedicinesPage = 'find_medicines_page';
  static const String bottomNavigation = 'bottom_navigation';
  static const String shopByCategory = 'shop_by_category';
  static const String medicines = 'medicines';
  static const String reviewsPage = 'reviews_page';
  static const String sellerProfile = 'seller_profile';
  static const String medicineInfo = 'medicine_info';
  static const String myCartPage = 'my_cart_page';
  static const String confirmOrderPage = 'confirm_order_page';
  static const String choosePaymentMethod = 'choose_payment_method';
  static const String orderPlacedPage = 'order_placed_page';
  static const String searchDoctors = 'search_doctors_page';
  static const String searchHistoryPage = 'search_history_page';
  static const String listOfDoctorsPage = 'list_of_doctors';
  static const String sortFilterPage = 'sort_filter';
  static const String doctorInfo = 'doctor_info';
  static const String doctorReviewPage = 'doctor_review_page';
  static const String bookAppointment = 'book_appointment';
  static const String appointmentBooked = 'appointment_booked';
  static const String giveFeedback = 'give_feedback';
  static const String hospitalsHome = 'hospitals_page';
  static const String hospitalMapView = 'hospital_map_view';
  static const String appointmentDetail = 'appointment_detail';
  static const String doctorChat = 'chat_with_doctor';
  static const String hospitalInfo = 'hospital_info';
  static const String walletPage = 'wallet_page';
  static const String addMoney = 'add_money';
  static const String createPillReminder = 'create_pill_reminder';
  static const String recentOrder = 'recent_orders_page';
  static const String orderTracking = 'order_tracking_page';
  static const String pillReminder = 'pill_reminder_page';
  static const String createReminder = 'create_pill_reminder_page';
  static const String faqPage = 'faq_page';
  static const String tncPage = 'tnc_page';
  static const String supportPage = 'support_page';
  static const String chatWithDelivery = 'chat_screen';
  static const String addressesPage = 'addresses_page';
  static const String locationPage = 'location_page';
  static const String savedPage = 'saved_page';
  static const String offersPage = 'offers_page';
  static const String reviewOrderPage = 'review_order_page';
  static const String orderInfoPage = 'order_info_page';
  static const String doctorMapView = 'doctor_map_view';
  static const String appointmentPage = 'appointments_page';
  static const String languagePage = 'language_page';
  static const String loginNavigator = 'loginNavigator';
  static const String sendToBank = 'sendToBank';

  // static const String trial = 'trial';

  Map<String, WidgetBuilder> routes() {
    return {
      findMedicinesPage: (context) => MedicinePage(),
      bottomNavigation: (context) => BottomNavigation(),
      shopByCategory: (context) => ShopByCategoryPage(),
      medicines: (context) => MedicinesPage(category: '', name: '',),
      reviewsPage: (context) => ReviewPage(),
      sellerProfile: (context) => SellerProfilePage(profile: '', address: '',img_url: '',),
      // medicineInfo: (context) => ProductInfo(effects: '', image: '', quantity: '', name: '', price: '', id: '', shopid: '', discription: "", ),
      myCartPage: (context) => CartPage(),
      confirmOrderPage: (context) => ConfirmOrder(),
      choosePaymentMethod: (context) => ChoosePaymentMethod(),
      orderPlacedPage: (context) => OrderPlacedPage(),
      searchDoctors: (context) => SearchDoctors(dcat: '',),
      searchHistoryPage: (context) => SearchHistoryPage(),
      // listOfDoctorsPage: (context) => DoctorsPage(),
      sortFilterPage: (context) => SortFilter(),
      doctorInfo: (context) => DoctorInfo(Fees: '', profile: '', img_url: '', department_name: '', Exp: '', name: '', id: '', city: '', about: '',),
      // doctorReviewPage: (context) => DoctorReviewPage(),
      // bookAppointment: (context) => BookAppointment(),
      appointmentBooked: (context) => AppointmentBooked(),
      giveFeedback: (context) => GiveFeedback(),
      hospitalsHome: (context) => HospitalsHome(),
      hospitalMapView: (context) => HospitalMapView(),
      appointmentDetail: (context) => AppointmentDetail(),
      doctorChat: (context) => DoctorChat(),
      hospitalInfo: (context) => HospitalInfo(),
      walletPage: (context) => WalletPage(),
      addMoney: (context) => AddMoney(),
      createPillReminder: (context) => CreatePillReminderPage(),
      recentOrder: (context) => RecentOrdersPage(),
      orderTracking: (context) => OrderTrackingPage(),
      pillReminder: (context) => PillReminderPage(),
      createReminder: (context) => CreatePillReminderPage(),
      faqPage: (context) => FAQPage(),
      supportPage: (context) => SupportPage(),
      tncPage: (context) => TnCPage(),
      chatWithDelivery: (context) => ChatScreen(),
      addressesPage: (context) => SavedAddressesPage(),
      locationPage: (context) => LocationPage(),
      savedPage: (context) => SavedPage(),
      offersPage: (context) => OffersPage(),
      reviewOrderPage: (context) => ReviewOrderPage(),
      orderInfoPage: (context) => OrderInfoPage(),
      doctorMapView: (context) => DoctorMapView(),
      appointmentPage: (context) => AppointmentPage(),
      languagePage: (context) => ambulance_view(),
      loginNavigator: (context) => LoginNavigator(),
      sendToBank: (context) => SendToBank(),

      // trial: (context) => Trail(),
    };
  }
}
