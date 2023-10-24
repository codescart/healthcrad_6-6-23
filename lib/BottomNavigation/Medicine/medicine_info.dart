import 'dart:convert';
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:healthcrad_user/BottomNavigation/Medicine/my_cart.dart';
import 'package:healthcrad_user/Components/custom_button.dart';
import 'package:healthcrad_user/Locale/locale.dart';
import 'package:healthcrad_user/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:healthcrad_user/apiconstant.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/medicine model.dart';

class ProductInfo extends StatefulWidget {

  Product product;
  ProductInfo({required this.product});
  // ProductInfo({required this.name, required this.price, required this.quantity, required this.image, required this.effects, required this.id, required this.shopid, required this.discription, required this.discount, required this.discountamount, required this.rx,});
  @override
  _ProductInfoState createState() => _ProductInfoState();
}
var quntity=1;
class slider {
  String images;
  slider(this.images);
}
class _ProductInfoState extends State<ProductInfo> {
  List slider= [];

  int _counter = 1;

  void _incrementCounter() {
    if(_counter<=9) {
      setState(() {
        _counter++;
      });
    }
  }

  void decrementCounter() {
    if(_counter>=2) {
      setState(() {
        _counter--;
      });
    }
  }

  @override
  void initState() {
    // print(widget.product.imageUrls);
    // slider.add(widget.product.imageUrls);
    // TODO: implement initState
    super.initState();
  }

