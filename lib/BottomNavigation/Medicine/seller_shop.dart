import 'dart:convert';

import 'package:healthcrad_user/BottomNavigation/Medicine/seller_profile.dart';
import 'package:healthcrad_user/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:healthcrad_user/apiconstant.dart';
import 'package:http/http.dart' as http;


class Seller_Shop extends StatefulWidget {
  const Seller_Shop({Key? key}) : super(key: key);

  @override
  State<Seller_Shop> createState() => _Seller_ShopState();
}

class _Seller_ShopState extends State<Seller_Shop> {
  @override
  Widget build(BuildContext context ) {
    return FutureBuilder<List<DAlbum>>(
        future: bow(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ?
         GridView.builder(
          //itemCount: stores.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            childAspectRatio: 0.38,
          ),
          shrinkWrap: true,
           itemCount: snapshot.data!.length,
          padding: EdgeInsets.symmetric(horizontal: 20),
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index){
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SellerProfilePage(profile:snapshot.data![index].profile!, address:snapshot.data![index].address!,img_url:snapshot.data![index].img_url!)));
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          image: NetworkImage("https://flaphealth.foundercodes.com/api/upload/"+'${snapshot.data![index].img_url}'),
                          fit: BoxFit.cover,
                        ),
                      ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    height: 70,
                    width: 160,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('${snapshot.data![index].profile}',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(fontSize: 15, color: black2)),
                        SizedBox(height: 8.0),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Color(0xff999999),
                              size: 12,
                            ),
                            Text(' ' + '${snapshot.data![index].address}',
                                style: Theme.of(context).textTheme.caption!.copyWith(
                                    color: Theme.of(context).disabledColor,
                                    fontSize: 10.0)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ):Center(child: Text("Loading....."));
      }
    );
  }
}
class DAlbum {
  String ?id;
  String ?name;
  String ?address;
  String hospital_id;
  String ?profile;
  String ?img_url;

  DAlbum(this.id,this.name, this.address,this.hospital_id,this.profile, this.img_url);

}
Future<List<DAlbum>> bow() async{
  final response = await http.post(
    Uri.parse(Api.baseurl+'pharmacist'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "hospital_id":"98"
    }),

  );

  var jsond = json.decode(response.body)["data"];
  List<DAlbum> allround = [];

  for (var o in jsond)  {
    DAlbum al = DAlbum(
      o["id"],
      o["name"],
      o["address"],
      o["hospital_id"],
      o["profile"],
      o["img_url"],

    );

    allround.add(al);
  }
  return allround;
}