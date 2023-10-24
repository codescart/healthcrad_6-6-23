import 'dart:convert';
import 'dart:io';
import 'package:healthcrad_user/BottomNavigation/bottom_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:healthcrad_user/BottomNavigation/Medicine/order_payment.dart';
import 'package:healthcrad_user/Components/custom_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class prescription_summry extends StatefulWidget {

  @override
  State<prescription_summry> createState() => _prescription_summryState();
}

class _prescription_summryState extends State<prescription_summry> {
  File? file;
  final picker = ImagePicker();

  void _choose() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery,
        imageQuality: 100,
        // maxHeight: 500,
        // maxWidth: 500
    );
    setState(() {
      if (pickedFile != null) {
        file = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void _choosee() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera,
        imageQuality: 90,
        // maxHeight: 500,
        // maxWidth: 500);
    );
    setState(() {
      if (pickedFile != null) {
        file = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  final TextEditingController _pinconde = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _landmark = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _mssg = TextEditingController();

  @override
  void dispose() {
    _pinconde.dispose();
    _city.dispose();
    _name.dispose();
    _address.dispose();
    _landmark.dispose();
    _phone.dispose();
    _mssg.dispose();
    super.dispose();
  }
var address_type;

  var selectedIndex;
  var name;
  var address;
  var landmark;
  var city;
  var pincode;
  var phone;
  @override
  Widget build(BuildContext context) {

    return SafeArea(child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.chevron_left, color: Colors.white,)),
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        title: Text(
          "Order Summary",
          style: Theme
              .of(context)
              .textTheme
              .bodyText2!
              .copyWith(
              fontSize: 19, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        // padding: EdgeInsets.only(left: 5, right: 5, top: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.only(left: 5, right: 5, top: 15),
                alignment: Alignment.centerLeft,
                child: Text("Upload Prescription ", style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 20),),
              ),
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    file == null ? Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Theme
                              .of(context)
                              .primaryColor,
                          border: Border.all(
                              width: 1, color: Colors.black
                          ),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Text("choose file to view", style: TextStyle(
                          fontSize: 13, color: Colors.white),),
                    ) :
                    Container(
                      height: 180, width: 180,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: Colors.black
                          ),
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(image: FileImage(file!),
                              fit: BoxFit.cover
                          )
                      ),
                      // backgroundImage: AssetImage("assets/icons/doctor_logo.png"),
                    ),

                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _choosee();
                          },
                          child: Container(
                            height: 50,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width / 2.8,
                            decoration: BoxDecoration(
                              border: Border.all(width: 0.1, color: Theme
                                  .of(context)
                                  .primaryColor),
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.greenAccent.withOpacity(0.1),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: 8),
                                Icon(Icons.camera_alt, color: Colors.grey,
                                  size: 20,),
                                SizedBox(width: 10,),
                                Text("open Camera", style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Proxima Nova"),)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        GestureDetector(
                          onTap: () {
                            _choose();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(
                              border: Border.all(width: 0.1, color: Theme
                                  .of(context)
                                  .primaryColor),
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.greenAccent.withOpacity(0.1),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.file_open, color: Colors.grey,
                                  size: 25,),
                                SizedBox(width: 10,),
                                Text('Choose file', style: TextStyle(
                                    fontSize: 15, color: Colors.grey),),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //Sized Box(height: 5,),
              Divider(thickness: 1, color: Colors.black,),
              Padding(
                padding:  EdgeInsets.only(left: 10, right: 10, top: 0),
                child:address_type!=true? CustomButton(
                    icon: Icon(Icons.add, color: Theme.of(context).primaryColor),
                    // label: AppLocalizations.of(context)!.addNewAddress,
                    label: "Add New address",
                    textColor: Theme.of(context).primaryColor,
                    color: Theme.of(context).backgroundColor,
                    onTap: () {
                      setState(() {
                        address_type=true;
                      });
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => order_summary(subtotal: widget.subtotal,)));
                    }):
                CustomButton(
                    icon: Icon(Icons.add, color: Theme.of(context).primaryColor),
                    // label: AppLocalizations.of(context)!.addNewAddress,
                    label: "Select from Saved Address",
                    textColor: Theme.of(context).primaryColor,
                    color: Theme.of(context).backgroundColor,
                    onTap: () {
                      setState(() {
                        address_type=false;
                      });
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => order_summary(subtotal: widget.subtotal,)));
                    }),
              ),
              address_type!=true?Container(
                padding: EdgeInsets.only(left: 5, right: 5,top: 5, bottom: 15),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 15),
                      alignment: Alignment.centerLeft,
                      child: Text("Select from Saved Addresses", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Theme.of(context).disabledColor),),
                    ),
                    SizedBox(height: 10,),
                    FutureBuilder<List<Address>>(
                        future: UpcomingAppot(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) print(snapshot.error);
                          return snapshot.hasData
                              ? ListView.builder(
                            physics: BouncingScrollPhysics(),
                              itemCount: snapshot.data!.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.only(top: 6.0),
                                  child: GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        selectedIndex = snapshot.data![index].id;
                                        name = snapshot.data![index].name;
                                        phone = snapshot.data![index].phone;
                                        address = snapshot.data![index].address;
                                        landmark = snapshot.data![index].landmark;
                                        city = snapshot.data![index].city;
                                        pincode = snapshot.data![index].pincode;
                                        phone = snapshot.data![index].phone;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:BorderRadius.circular(5),
                                          border:selectedIndex == snapshot.data![index].id? Border.all(width:2, color: Theme.of(context).primaryColor ):
                                          Border.all(width:1, color: Colors.black26 )
                                      ),
                                      child: ListTile(
                                        tileColor: Colors.white,
                                        contentPadding:
                                        EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                        leading: Column(
                                          children: [
                                            Icon(
                                              Icons.location_city_outlined,
                                              color:selectedIndex == snapshot.data![index].id? Theme
                                                  .of(context)
                                                  .primaryColor:Colors.black54,
                                              size: 24,
                                            ),
                                          ],
                                        ),
                                        title: Text("${snapshot.data![index].name}",
                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .bodyText1!),
                                        subtitle: Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${snapshot.data![index].address}"+" , "+"${snapshot.data![index].city}",
                                                style: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(fontSize: 13, color: Color(0xff666666)),
                                              ),
                                              Text(
                                                "${snapshot.data![index].landmark}"+" , "+"${snapshot.data![index].pincode}",
                                                style: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(fontSize: 13, color: Color(0xff666666)),
                                              ),
                                              Text(
                                                "+91 "+"${snapshot.data![index].phone}",
                                                style: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(fontSize: 13, color: Color(0xff666666)),
                                              ),
                                              // Divider(color:Colors.black26,  thickness: 2,)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }):Text("");
                        })
                  ],
                ),
              ):
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 5, right: 5, top: 0),
                    alignment: Alignment.centerLeft,
                    child: Text("Add Address: ", style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 20),),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 8),
                    margin: EdgeInsets.only(left: 5, right: 5, top: 03),
                    // height: MediaQuery.of(context).size.height/2,
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
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 2.4,
                                child: TextField(
                                  controller: _pinconde,
                                  decoration: InputDecoration(hintText: "Pincode",
                                      hintStyle: TextStyle(fontSize: 15,
                                          color: Colors.grey.withOpacity(0.8),
                                          fontWeight: FontWeight.w400)

                                  ),
                                )),
                            Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 2.4,
                                child: TextField(
                                  controller: _city,
                                  decoration: InputDecoration(
                                      hintText: "City/State",
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
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 1.1,
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
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 1.1,
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
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 1.1,
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
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 1.1,
                                child: TextField(
                                  controller: _phone,
                                  decoration: InputDecoration(hintText: "Phone No",
                                      hintStyle: TextStyle(fontSize: 15,
                                          color: Colors.grey.withOpacity(0.8),
                                          fontWeight: FontWeight.w400)

                                  ),

                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 5, right: 5, top: 10),
                // height: 100,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(8)
                ),
                child: TextField(
                  controller: _mssg,
                  maxLines: 5,
                  minLines: 1,
                  style: TextStyle(fontSize: 15),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      hintText: "If you want to add any additional comments regarding your order,\nPlease write here..",
                      hintStyle: TextStyle(fontSize: 15, color: Colors.grey
                          .withOpacity(0.8), fontWeight: FontWeight.w400)
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 2.5,
                child: CustomButton(
                  onTap: () {
                    if(address_type==true) {
                      if (_name.text.isNotEmpty || _city.text.isNotEmpty ||
                          _address.text.isNotEmpty ||
                          _landmark.text.isNotEmpty ||
                          _pinconde.text.isNotEmpty) {
                        uploadImage(
                            _pinconde.text,
                            _city.text,
                            _name.text,
                            _address.text,
                            _landmark.text,
                            _phone.text,
                            _mssg.text);
                      }
                      else {
                        Fluttertoast.showToast(
                            msg: "fill all details",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    }
                    else{
                      savedadd(_mssg.text);
                    }
                  },
                  radius: 8,
                  label: "Place Order",
                  textSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
  // api for address filled manually..
  uploadImage(String _pinconde, String _city, String _name, String _address, String _landmark, String _phone, String _mssg) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'user_id';
    final user_id = prefs.getString(key) ?? 0;
    var url = Uri.parse('https://app.healthcrad.com/order_prescription.php');
    var request = http.MultipartRequest('POST', url);
    request.fields["pincode"]=_pinconde;
    request.fields["city"]=_city;
    request.fields["name"]=_name;
    request.fields["address"]=_address;
    request.fields["additional_comment"]=_mssg.toString();
    request.fields["landmark"]="$_landmark";
    request.fields["phone"]=_phone;
    request.fields["userid"]="$user_id";


    request.files.add(await http.MultipartFile.fromPath('images', file!.path));
    var response = await request.send();
    if (response.statusCode == 200) {
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNavBar()));
      Fluttertoast.showToast(
          msg: 'Medicine book successfully ',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.transparent,
          textColor: Colors.green,
          fontSize: 16.0);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavigation()));

    }
    else {
      print('Error uploading image: ${response.reasonPhrase}');
      Fluttertoast.showToast(
          msg: 'Must be fill all required details ',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.transparent,
          textColor: Colors.red,
          fontSize: 16.0);
    }
  }

  //api for select address from the list..
  savedadd(String _mssg) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'user_id';
    final user_id = prefs.getString(key) ?? 0;
    var url = Uri.parse('https://app.healthcrad.com/order_prescription.php');
    var request = http.MultipartRequest('POST', url);
    request.fields["pincode"]=pincode;
    request.fields["city"]=city;
    request.fields["name"]=name;
    request.fields["address"]=address;
    request.fields["additional_comment"]=_mssg;
    request.fields["landmark"]="$landmark";
    request.fields["phone"]=phone;
    request.fields["userid"]="$user_id";

    request.files.add(await http.MultipartFile.fromPath('images', file!.path));
    var response = await request.send();
    if (response.statusCode == 200) {
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNavBar()));
      Fluttertoast.showToast(
          msg: 'Medicine book successfully ',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.transparent,
          textColor: Colors.green,
          fontSize: 16.0);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavigation()));

    }
    else {
      print('Error uploading image: ${response.reasonPhrase}');
      Fluttertoast.showToast(
          msg: 'Must be fill all required details ',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.transparent,
          textColor: Colors.red,
          fontSize: 16.0);
    }
  }



  // list api for saved address view
  Future<List<Address>> UpcomingAppot() async{
    final prefs = await SharedPreferences.getInstance();
    final key = 'user_id';
    final user_id = prefs.getString(key) ?? 0;
    final response = await http.post(
      Uri.parse('https://app.healthcrad.com/api/index.php/api/Mobile_app/get_addresss?user_id=$user_id'),
    );

    var jsond = json.decode(response.body)["data"];

    List<Address> allround = [];
    for (var o in jsond)  {
      Address al = Address(
        o["id"],
        o["user_id"],
        o["pincode"],
        o["city"],
        o["name"],
        o["address"],
        o["landmark"],
        o["phone"],
      );

      allround.add(al);
    }
    return allround;
  }

}
class Address{
  String? id;
  String? user_id;
  String? pincode;
  String? city;
  String? name;
  String? address;
  String? landmark;
  String? phone;

  Address(
      this.id,
      this.user_id,
      this.pincode,
      this.city,
      this.name,
      this.address,
      this.landmark,
      this.phone
      );
}