  var price;
  var myydet ;
  @override
  Widget build(BuildContext context) {
    myydet = int.parse(widget.product.discount_price.toString());
    price = myydet*_counter;
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.chevron_left)),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          IconButton(
              icon: Icon(
                Icons.shopping_cart,
                size: 20,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CartPage()));
              }),
        ],
      ),
      body: FadedSlideAnimation(
        Stack(
          children: [
            ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                   Container(
                     // padding: EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
                     height: MediaQuery.of(context).size.height*0.3,
                     child: PageView.builder(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.product.imageUrls.length,
                              itemBuilder: (context, index) {
                                print(widget.product.imageUrls.length);
                                // final aaa = widget.product.imageUrls
                                print("https://app.healthcrad.com/api/uploads/medicine/"+widget.product.imageUrls[index]);
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border:Border.all(width: 0.5,color: Colors.grey),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        "https://app.healthcrad.com/api/uploads/medicine/"+widget.product.imageUrls[index],
                                        // width: MediaQuery.of(context).size.width,
                                      ),
                                      fit: BoxFit.contain
                                    )
                                  ),
                                  margin: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
                                      // height: MediaQuery.of(context).size.height/4,
                                  // width:MediaQuery.of(context).size.width/1.03,
                                // child: Image.network(
                                //       "https://app.healthcrad.com/api/uploads/medicine/"+widget.product.imageUrls[index],
                                //       // width: MediaQuery.of(context).size.width,
                                //       fit: BoxFit.cover,
                                //     ),
                                ) ;
                              },
                            ),
                   ),
                    // FadedScaleAnimation(
                    //   // Container(
                    //   //   height: MediaQuery.of(context).size.height*0.3,
                    //   //   child: Image.network(
                    //   //     "https://app.healthcrad.com/api/uploads/medicine/"+widget.image,
                    //   //     width: MediaQuery.of(context).size.width,
                    //   //     fit: BoxFit.cover,
                    //   //   ),
                    //   // ),
                    //   Container(
                    //       height: MediaQuery.of(context).size.height*0.3,
                    //     // height: 130,
                    //     child:
                    //     CarouselSlider(
                    //       items: stringList.map((i) {
                    //         print("https://app.healthcrad.com/api/uploads/medicine/"+i);
                    //         print(i);
                    //         return Builder(
                    //           builder: (BuildContext context) {
                    //             return Padding(
                    //               padding:  EdgeInsets.only(left: 10, right: 10),
                    //               child: Container(
                    //                 decoration: BoxDecoration(
                    //                   borderRadius: BorderRadius.circular(5),
                    //                   image: DecorationImage(
                    //                     image: NetworkImage("https://app.healthcrad.com/api/uploads/medicine/"+i),
                    //                     // image: NetworkImage("https://app.healthcrad.com/api//uploads/advertisement/firstbanner.png"),
                    //                     fit: BoxFit.cover,
                    //                   ),
                    //                 ),
                    //               ),
                    //             );
                    //           },
                    //         );
                    //         // $i'
                    //       }).toList(),
                    //       options: CarouselOptions(
                    //         // height: MediaQuery.of(context).size.height * 1,
                    //         aspectRatio: 7/ 4,
                    //         viewportFraction: 1,
                    //         initialPage: 0,
                    //         enableInfiniteScroll: true,
                    //         reverse: false,
                    //         autoPlay: false,
                    //         autoPlayInterval: Duration(seconds: 2),
                    //         autoPlayAnimationDuration: Duration(milliseconds: 800),
                    //         autoPlayCurve: Curves.fastOutSlowIn,
                    //         enlargeCenterPage: true,
                    //         enlargeFactor: 0.3,
                    //         // onPageChanged: callbackFunction,
                    //         scrollDirection: Axis.horizontal,
                    //       ),
                    //     ),
                    //   ),
                    //   durationInMilliseconds: 300,
                    // ),
                   widget.product.prescription=="1"? Positioned.directional(
                        textDirection: Directionality.of(context),
                        end: 5,
                        top: 5,
                        child: Image.asset(
                          'assets/ic_prescription.png',
                          scale: 3,
                        )):SizedBox(),
                    widget.product.status=="0"? Positioned.directional(
                        textDirection: Directionality.of(context),
                        // top: MediaQuery.of(context).size.height/3.8,
                        // start: MediaQuery.of(context).size.width/3.2,
                        child: Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.red,
                            // border: Border.all(width: 0.5, color: Colors.grey),
                          ),
                          child: Text("Product out of Stock",style:TextStyle(color: Colors.white),),
                        )):SizedBox(),
                  ],
                ),
                Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              // color: Colors.red,
                              width: MediaQuery.of(context).size.width/1.1,
                              child: Text(
                                widget.product.name.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(fontSize: 18.2, color: black2,overflow: TextOverflow.ellipsis),
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          children: [
                            Text("₹ "+"${widget.product.price}"+".00",
                                textAlign: TextAlign.right,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                    fontSize: 13.7,
                                    decoration: TextDecoration.lineThrough)),
                            Text( "  off ${widget.product.discount}"+"%",
                                textAlign: TextAlign.right,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                    fontSize: 16.5,
                                    fontWeight: FontWeight.w600, color: Colors.green)),
                          ],
                        ),
                        SizedBox(height: 5,),

                        Text( "₹ ${widget.product.discount_price}"+".00",
                            textAlign: TextAlign.right,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                fontSize: 16.5,
                                fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor)),
                      ],
                    ),
                    subtitle: Padding(
                      padding: EdgeInsets.only(top: 10.5, bottom: 20),
                      child: Row(
                        children: [
                          Text(
                            locale.heathCare!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: lightGreyColor, fontSize: 13.5),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 12,
                            color: Theme.of(context).disabledColor,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 15),
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Select Quantity : "),
                      IconButton(
                          onPressed: (){
                            decrementCounter();
                          },
                          icon: Icon(Icons.minimize_sharp, size: 30,)
                      ),
                      Text("$_counter",style: TextStyle(fontSize: 20),),
                      IconButton(
                          onPressed: (){
                            _incrementCounter();
                          },
                          icon: Icon(Icons.add, size: 30,)
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 13.0),
                  child: Text(
                    locale.description!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 13.5, color: lightGreyColor),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width/2,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, top: 0, bottom: 15),
                  child: Text(
                    widget.product.description==null?"":widget.product.description.toString(),
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                        fontSize: 13.5,
                        color: black2),
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: ListTile(
                      title:  Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Quantity : " + '$_counter',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w600,
                                color: Colors.blueGrey),
                          ),
                        ],
                      ),
                      trailing: Text(
                        '$_counter'==1?'Price : ₹'+widget.product.discount_price.toString():'Price : ₹ $price.00',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  CustomButton(
                    radius: 0,
                    label: locale.addToCart,
                    onTap: () {
                      if(widget.product.status =="1"){
                        addCart();
                      }
                      else{
                        Fluttertoast.showToast(
                            msg: "Sorry selected product is out of stock",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }


addCart() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'user_id';
    final user_id = prefs.getString(key) ?? 0;
    final quantity = _counter.toString();
      final response = await http.post(
        Uri.parse(Api.baseurl+"mediaddcart"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'id': "$user_id" ,
          'productid':widget.product.id.toString(),
          "shopid": widget.product.shopid.toString(),
          "quantity": quantity,
        }),
      );
      final data = jsonDecode(response.body);

      if (data['error'] == '200') {
        Fluttertoast.showToast(
            msg: "item added sucessfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CartPage()));
      }
      else {
        Fluttertoast.showToast(
            msg: "Already added",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
  }
}
