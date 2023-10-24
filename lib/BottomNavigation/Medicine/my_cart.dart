import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:healthcrad_user/BottomNavigation/Doctors/doctor_search.dart';
import 'package:healthcrad_user/BottomNavigation/Medicine/allmedi.dart';
import 'package:healthcrad_user/BottomNavigation/Medicine/order_address_opt.dart';
import 'package:healthcrad_user/BottomNavigation/bottom_navigation.dart';
import 'package:healthcrad_user/Components/custom_button.dart';
import 'package:healthcrad_user/Locale/locale.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../search_page.dart';

class CartItem {
  String id;
  String name;
  String amount;
  final List<String> image;
  String? profile;
  String? quantity;
  String? discounted;
  String? off;
  int qtys;
  String? prescription;

  CartItem(
      {required this.id,
      required this.name,
      required this.amount,
      required this.image,
      this.profile,
      this.quantity,
      required this.qtys,
      required this.discounted,
      required this.off,
      required this.prescription});
}

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    fetchItems();
    calculateTotalPrice();
    super.initState();
  }

  List<CartItem> cartItems = [];
  List<CartItem> prescrib = [];
  Timer? timer;

  Future fetchItems() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'user_id';
    final user_id = prefs.getString(key) ?? 0;
    final response = await http.get(
      Uri.parse(
          'https://app.healthcrad.com/api/index.php/api/Mobile_app/medicart?userid=$user_id'),
    );
    final items = json.decode(response.body) as List;
    print(items);
    if (response.statusCode == 200) {
      setState(() {
        cartItems = items
            .map((item) => CartItem(
                  name: item['name'].toString(),
                  amount: item['amount'].toString(),
                  id: item['id'].toString(),
                  quantity: item['quantity'].toString(),
                  // image:item['image'],
                  image: List<String>.from(item['image']),
                  qtys: item['qtys'] ?? 1,
                  discounted: item['discountedPrice'].toString(),
                  off: item['discount'].toString(),
                  prescription: item['prescription'].toString(),
                ))
            .toList();
      });
    } else {
      throw Exception('Failed to load items');
    }
  }

  Future<void> increaseItemCount(
    int index,
  ) async {
    cartItems[index].qtys += 1;

    final prefs = await SharedPreferences.getInstance();
    final key = 'user_id';
    final user_id = prefs.getString(key) ?? 0;
    print(user_id);
    print("aaaaaaaaa");
    final response = await http.post(
      Uri.parse(
          "https://app.healthcrad.com/api/index.php/api/Mobile_app/cartmedicineupdate"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'medicineid': cartItems[index].id,
        'userid': '$user_id',
        'quantity': cartItems[index].qtys.toString(),
      }),
    );
    final data = jsonDecode(response.body);
    print(data);
    if (data['error'] == '200') {
      print(
        cartItems[index].qtys.toString(),
      );
      print("update successfully");
    } else {
      print("not going on");
    }
  }

  Future<void> decreaseItemCount(int index) async {
    if (cartItems[index].qtys > 1) {
      cartItems[index].qtys -= 1;

      final prefs = await SharedPreferences.getInstance();
      final key = 'user_id';
      final user_id = prefs.getString(key) ?? 0;
      print(user_id);
      print("aaaaaaaaa");
      final response = await http.post(
        Uri.parse(
            "https://app.healthcrad.com/api/index.php/api/Mobile_app/cartmedicineupdate"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'medicineid': cartItems[index].id,
          'userid': '$user_id',
          'quantity': cartItems[index].qtys.toString(),
        }),
      );
      final data = jsonDecode(response.body);
      print(data);
      if (data['error'] == '200') {
        print(
          cartItems[index].qtys.toString(),
        );
        print("update successfully");
      } else {
        print("not going on");
      }
    }
  }

  double calculateTotalPrice() {
    double totalPrice = 0;
    for (var item in cartItems) {
      final myamount = int.parse(item.discounted.toString());
      totalPrice += myamount * item.qtys;
    }
    return totalPrice;
  }

  File? file;
  final picker = ImagePicker();
  var mydata;
  void _choose() async {
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: 500,
        maxWidth: 500);
    setState(() {
      if (pickedFile != null) {
        file = File(pickedFile.path);
        final bytes = File(pickedFile.path).readAsBytesSync();
        String img64 = base64Encode(bytes);
        mydata = img64;
      } else {
        print('No image selected.');
      }
    });
  }

  var validate;
  List rx = [];
  @override
  Widget build(BuildContext context) {
    late List<String> stringList;

    var locale = AppLocalizations.of(context)!;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => BottomNavigation())),
              icon: Icon(
                Icons.chevron_left,
                color: Colors.white,
              )),
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            locale.myCart!,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontSize: 19, fontWeight: FontWeight.w700, color: Colors.white),
          ),
          centerTitle: true,
        ),
        body:cartItems.length ==0?
        Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shopping_cart_outlined, size: 80,color: Theme.of(context).primaryColor,),
              Text(
                  "Nothing here!!!\nYour cart is empty..",
              textAlign: TextAlign.center,
              ),
              SizedBox(height: 20,),
              InkWell(
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Medicinesall()));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).primaryColor
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_shopping_cart, size: 30,color: Colors.white,),
                      SizedBox(width: 5,),
                      Text("Shop now", style: TextStyle(fontSize: 18,color: Colors.white),)
                    ],
                  ),
                ),
              )
            ],
          ),
        ):
        FadedSlideAnimation(
          Stack(
            children: [
              ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => medicine_search()));
                    },
                    child: Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width / 1.1,
                      padding: EdgeInsets.only(left: 10, right: 10),
                      margin: EdgeInsets.only(left: 15, right: 15),
                      // padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 2),
                              color: Colors.grey.shade600.withOpacity(0.6),
                              spreadRadius: 0,
                              blurRadius: 3)
                        ],
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Search",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          Icon(
                            Icons.search,
                            size: 25,
                            color: Colors.black,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  file == null
                      ? InkWell(
                          onTap: () {
                            _choose();
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 15, right: 15),
                            padding: EdgeInsets.only(
                                left: 15, right: 15, top: 5, bottom: 5),
                            height: 50,
                            width: MediaQuery.of(context).size.width / 1.7,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 0.1,
                                  color: Theme.of(context).primaryColor),
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.greenAccent.withOpacity(0.1),
                            ),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // SizedBox(width: 8),
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.4,
                                    child: Text(
                                      "some of the products from your order requires prescription, please attach to proceed",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Proxima Nova"),
                                    )),
                                // SizedBox(width: ,),
                                Icon(
                                  Icons.camera_alt,
                                  color: Colors.grey,
                                  size: 30,
                                ),
                              ],
                            ),
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            _choose();
                          },
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width / 1.7,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 0.1,
                                  color: Theme.of(context).primaryColor),
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.greenAccent.withOpacity(0.1),
                            ),
                            child: Row(
                              children: [
                                SizedBox(width: 8),
                                Icon(
                                  Icons.camera,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Test recipt Uploaded",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Proxima Nova"),
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Icon(
                                    Icons.verified,
                                    color: Colors.green,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: cartItems.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        validate = cartItems.length;
                        // stringList =cartItems[index].image!.split(',');
                        print("rohit");
                        // print(stringList.first);
                        return Column(
                          children: [
                            SizedBox(
                              height: 6,
                            ),
                            InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 12),
                                child: Row(
                                  // crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      height: 70,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              "https://app.healthcrad.com/api/uploads/medicine/" +
                                                  cartItems[index].image.first),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    // height: 75,
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      flex: 9,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.5,
                                                child: Text(
                                                  '${cartItems[index].name}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle1!
                                                      .copyWith(
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.038,
                                                          color: Colors.black,
                                                          overflow: TextOverflow
                                                              .ellipsis),
                                                  softWrap: true,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                  "₹ " +
                                                      "${cartItems[index].amount}" +
                                                      ".00",
                                                  textAlign: TextAlign.right,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                          fontSize: 13.7,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough)),
                                              Text(
                                                  "  off ${cartItems[index].off}" +
                                                      "%",
                                                  textAlign: TextAlign.right,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                          fontSize: 16.7,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.green)),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              IconButton(
                                                icon: Icon(Icons.remove),
                                                onPressed: () {
                                                  setState(() {
                                                    decreaseItemCount(index);
                                                  });
                                                },
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Text("${cartItems[index].qtys}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle1!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.add),
                                                onPressed: () {
                                                  setState(() {
                                                    increaseItemCount(index);
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Expanded(
                                      flex: 4,
                                      child: Column(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Dialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16),
                                                      ),
                                                      elevation: 0,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 10,
                                                                bottom: 10),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16),
                                                            color: Colors.white,
                                                            border: Border.all(
                                                                width: 5,
                                                                color: Colors
                                                                    .black54)),
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        height: 200,
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              child: Icon(
                                                                Icons
                                                                    .warning_amber,
                                                                size: 50,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            ),
                                                            Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(10),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  1.1,
                                                              child: Text(
                                                                "Are you really want to delete the selected cart item ?",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .blueGrey,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                Container(
                                                                  width: 100,
                                                                  height: 40,
                                                                  child:
                                                                      ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>CartPage()));
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    style: ElevatedButton.styleFrom(
                                                                        primary:
                                                                            Colors.red),
                                                                    child: Text(
                                                                      "Cancel",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              18,
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 40,
                                                                  width: 100,
                                                                  child: ElevatedButton(
                                                                      onPressed: () async {
                                                                        final response =
                                                                            await http.post(
                                                                          Uri.parse(
                                                                              "https://app.healthcrad.com/api/index.php/api/Mobile_app/addtocartdelete"),
                                                                          headers: {
                                                                            'Content-Type':
                                                                                'application/json; charset=UTF-8',
                                                                          },
                                                                          body:
                                                                              jsonEncode({
                                                                            "id":
                                                                                cartItems[index].id,
                                                                          }),
                                                                        );
                                                                        if (response.statusCode ==
                                                                            200) {
                                                                          setState(
                                                                              () {
                                                                            fetchItems();
                                                                            Navigator.pop(context);
                                                                            Navigator.pushReplacement(context,
                                                                                MaterialPageRoute(builder: (context) => CartPage()));
                                                                            // Navigator.pop(context);
                                                                          });
                                                                        } else {
                                                                          fetchItems();
                                                                        }
                                                                      },
                                                                      style: ElevatedButton.styleFrom(primary: Theme.of(context).primaryColor),
                                                                      child: Text(
                                                                        "Confirm",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                15),
                                                                      )),
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  });
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                          ),
                                          Text(
                                              "₹ " +
                                                  "${cartItems[index].discounted}" +
                                                  ".00",
                                              textAlign: TextAlign.right,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                      fontSize: 16.7,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                  SizedBox(height: 270),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.only(left: 15),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 1,
                                child: Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              locale.amountPayable!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2!
                                                  .copyWith(
                                                      fontSize: 13.5,
                                                      color: Color(0xff5b5b5b)),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            GestureDetector(
                                                onTap: () {},
                                                child: Icon(
                                                  Icons.error_outline,
                                                  size: 16,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ))
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "If order less ₹ 1099 you have to pay Rs. 80 delivery charge",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.2,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Items Cost: ",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2!
                                                    .copyWith(
                                                        fontSize: 15,
                                                        color:
                                                            Color(0xff5b5b5b),
                                                        fontWeight:
                                                            FontWeight.w400),
                                              ),
                                              Text(
                                                "₹ " +
                                                    calculateTotalPrice()
                                                        .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2!
                                                    .copyWith(
                                                        fontSize: 15,
                                                        color:
                                                            Color(0xff5b5b5b),
                                                        fontWeight:
                                                            FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.2,
                                          child: calculateTotalPrice().toInt() <
                                                  1099
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Delivery charge: ",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2!
                                                          .copyWith(
                                                              fontSize: 15,
                                                              color: Color(
                                                                  0xff5b5b5b),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                    ),
                                                    Text(
                                                      "+ ₹ 80",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2!
                                                          .copyWith(
                                                              fontSize: 15,
                                                              color: Color(
                                                                  0xff5b5b5b),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                    ),
                                                  ],
                                                )
                                              : Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Delivery charge: ",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2!
                                                          .copyWith(
                                                              fontSize: 15,
                                                              color: Color(
                                                                  0xff5b5b5b),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                    ),
                                                    Text(
                                                      "+ ₹ 00",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2!
                                                          .copyWith(
                                                              fontSize: 15,
                                                              color: Color(
                                                                  0xff5b5b5b),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                    ),
                                                  ],
                                                ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.2,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Total cost: ",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2!
                                                      .copyWith(
                                                          fontSize: 15,
                                                          color:
                                                              Color(0xff5b5b5b),
                                                          fontWeight:
                                                              FontWeight.w400),
                                                ),
                                                Text(
                                                  "₹ ${calculateTotalPrice().toInt() > 1099 ? calculateTotalPrice() : calculateTotalPrice().toInt() + 80}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2!
                                                      .copyWith(
                                                          fontSize: 15,
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                ),
                                              ],
                                            )),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Spacer(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                "Total-  ₹ " +
                                    '${calculateTotalPrice().toInt() > 1099 ? calculateTotalPrice() : calculateTotalPrice().toInt() + 80} ',
                                // '$amountPayabe',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      fontSize: 20.7,
                                    )),
                            Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: CustomButton(
                                onTap: () {
                                  final price= calculateTotalPrice().toInt() > 1099 ? calculateTotalPrice() : calculateTotalPrice().toInt() + 80;
                                  // medid= cartItems.first.id.toString();
                                  print("aaaaaaaaa");
                                 print(price);
                                  if (validate != null) {
                                    print(cartItems.first.prescription);
                                    if (cartItems.first.prescription == "0") {
                                      print(price);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ordr_opt(
                                                  subtotal: price.toString())));
                                    }
                                    if (cartItems.first.prescription == "1" &&
                                        file == null) {
                                      Fluttertoast.showToast(
                                          msg:
                                              "Prescripion is required \nbecause you have added an image that required prescription",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 5,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 12.0);
                                    }
                                    if (cartItems.first.prescription == "1" &&
                                        file != null) {
                                      print(cartItems.first.id);
                                      upload_prescription();
                                    }
                                  }
                                  // List<String> val= cartItems.where((element) => element.prescription.toString() == "1").toString())
                                  // if(cartItems.single.prescription.toString() =="1"){
                                  //   print("hey not allowed");
                                  // }
                                  // if(validate==null || cartItems.first.prescription=="1" || cartItems.last.prescription=="1" || cartItems.single.prescription=="1"){
                                  //   const snackBar = SnackBar(
                                  //     content: Text('Must have to upload prescription'),
                                  //   );
                                  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  //   Fluttertoast.showToast(
                                  //       msg: "Cart in empty",
                                  //       toastLength: Toast.LENGTH_SHORT,
                                  //       gravity: ToastGravity.CENTER,
                                  //       timeInSecForIosWeb: 1,
                                  //       backgroundColor: Colors.red,
                                  //       textColor: Colors.white,
                                  //       fontSize: 16.0);
                                  // }
                                  else {
                                    const snackBar = SnackBar(
                                      content: Text(
                                          'Add items to continue shopping'),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                    Fluttertoast.showToast(
                                        msg: "Cart in empty",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                },
                                radius: 0,
                                label: "Continue",
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  size: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          beginOffset: Offset(0, 0.3),
          endOffset: Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
        ),
      ),
    );
  }

  var medid;
  upload_prescription() async {
    medid = cartItems.first.id;
    print(medid);
    final prefs = await SharedPreferences.getInstance();
    final key = 'user_id';
    final user_id = prefs.getString(key) ?? 0;
    print("aaaaaaaaa");
    final response = await http.post(
      Uri.parse(
          "https://app.healthcrad.com/api/index.php/api/Mobile_app/precriptionorder"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userid': user_id.toString(),
        'medicineid': '$medid',
        'image': mydata,
      }),
    );
    final data = jsonDecode(response.body);
    print(data);
    if (response.statusCode == 200) {
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNavBar()));
      Fluttertoast.showToast(
          msg: 'prescription update successfully ',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.transparent,
          textColor: Colors.green,
          fontSize: 16.0);
      // Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavigation()));
      final price= calculateTotalPrice().toInt() > 1099 ? calculateTotalPrice() : calculateTotalPrice().toInt() + 80;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ordr_opt(
                    subtotal: price.toString(),
                  )));
    } else {
      Fluttertoast.showToast(
          msg: data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xffff0000),
          textColor: Color(0xffffffff),
          fontSize: 16.0);
    }
  }
}
