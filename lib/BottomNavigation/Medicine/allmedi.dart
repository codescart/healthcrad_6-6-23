import 'dart:convert';
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:healthcrad_user/BottomNavigation/Medicine/medicine_info.dart';
import 'package:healthcrad_user/BottomNavigation/Medicine/order/prescription_summry.dart';
import 'package:healthcrad_user/Components/custom_add_item_button.dart';
import 'package:flutter/material.dart';
import 'package:healthcrad_user/apiconstant.dart';
import 'package:healthcrad_user/search_page.dart';
import 'package:http/http.dart' as http;

import '../../model/medicine model.dart';

class Medicinesall extends StatefulWidget {
  @override
  _MedicinesallState createState() => _MedicinesallState();
}

class _MedicinesallState extends State<Medicinesall> {
  late Future<List<Product>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = fetchProducts();

  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              size: 16,
              color: Colors.white,
            ),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          title: Text("All Medicines"),
          actions: [
            Padding(
                padding: EdgeInsets.only(right: 15),
                child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => medicine_search()));
                    },
                    icon: Icon(
                      Icons.search,
                      size: 25,
                      color: Colors.white,
                    )))
          ],
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => prescription_summry()));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 15, right: 15),
                    padding:
                        EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),

                    height: 50,
                    // width:MediaQuery.of(context).size.width/1.7,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 0.1, color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.greenAccent.withOpacity(0.1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // SizedBox(width: 8),
                        Container(
                            // width:MediaQuery.of(context).size.width/1.3,
                            child: Text(
                          "Order By Presription",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 15,
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
                ),
                Container(
                  height: 10,
                ),
                // SizedBox(height: 10,),
                   FutureBuilder<List<Product>>(
                    future: fetchProducts(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        return GridView.builder(
                            padding: EdgeInsets.symmetric(
                                vertical: 6, horizontal: 6),
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.82,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12),
                            itemBuilder: (context, index) {
                              final product = snapshot.data![index];
                              print("image is here");
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProductInfo(
                                            // effects: "",
                                            // // snapshot
                                            // //     .data![index].effects
                                            // //     .toString(),
                                            // price: product.price
                                            //     .toString(),
                                            // image:product.imageUrls
                                            //     .toString(),
                                            // quantity: product
                                            //     .quantity ==
                                            //     null
                                            //     ? "  Out of Stock"
                                            //     : product.quantity
                                            //     .toString(),
                                            // name: product.name
                                            //     .toString(),
                                            // id: product.id.toString(),
                                            // shopid: product.shopid.toString(),
                                            // discription: product.description.toString(),
                                            // discount: product.discount.toString(),
                                            // discountamount: product.discount_price.toString(),
                                            // rx:product.prescription.toString(),
                                            product: product,
                                          )));
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      // margin: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          borderRadius:
                                          BorderRadius.circular(8)),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                        children: [
                                          Stack(
                                            children: [
                                              FadedScaleAnimation(
                                                Container(
                                                  height: MediaQuery.of(context).size.height*0.15,
                                                  child: Image.network(
                                                      "https://app.healthcrad.com/api/uploads/medicine/" +
                                                          product.imageUrls.first
                                                  ),
                                                ),
                                                durationInMilliseconds: 400,
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          Text(
                                            product.name
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                fontSize: 11.5,
                                                color: Color(0xff5b5b5b),
                                                fontWeight:
                                                FontWeight.w600),
                                            maxLines: 1, overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            children: [
                                              Text("₹ "+"${product.price}"+".00",
                                                  textAlign: TextAlign.right,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                      fontSize: 10.7,
                                                      decoration: TextDecoration.lineThrough)),
                                              Text( "  off ${product.discount}"+"%",
                                                  textAlign: TextAlign.right,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w600, color: Colors.green)),
                                            ],
                                          ),

                                          Row(
                                            children: [
                                              Text(
                                                '\₹ ' +
                                                    product.discount_price
                                                        .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Align(
                                    //   alignment: Alignment.bottomRight,
                                    //   child: CustomAddItemButton(),
                                    // ),
                                  ],
                                ),
                              );
                            });
                      } else {
                        return Center(child: Text('No data available'));
                      }
                    }
    )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


Future<List<Product>> fetchProducts() async {
  final response = await http.get(
      Uri.parse('https://app.healthcrad.com/api/index.php/api/Mobile_app/medicebyall'),
  );
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body);
    return List<Product>.from(parsed['data'].map((item) => Product.fromJson(item)));
  }
  else {
    throw Exception('Failed to load products');
  }
}



