import 'dart:convert';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:healthcrad_user/BottomNavigation/Medicine/medicine_info.dart';
import 'package:healthcrad_user/Components/custom_add_item_button.dart';
import 'package:healthcrad_user/Locale/locale.dart';
import 'package:healthcrad_user/Theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthcrad_user/apiconstant.dart';
import 'package:http/http.dart' as http;

class SellerProfilePage extends StatefulWidget {
  final String profile;
  final String address;
  final String img_url;
  SellerProfilePage({Key? key, required this.profile, required this.address,required this.img_url}) : super(key: key);
  @override
  _SellerProfilePageState createState() => _SellerProfilePageState();
}


class _SellerProfilePageState extends State<SellerProfilePage> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.chevron_left)),
        centerTitle: true,
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 17),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Container(
                    height: 130,
                    width:120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          image: NetworkImage("https://flaphealth.foundercodes.com/api/upload/"+widget.img_url, scale: 3.5),
                          fit: BoxFit.cover,
                        ),
                      ),
                  ),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      width: 160,
                      child: Text(widget.profile,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: black2

                          )),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Color(0xff999999),
                          size: 18,
                        ),
                        Container(
                          width: 164,
                          child: Text(' ' + widget.address,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(
                                      color: lightGreyColor, fontSize: 17)),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
            color: Theme.of(context).backgroundColor,
            child: FutureBuilder<List<DAlbum>>(
                future: bow(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);

                  return snapshot.hasData
                      ? GridView.builder(
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.82,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        // onTap: () {
                        //   Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductInfo(
                        //     effects: snapshot.data![index].effects,
                        //     price: snapshot.data![index].price,
                        //     image: snapshot.data![index].image,
                        //     quantity: snapshot.data![index].quantity,
                        //     name: snapshot.data![index].name,
                        //   )));
                        // },
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).scaffoldBackgroundColor,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                              Container(
                                height:100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft:Radius.circular(10),
                                          topRight: Radius.circular(10)
                                      )),
                                  child: Image.network("https://flaphealth.foundercodes.com/api/upload/"+'${snapshot.data![index].image}',)
                              ),
                                  Container(
                                    padding: EdgeInsets.only(right: 10,left: 10,top: 40),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${snapshot.data![index].name}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                              fontSize: 11.5,
                                              color: Color(0xff5b5b5b),
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          '\₹ ' + '${snapshot.data![index].price}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
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
                    }):Center(child: Text('Loading'));
              }
            ),
          ),
        ],
      ),
    );
  }
}
class DAlbum {
  String id;
  String name;
  String category;
  String price;
  String quantity;
  String image;
  String effects;

  DAlbum(this.id,this.name, this.category,this.price,this.quantity,this.image,this.effects);

}
Future<List<DAlbum>> bow() async{
  final response = await http.post(
    Uri.parse(Api.baseurl+'medicebycategory'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "zone":"98",
      "category":"Med cat"
    }),

  );

  var jsond = json.decode(response.body)["data"];
  List<DAlbum> allround = [];
  for (var o in jsond)  {
    DAlbum al = DAlbum(
      o["id"],
      o["name"],
      o["category"],
      o["price"],
      o["quantity"],
      o["image"],
      o["effects"]
    );

    allround.add(al);
  }
  return allround;
}