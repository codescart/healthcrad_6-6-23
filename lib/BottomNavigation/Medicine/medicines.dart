import 'dart:convert';
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:healthcrad_user/BottomNavigation/Medicine/medicine_info.dart';
import 'package:healthcrad_user/Components/custom_add_item_button.dart';
import 'package:healthcrad_user/Locale/locale.dart';
import 'package:healthcrad_user/Routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:healthcrad_user/apiconstant.dart';
import 'package:http/http.dart' as http;

import '../../model/medicine model.dart';

class MedicinesPage extends StatefulWidget {
  final String category;
  final String name;
   MedicinesPage({Key? key, required this.category, required this.name}) : super(key: key);
  @override
  _MedicinesPageState createState() => _MedicinesPageState();
}

class _MedicinesPageState extends State<MedicinesPage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.chevron_left)),
          title: Text(
            widget.name,
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
          actions: [
            Stack(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    size: 20,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, PageRoutes.myCartPage);
                  },
                ),
                Positioned.directional(
                  textDirection: Directionality.of(context),
                  top: 8,
                  end: 12,
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 5.5,
                    child: Center(
                        child: Text(
                      '1',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          fontSize: 9),
                    )),
                  ),
                )
              ],
            )
          ],
          toolbarTextStyle: Theme.of(context).textTheme.bodyText2,
          titleTextStyle: Theme.of(context).textTheme.headline6,
        ),
        body: FadedSlideAnimation(
          Medicines(category:widget.category),
          beginOffset: Offset(0, 0.3),
          endOffset: Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
        ));
  }
}

class Medicines extends StatefulWidget {
  final String category;
  Medicines({Key? key, required this.category}) : super(key: key);
  @override
  _MedicinesState createState() => _MedicinesState();
}

