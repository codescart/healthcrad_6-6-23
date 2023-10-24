import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthcrad_user/BottomNavigation/Medicine/medicine_info.dart';
import 'package:healthcrad_user/model/medicine%20model.dart';
import 'package:http/http.dart' as http;

class medicine_search extends StatefulWidget {
  medicine_search() : super();

  @override
  medicine_searchState createState() => medicine_searchState();
}

class Debouncer {
  int? milliseconds;
  VoidCallback? action;
  Timer? timer;

  run(VoidCallback action) {
    if (null != timer) {
      timer!.cancel();
    }
    timer = Timer(
      Duration(milliseconds: Duration.millisecondsPerSecond),
      action,
    );
  }
}

class medicine_searchState extends State<medicine_search> {
  final _debouncer = Debouncer();

  // List<Subject> ulist = [];
  // List<Subject> userLists = [];
  //API call for All Subject List

  // String url =
  //     'https://app.healthcrad.com/api/index.php/api/Mobile_app/medicebyall';
  //
  // Future<List<Subject>> getAllulistList() async {
  //   try {
  //     final response = await http.get(Uri.parse(url));
  //     if (response.statusCode == 200) {
  //       List<Subject> list = parseAgents(response.body);
  //       return list;
  //     } else {
  //       throw Exception('Error');
  //     }
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }

  // static List<Subject> parseAgents(String responseBody) {
  //   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  //   return parsed.map<Subject>((json) => Subject.fromJson(json)).toList();
  // }

  @override
  void initState() {
    super.initState();
    // getAllulistList().then((subjectFromServer) {
    //   setState(() {
    //     ulist = subjectFromServer;
    //     userLists = ulist;
    //   });
    // });
  }
final searching= TextEditingController();
  String search="";
  //Main Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 16,
            color: Colors.white,
          ),
        ),
        //
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Search Medicine",
          style: TextStyle(),
        ),
      ),
      body: Column(
        children: <Widget>[
          //Search Bar to List of typed Subject
          Container(
            padding: EdgeInsets.all(15),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 2),
                      color: Colors.grey.shade600.withOpacity(0.6),
                      spreadRadius: 0,
                      blurRadius: 3)
                ],
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: TextField(
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  suffixIcon: InkWell(
                    child: Icon(Icons.search),
                  ),
                  contentPadding: EdgeInsets.all(15.0),
                  hintText: 'Search ',
                ),
                controller: searching,
                onChanged: (string) {
                  setState(() {
                    search = string;
                  });
                  Searchmedicine();
                  // _debouncer.run(() {
                  //   // setState(() {
                  //   //   userLists = ulist
                  //   //       .where(
                  //   //         (u) => (u.name!.toLowerCase().contains(
                  //   //               string.toLowerCase(),
                  //   //             )),
                  //   //       )
                  //   //       .toList();
                  //   // });
                  // });
                },
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Product>>(
                future: Searchmedicine(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    // final product = snapshot.data![index];
                    return  ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      padding: EdgeInsets.all(5),
                      itemBuilder: (BuildContext context, index) {
                        final product = snapshot.data![index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductInfo(
                                      product: product,
                                    )));
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  ListTile(
                                    leading: Container(
                                        height: 100,
                                        width: 100,
                                        child: Image.network(
                                          "https://app.healthcrad.com/api/uploads/medicine/" +
                                              product.imageUrls.first,
                                          width: 100,
                                        )),
                                    title: Text(
                                      product.name.toString(),
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    subtitle: Text(
                                      "₹ " + product.price.toString() ??
                                          "null",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(child: Text('No data available'));
                  }
                }
            )

          ),
        ],
      ),
    );
  }
  Future<List<Product>> Searchmedicine() async {
    print(search);
    final response = await http.post(
        Uri.parse('https://app.healthcrad.com/api/index.php/api/Mobile_app/medicebyall'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name':search,
      }),
    );
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      print(parsed);
      return List<Product>.from(parsed['data'].map((item) => Product.fromJson(item)));
    }
    else {
      throw Exception('Failed to load products');
    }
  }
}

// class Subject {
//   String? id;
//   String? name;
//   String? category;
//   String? subcategory;
//   String? price;
//   String? discount;
//   String? box;
//   String? sPrice;
//   String? quantity;
//   String? generic;
//   String? company;
//   String? effects;
//   String? eDate;
//   String? addDate;
//   String? hospitalId;
//   String? image;
//   String? discription;
//   String? shopid;
//   String? decriptionRequired;
//   String? coupon;
//   String? discountedAmount;
//   String? status;
//   String? prescription;
//   Subject(
//       {this.id,
//       this.name,
//       this.category,
//       this.subcategory,
//       this.price,
//       this.discount,
//       this.box,
//       this.sPrice,
//       this.quantity,
//       this.generic,
//       this.company,
//       this.effects,
//       this.eDate,
//       this.addDate,
//       this.hospitalId,
//       this.image,
//       this.discription,
//       this.shopid,
//       this.decriptionRequired,
//       this.coupon,
//       this.discountedAmount,
//       this.status,
//       this.prescription,
//       });
//   factory Subject.fromJson(Map<dynamic, dynamic> json) {
//     return Subject(
//       id: json['id'],
//       name: json['name'],
//       category: json['category'],
//       subcategory: json['subcategory'],
//       price: json['price'],
//       discount: json['discount'],
//       box: json['box'],
//       sPrice: json['s_price'],
//       quantity: json['quantity'],
//       generic: json['generic'],
//       company: json['company'],
//       effects: json['effects'],
//       eDate: json['e_date'],
//       addDate: json['add_date'],
//       hospitalId: json['hospital_id'],
//       image: json['image'],
//       discription: json['discription'],
//       shopid: json['shopid'],
//       decriptionRequired: json['decription_required'],
//       coupon: json['coupon'],
//       discountedAmount: json['discounted_amount'],
//       status: json['status'],
//     );
//   }
// }

