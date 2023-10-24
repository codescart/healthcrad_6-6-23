import 'dart:convert';
import 'package:healthcrad_user/apiconstant.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Drop_Area extends StatefulWidget {
  const Drop_Area({Key? key}) : super(key: key);

  @override
  _Drop_AreaState createState() => _Drop_AreaState();
}

class _Drop_AreaState extends State<Drop_Area> {
@override
  void initState() {
  this.country();
    super.initState();
  }

  List country_data = [];
  String ?id ;

  Future<String> country() async {
    final res = await http.get(
        Uri.parse(Api.baseurl+'zone'));
    final resBody = json.decode(res.body)['country'];
    setState(() {
      country_data = resBody;
    });



    return "Sucess";
  }




@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Select',
            suffixIcon: DropdownButtonHideUnderline(
              child: DropdownButton(
                items: country_data.map((item) {
                  return DropdownMenuItem(
                      child:  Text(
                        item['name'].toString()
                        , overflow: TextOverflow.clip,
                        maxLines: 1,
                        softWrap: false,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: Colors.black
                        ),
                        textAlign: TextAlign.right,
                      ),
                      value: item['id'].toString()
                  );
                }).toList(),
                onChanged: (value) async {
                  setState(() {
                    id = value as String ;

                  }
                  );

                },
                value: id,
              ),
            ),
          ),

        ),
      ),
    );
  }
}
