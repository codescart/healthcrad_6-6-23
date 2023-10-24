import 'dart:convert';
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:healthcrad_user/BottomNavigation/Data/category_data_list.dart';
import 'package:healthcrad_user/BottomNavigation/Medicine/medicine_info.dart';
import 'package:healthcrad_user/Locale/locale.dart';
import 'package:flutter/material.dart';
import 'package:healthcrad_user/apiconstant.dart';
import 'package:http/http.dart' as http;

import '../../model/medicine model.dart';

class ShopByCategoryPage extends StatefulWidget {
  @override
  _ShopByCategoryPageState createState() => _ShopByCategoryPageState();
}

class _ShopByCategoryPageState extends State<ShopByCategoryPage> {
  int? _currentIndex;
  var selectedId;
  var selectedname;
  late List<String> subCategories;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    subCategories = getSubcategories(0);
  }

  @override
  Widget build(BuildContext context) {
    late List<String> stringList;

    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          locale.shopByCategory!,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.chevron_left)),
        toolbarTextStyle: Theme.of(context).textTheme.bodyText2,
        titleTextStyle: Theme.of(context).textTheme.headline6,
      ),
      body: Container(
        color: Theme.of(context).dividerColor,
        padding: EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FutureBuilder<List<DAlbum>>(
                future: catogery(),
                builder: (context, snapshot) {
                  return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedId= snapshot.data![index].id.toString();
                              _currentIndex = index;
                              subCategories = getSubcategories(index);

                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: Stack(
                              children: [
                                FadedScaleAnimation(
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      "https://app.healthcrad.com/api/uploads/"+snapshot.data![index].image.toString(),
                                      height: 122,
                                      // width: 100,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                  durationInMilliseconds: 400,
                                ),
                                _currentIndex == index
                                    ? Container(
                                        height: 122,
                                        padding: EdgeInsets.only(bottom: 4),
                                        alignment: Alignment.bottomCenter,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(9),
                                          gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Theme.of(context)
                                                    .scaffoldBackgroundColor
                                                    .withOpacity(0.0),
                                                Theme.of(context)
                                                    .scaffoldBackgroundColor
                                                    .withOpacity(0.6),
                                                Theme.of(context)
                                                    .scaffoldBackgroundColor
                                                    .withOpacity(0.9)
                                              ],
                                              stops: [
                                                0.3,
                                                0.65,
                                                0.9
                                              ]),
                                        ),
                                        child: Icon(Icons.arrow_forward_ios),
                                      )
                                    : SizedBox.shrink(),
                              ],
                            ),
                          ),
                        );
                      });
                }
              ),
            ),
            Expanded(
              flex: 3,
              child:
              FutureBuilder<List<Product>>(
                  future: fetchProducts(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Data not founud'));
                    } else if (snapshot.hasData) {
                      return  GridView.builder(
                          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.75,
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
                                  Container(
                                    // margin: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                    decoration: BoxDecoration(
                                        color: Theme
                                            .of(context)
                                            .scaffoldBackgroundColor,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Stack(
                                          children: [
                                            FadedScaleAnimation(
                                                durationInMilliseconds: 400,
                                                Container(
                                                  height: 80,
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
                                              fontSize: 9.5,
                                              color: Color(0xff5b5b5b),
                                              fontWeight: FontWeight.w600),
                                          maxLines: 1, overflow: TextOverflow.ellipsis,
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
                                  // Align(
                                  //   alignment: Alignment.bottomRight,
                                  //   child: CustomAddItemButton(),
                                  // ),
                                ],
                              ),
                            );
                          }
                      );
                    } else {
                      return Center(child: Text('No data available'));
                    }
                  }
              ),
            )
          ],
        ),
      ),
    );
  }
  // Api for catogery list==============================
  Future<List<DAlbum>> catogery() async{
    final response = await http.get(
      Uri.parse(Api.baseurl+'medicalcategory'),
    );
    var jsond = json.decode(response.body)["data"];
    print(jsond);
    print("jjjjjjjjjjjjjjj");
    List<DAlbum> allround = [];
    for (var o in jsond)  {
      DAlbum al = DAlbum(
        o["id"],
        o["category"],
        o["description"],
        o["hospital_id"],
        o["image"],
      );
      allround.add(al);
    }
    return allround;
  }

  Future<List<Product>> fetchProducts() async {
    final response = await http.post(
      Uri.parse('https://app.healthcrad.com/api/index.php/api/Mobile_app/medicebycategory'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "category": selectedId.toString()
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
//done
// Class for catogery list=====================
class DAlbum {
  String ?id;
  String ?category;
  String ?description;
  String ?hospital_id;
  String ?image;
  DAlbum(
      this.id,
      this.category,
      this.description,
      this.hospital_id,
      this.image
      );
}




