import 'dart:convert';
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:healthcrad_user/BottomNavigation/Medicine/medicine_info.dart';
import 'package:healthcrad_user/Components/custom_add_item_button.dart';
import 'package:flutter/material.dart';
import 'package:healthcrad_user/apiconstant.dart';
import 'package:http/http.dart' as http;

import '../../model/medicine model.dart';

class view_home_medicine extends StatefulWidget {
  @override
  _view_home_medicineState createState() => _view_home_medicineState();
}

class _view_home_medicineState extends State<view_home_medicine> {
  @override
  Widget build(BuildContext context) {
    late List<String> stringList;

    return FutureBuilder<List<Product>>(
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
                itemCount: 3,
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.62,
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
                                product: product,
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
                              height: MediaQuery.of(context).size.height*0.10,
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
                                  Text("₹ "+"${product.price}",
                                      textAlign: TextAlign.right,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                          fontSize: 9,
                                          decoration: TextDecoration.lineThrough)),
                                  Text( "  off ${product.discount}"+"%",
                                      textAlign: TextAlign.right,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                          fontSize: 10,
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
                                        fontSize: 12.5,
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

    );
  }


}




Future<List<Product>> fetchProducts() async {
  final response = await http.get(Uri.parse('https://app.healthcrad.com/api/index.php/api/Mobile_app/medicebyall'));
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body);
    return List<Product>.from(parsed['data'].map((item) => Product.fromJson(item)));
  } else {
    throw Exception('Failed to load products');
  }
}