class _MedicinesState extends State<Medicines> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
              color: Theme.of(context).backgroundColor,
              child:  Column(
                children: [
                  FutureBuilder<List<Product>>(
                      future: fetchProducts(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.hasData) {
                          return  GridView.builder(
                              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.8,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 12),
                              itemBuilder: (context, index) {
                                final product = snapshot.data![index];
                                // stringList =snapshot.data![index].image!.split(',');
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ProductInfo(
                                              product: product,
                                            )));
                                  },
                                  child: Stack(
                                    children: [
                                      Text(widget.category),
                                      Container(
                                        // margin: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                                        padding:
                                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                        decoration: BoxDecoration(
                                            color: Theme
                                                .of(context)
                                                .scaffoldBackgroundColor,
                                            borderRadius: BorderRadius.circular(8)),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            Stack(
                                              children: [
                                                FadedScaleAnimation(
                                                    durationInMilliseconds: 400,
                                                    Container(
                                                      height: 120,
                                                      decoration:BoxDecoration(
                                                          image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: NetworkImage("https://app.healthcrad.com/api/uploads/medicine/"+ snapshot.data![index].imageUrls.first,)
                                                          )
                                                      ),)
                                                  // child: Image.network("https://app.healthcrad.com/api/uploads/medicine/"+ stringList.first,)),
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                            Text(
                                              snapshot.data![index].name.toString(),
                                              style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                  fontSize: 11.5,
                                                  color: Color(0xff5b5b5b),
                                                  fontWeight: FontWeight.w600),
                                              maxLines: 2, overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 5),

                                            SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Text(
                                                  '\₹ ' + snapshot.data![index].price.toString(),
                                                  style: Theme
                                                      .of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ],
                                            ),

                                          ],
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: CustomAddItemButton(),
                                      ),
                                    ],
                                  ),
                                );
                              }
                          );
                        } else {
                          return Center(child: Text('No data available'));
                        }
                      }
                    // GridView.builder(
                    //         padding: EdgeInsets.symmetric(
                    //             vertical: 6, horizontal: 6),
                    //         physics: BouncingScrollPhysics(),
                    //         shrinkWrap: true,
                    //         itemCount: snapshot.data!.products.length,
                    //         gridDelegate:
                    //             SliverGridDelegateWithFixedCrossAxisCount(
                    //                 crossAxisCount: 2,
                    //                 childAspectRatio: 0.82,
                    //                 crossAxisSpacing: 12,
                    //                 mainAxisSpacing: 12),
                    //         itemBuilder: (context, index) {
                    //           // Product product = snapshot.data!.products[index];
                    //           print("image is here");
                    //           // print(snapshot.data!.first.image);
                    //           // stringList =snapshot.data![index].imageUrls.first!;
                    //           print(stringList.first);
                    //           return GestureDetector(
                    //             onTap: () {
                    //               Navigator.push(
                    //                   context,
                    //                   MaterialPageRoute(
                    //                       builder: (context) => ProductInfo(
                    //                           effects: "",
                    //                           // snapshot
                    //                           //     .data![index].effects
                    //                           //     .toString(),
                    //                           price: snapshot.data!.products[index].price
                    //                               .toString(),
                    //                           image: snapshot
                    //                               .data!.products[index].imageUrls
                    //                               .toString(),
                    //                           quantity: snapshot.data!.products[index]
                    //                                       .quantity ==
                    //                                   null
                    //                               ? "  Out of Stock"
                    //                               : snapshot
                    //                                   .data!.products[index].quantity
                    //                                   .toString(),
                    //                           name: snapshot.data!.products[index].name
                    //                               .toString(),
                    //                           id: snapshot.data!.products[index].id.toString(),
                    //                           shopid: snapshot.data!.products[index].shopid.toString(),
                    //                           discription: snapshot.data!.products[index].description.toString(),
                    //                           discount: snapshot.data!.products[index].discount.toString(),
                    //                           discountamount: snapshot.data!.products[index].discount_price.toString(),
                    //                         rx:snapshot.data!.products[index].prescription.toString(),
                    //                       )));
                    //             },
                    //             child: Stack(
                    //               children: [
                    //                 Container(
                    //                   // margin: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                    //                   padding: EdgeInsets.symmetric(
                    //                       vertical: 10, horizontal: 10),
                    //                   decoration: BoxDecoration(
                    //                       color: Theme.of(context)
                    //                           .scaffoldBackgroundColor,
                    //                       borderRadius:
                    //                           BorderRadius.circular(8)),
                    //                   child: Column(
                    //                     crossAxisAlignment:
                    //                         CrossAxisAlignment.stretch,
                    //                     children: [
                    //                       Stack(
                    //                         children: [
                    //                           FadedScaleAnimation(
                    //                             Container(
                    //                               height: MediaQuery.of(context).size.height*0.15,
                    //                               child: Image.network(
                    //                                   "https://app.healthcrad.com/api/uploads/medicine/" +
                    //                                      snapshot.data!.products[index].imageUrls.first
                    //                               ),
                    //                             ),
                    //                             durationInMilliseconds: 400,
                    //                           ),
                    //                         ],
                    //                       ),
                    //                       Spacer(),
                    //                       Text(
                    //                         snapshot.data!.products[index].name
                    //                             .toString(),
                    //                         style: Theme.of(context)
                    //                             .textTheme
                    //                             .bodyText1!
                    //                             .copyWith(
                    //                                 fontSize: 11.5,
                    //                                 color: Color(0xff5b5b5b),
                    //                                 fontWeight:
                    //                                     FontWeight.w600),
                    //                         maxLines: 1, overflow: TextOverflow.ellipsis,
                    //                       ),
                    //                       SizedBox(height: 5),
                    //                       Row(
                    //                         children: [
                    //                           Text("₹ "+"${snapshot.data!.products[index].price}"+".00",
                    //                               textAlign: TextAlign.right,
                    //                               style: Theme.of(context)
                    //                                   .textTheme
                    //                                   .bodyText1!
                    //                                   .copyWith(
                    //                                   fontSize: 10.7,
                    //                                   decoration: TextDecoration.lineThrough)),
                    //                           Text( "  off ${snapshot.data!.products[index].discount}"+"%",
                    //                               textAlign: TextAlign.right,
                    //                               style: Theme.of(context)
                    //                                   .textTheme
                    //                                   .bodyText1!
                    //                                   .copyWith(
                    //                                   fontSize: 12,
                    //                                   fontWeight: FontWeight.w600, color: Colors.green)),
                    //                         ],
                    //                       ),
                    //
                    //                       Row(
                    //                         children: [
                    //                           Text(
                    //                             '\₹ ' +
                    //                                 snapshot
                    //                                     .data!.products[index].discount_price
                    //                                     .toString(),
                    //                             style: Theme.of(context)
                    //                                 .textTheme
                    //                                 .bodyText1!
                    //                                 .copyWith(
                    //                                     fontSize: 15,
                    //                                     fontWeight:
                    //                                         FontWeight.w700),
                    //                           ),
                    //                         ],
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //                 // Align(
                    //                 //   alignment: Alignment.bottomRight,
                    //                 //   child: CustomAddItemButton(),
                    //                 // ),
                    //               ],
                    //             ),
                    //           );
                    //         }))
                  ),
                ],
              )),
          ],
        ),
      )
    );
  }
  Future<List<Product>> fetchProducts() async {
    print(widget.category);
    final response = await http.post(
      Uri.parse('https://app.healthcrad.com/api/index.php/api/Mobile_app/medicebycategory'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "category": widget.category,
      }),
    );

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      return List<Product>.from(parsed['data'].map((item) => Product.fromJson(item)));
    } else {
      throw Exception('Failed to load products');
    }
  }
}




