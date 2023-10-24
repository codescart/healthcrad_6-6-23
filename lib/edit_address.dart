import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:healthcrad_user/BottomNavigation/More/saved_addresses_page.dart';
import 'package:healthcrad_user/Components/custom_button.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class editSavedAddress extends StatefulWidget {
  final String id;
  final String pincode;
  final String name;
  final String city;
  final String address;
  final String landmark;
  final String phone;
  editSavedAddress( {key, Key, required this.id, required this.pincode, required this.name, required this.city, required this.address, required this.landmark, required this.phone, });

  @override
  State<editSavedAddress> createState() => _editSavedAddressState();
}
class _editSavedAddressState extends State<editSavedAddress> {
  final TextEditingController _pincode=TextEditingController();
  final TextEditingController _city=TextEditingController();
  final TextEditingController _name=TextEditingController();
  final TextEditingController _address=TextEditingController();
  final TextEditingController _landmark=TextEditingController();
  final TextEditingController _phone=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pincode.text= widget.pincode;
    _city.text= widget.city;
    _name.text= widget.name;
    _address.text= widget.address;
    _landmark.text= widget.landmark;
    _phone.text= widget.phone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.chevron_left, color: Colors.white,)),
        centerTitle: true,
        title: Text(
          "Edit Address",
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontSize: 17, fontWeight: FontWeight.w700,color: Colors.white),
        ),
        textTheme: Theme.of(context).textTheme,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                    margin: EdgeInsets.only(left: 5, right: 5, top: 15),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                width:MediaQuery.of(context).size.width/2.4,
                                child: TextField(
                                  controller: _pincode,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(hintText: "Pincode",
                                      hintStyle: TextStyle(fontSize: 15,
                                          color: Colors.grey.withOpacity(0.8),
                                          fontWeight: FontWeight.w400)
                                  ),
                                )),
                            Container(
                                width:MediaQuery.of(context).size.width/2.4,
                                child: TextField(
                                  controller: _city,
                                  decoration: InputDecoration(hintText: "City/State",
                                      hintStyle: TextStyle(fontSize: 15,
                                          color: Colors.grey.withOpacity(0.8),
                                          fontWeight: FontWeight.w400)
                                  ),
                                )),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                                width:MediaQuery.of(context).size.width/1.1,
                                child: TextField(
                                  controller: _name,
                                  decoration: InputDecoration(hintText: "Name",
                                      hintStyle: TextStyle(fontSize: 15,
                                          color: Colors.grey.withOpacity(0.8),
                                          fontWeight: FontWeight.w400)
                                  ),
                                )),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                                width:MediaQuery.of(context).size.width/1.1,
                                child: TextField(
                                  controller: _address,
                                  decoration: InputDecoration(hintText: "Address",
                                      hintStyle: TextStyle(fontSize: 15,
                                          color: Colors.grey.withOpacity(0.8),
                                          fontWeight: FontWeight.w400)
                                  ),
                                )),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                                width:MediaQuery.of(context).size.width/1.1,
                                child: TextField(
                                  controller: _landmark,
                                  decoration: InputDecoration(hintText: "Landmark",
                                      hintStyle: TextStyle(fontSize: 15,
                                          color: Colors.grey.withOpacity(0.8),
                                          fontWeight: FontWeight.w400)
                                  ),
                                )),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                                width:MediaQuery.of(context).size.width/1.1,
                                child: TextField(
                                  controller:_phone,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(hintText: "Phone No",
                                      hintStyle: TextStyle(fontSize: 15, color: Colors.grey.withOpacity(0.8), fontWeight: FontWeight.w400)
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30,),
                  CustomButton(
                    radius: 0,
                    onTap: () {
                      saveAddress(_pincode.text,_city.text,_name.text,_address.text,_landmark.text,_phone.text);
                    },
                    label: "Update address",
                    color: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  saveAddress(String _pincode,String _city,String _name,String _address,String _landmark,String _phone) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'user_id';
    final user_id = prefs.getString(key) ?? 0;
    final response = await http.post(
      Uri.parse(
          "https://app.healthcrad.com/api/index.php/api/Mobile_app/address_update"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "id":widget.id,
        'user_id': "$user_id",
        'pincode': _pincode,
        'city': _city,
        'name': _name,
        'address': _address,
        'landmark': _landmark,
        'phone': _phone
      }),
    );
    final data = jsonDecode(response.body);
    print(data);
    print(user_id);
    print(_pincode);
    print(_city);
    print(_name);
    print(_address);
    print(_landmark);
    print(_phone);

    print("111111111111111");
    if (data['error'] == '200') {
      Fluttertoast.showToast(
          msg: "Address added Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Color(0xffffffff),
          fontSize: 16.0);
      // Navigator.pop(context);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => SavedAddressesPage()));
    } else {
      Fluttertoast.showToast(
          msg: "Something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor:Colors.red,
          textColor: Color(0xffffffff),
          fontSize: 16.0);
    }
  }
}
