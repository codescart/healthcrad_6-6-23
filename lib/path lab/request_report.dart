import 'dart:io';
import 'package:healthcrad_user/path%20lab/report_request_done.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:healthcrad_user/Components/custom_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class passient_detail extends StatefulWidget {
  const passient_detail({Key? key}) : super(key: key);

  @override
  State<passient_detail> createState() => _passient_detailState();
}

class _passient_detailState extends State<passient_detail> {


  TextEditingController _pathlabname=TextEditingController();
  TextEditingController _pathlabaddress=TextEditingController();
  TextEditingController _patientname=TextEditingController();
  TextEditingController _patientage=TextEditingController();
  TextEditingController _refferdby=TextEditingController();
  TextEditingController _testdate=TextEditingController();
  TextEditingController _phoneno=TextEditingController();
  TextEditingController _testpayment=TextEditingController();

  var _selectedRadio;
  void _handleRadioValueChange(var value) {
    setState(() {
      _selectedRadio = value;
    });
  }
  void initState() {
    _selectedRadio = 1;
    super.initState();
  }


  File? file;
  final picker = ImagePicker();

  void _choose() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 50, maxHeight: 500, maxWidth: 500);
    setState(() {
      if (pickedFile != null) {
        file = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:  AppBar(
          toolbarHeight: 70,
          flexibleSpace: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 0.5, color: Colors.black26)
                  )
              ),
              padding: EdgeInsets.only(top:5, left: 5, right: 5, bottom: 0),
             child:Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                              padding: EdgeInsets.only(left: 5, right: 5),
                              width:70,
                              child: Image.asset("assets/doctor_logo.png")),
                          Container(
                            height: 50,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("HealthCrad",  style: TextStyle(fontSize: 23, color: Color(0xff000000), fontWeight: FontWeight.w700,),),
                                Text("Save More, Serve More",  style: TextStyle(fontSize: 11, color: Color(0xff000000), fontWeight: FontWeight.bold,),),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child:Row(
                          children: [
                            IconButton(onPressed: (){}, icon: Icon(Icons.shopping_cart_outlined, color: Color(0xff000000),size: 30,)),
                            IconButton(onPressed: (){}, icon: Icon(Icons.notifications_none_outlined, color: Color(0xff000000),size: 30,))
                          ],
                        ) ,
                      )
                    ],
                  ),
                ],
              )
          ) ,
          titleSpacing: 20,
          automaticallyImplyLeading: false,
        ),
        body: Container(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
              Container(
              height: 50, width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 1, color: Colors.black.withOpacity(0.5)
                  ),
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(10)
              ),
               child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Request a report", style:TextStyle(fontSize: 25, ),),
                  Icon(Icons.arrow_drop_down, size: 50, color: Theme.of(context).primaryColor,)
                ],
              ),
            ),
                SizedBox(height: 20,),
                Container(
                  height: MediaQuery.of(context).size.height/1.8,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 1, color: Colors.black.withOpacity(0.5)
                      ),
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.only(left: 5, right: 5, top: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Container( width:MediaQuery.of(context).size.width/3.3,
                                  child: Text("Test Recipt: ", style: TextStyle(fontSize: 17),)),
                            file == null
                                ? InkWell(
                                onTap: () {
                                 _choose();
                                },
                                 child: Container(
                                height: 40,
                                width:MediaQuery.of(context).size.width/1.7,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 0.1,color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.greenAccent.withOpacity(0.1),
                                ),
                                child:  Row(
                                  children: [
                                    SizedBox(width: 8),
                                    Icon(Icons.camera,color: Colors.grey,),
                                    SizedBox(width: 10,),
                                    Text("Attach Test recipt (if any)",style: TextStyle(color: Colors.grey,fontSize: 13,fontWeight: FontWeight.bold,fontFamily: "Proxima Nova"),)
                                    ],
                                   ),
                                 ),
                                )
                                :  InkWell(
                                onTap: (){
                                 _choose();
                                },
                                 child: Container(
                                  height: 40,
                                  width:MediaQuery.of(context).size.width/1.7,
                                  decoration: BoxDecoration(
                                  border: Border.all(width: 0.1,color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.greenAccent.withOpacity(0.1),
                                  ),
                                  child:  Row(
                                  children: [
                                    SizedBox(width: 8),
                                    Icon(Icons.camera,color: Colors.grey,),
                                    SizedBox(width: 10,),
                                    Text("Test recipt Uploaded",style: TextStyle(color: Colors.grey,fontSize: 10,fontWeight: FontWeight.bold,fontFamily: "Proxima Nova"),),
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Icon(Icons.verified , color: Colors.green,),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container( width:MediaQuery.of(context).size.width/3.3,
                                child: Text("PathLab's Name: ", style: TextStyle(fontSize: 15),)),
                            Container(height: 40,
                                width:MediaQuery.of(context).size.width/1.7,
                                alignment: Alignment.bottomCenter,
                                child: TextField(
                                  controller: _pathlabname,
                                  textAlignVertical: TextAlignVertical.center,
                                )),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container( width:MediaQuery.of(context).size.width/3.3,
                                child: Text("PathLab's Add: ", style: TextStyle(fontSize: 15),)),
                            Container(height: 40,
                                width:MediaQuery.of(context).size.width/1.7,
                                alignment: Alignment.bottomCenter,
                                child: TextField(
                                  controller: _pathlabaddress,
                                  textAlignVertical: TextAlignVertical.center,
                                )),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container( width:MediaQuery.of(context).size.width/3.3,
                                child: Text("Patient Name: ", style: TextStyle(fontSize: 15),)),
                            Container(
                                height: 40,
                                width:MediaQuery.of(context).size.width/1.7,
                                alignment: Alignment.bottomCenter,
                                child: TextField(
                                  style: TextStyle(),
                                  controller: _patientname,
                                  textAlignVertical: TextAlignVertical.center,
                                )),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container( width:MediaQuery.of(context).size.width/3.3,
                                child: Text("Patient Age: ", style: TextStyle(fontSize: 15),)),
                            Container(height: 40,
                                width:MediaQuery.of(context).size.width/1.7,
                                alignment: Alignment.bottomCenter,
                                child: TextField(
                                  controller: _patientage,
                                  textAlignVertical: TextAlignVertical.center,
                                )),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container( width:MediaQuery.of(context).size.width/3.3,
                                child: Text("Referred by: ", style: TextStyle(fontSize: 15),)),
                            Container(height: 40,
                                width:MediaQuery.of(context).size.width/1.7,
                                alignment: Alignment.bottomCenter,
                                child: TextField(
                                  controller: _refferdby,
                                  textAlignVertical: TextAlignVertical.center,
                                )),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container( width:MediaQuery.of(context).size.width/3.3,
                                child: Text("Test's Date: ", style: TextStyle(fontSize: 15),)),
                            Container(height: 40,
                                width:MediaQuery.of(context).size.width/1.7,
                                alignment: Alignment.bottomCenter,
                                child: TextField(
                                  controller: _testdate,
                                  textAlignVertical: TextAlignVertical.center,
                                )),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container( width:MediaQuery.of(context).size.width/3.3,
                                child: Text("Phone No: ", style: TextStyle(fontSize: 15),)),
                            Container(height: 40,
                                width:MediaQuery.of(context).size.width/1.7,
                                alignment: Alignment.bottomCenter,
                                child: TextField(
                                  controller: _phoneno,
                                  textAlignVertical: TextAlignVertical.center,
                                )),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container( width:MediaQuery.of(context).size.width/3.3,
                                child: Text("Test's Payment: ", style: TextStyle(fontSize: 15),)),
                            Container(height: 40,
                                width:MediaQuery.of(context).size.width/1.7,
                                alignment: Alignment.bottomCenter,
                                child:Row(
                                            children: [
                                              Radio(
                                                activeColor: Theme.of(context).primaryColor,
                                                value: 0,
                                                groupValue: _selectedRadio,
                                                onChanged: _handleRadioValueChange,
                                              ),
                                              Text("Paid", style: TextStyle(fontSize: 15, color:_selectedRadio==0?Theme.of(context).primaryColor:Colors.black),),
                                              Spacer(),
                                              Radio(
                                                activeColor: Theme.of(context).primaryColor,
                                                value: 1,
                                                groupValue: _selectedRadio,
                                                onChanged: _handleRadioValueChange,
                                              ),
                                              Text("Un Paid", style: TextStyle(fontSize: 15, color:_selectedRadio==1?Theme.of(context).primaryColor:Colors.black),),
                                            ],
                                          ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: CustomButton(
                    label: "Request Report",
                      onTap: () {
                        if (_pathlabname.text.isNotEmpty ||
                            _pathlabaddress.text.isNotEmpty ||
                            _patientname.text.isNotEmpty ||
                            _patientage.text.isNotEmpty ||
                            _refferdby.text.isNotEmpty ||
                            _testdate.text.isNotEmpty ||
                            _phoneno.text.isNotEmpty) {
                          // print(object)
                          uploadImage(
                            _pathlabname.text,
                            _pathlabaddress.text,
                            _patientname.text,
                            _patientage.text,
                            _refferdby.text,
                            _testdate.text,
                            _phoneno.text,
                            _testpayment.text,
                          );
                        }
                        else
                          {
                            Fluttertoast.showToast(
                                msg: 'Fill all details ',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                      }
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  uploadImage(String _pathlabname, String _pathlabaddress, String _patientname, String _patientage, String _refferdby, String _testdate,String _phoneno,String _testpayment,) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'user_id';
    final user_id = prefs.getString(key) ?? 0;
    print(file!.path);
    print("ffffffffff");
    var url = Uri.parse('https://app.healthcrad.com/request_report.php');
    var request = http.MultipartRequest('POST', url);
    request.fields["patient_name"]=_patientname;
    request.fields["patient_phone"]=_phoneno;
    request.fields["paymode"]=_selectedRadio.toString();
    request.fields["lab_name"]=_pathlabname;
    request.fields["test_date"]=_testdate;
    request.fields["user_id"]="$user_id";
    request.fields["lab_address"]=_pathlabaddress;
    request.fields["referred_by"]=_refferdby;
    request.fields["age"]=_patientage;
    request.files.add(await http.MultipartFile.fromPath('attach_recipt', file!.path));
    var response = await request.send();
    if (response.statusCode == 200) {
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNavBar()));
      print('Image uploaded successfully');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>request_confirm()));
    }
    else {
      print('Error uploading image: ${response.reasonPhrase}');
      Fluttertoast.showToast(
          msg: 'Name, Phone, Profile image is required',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.transparent,
          textColor: Colors.red,
          fontSize: 16.0);
    }
  }


}
