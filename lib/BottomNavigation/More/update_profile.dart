import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:healthcrad_user/BottomNavigation/more_options.dart';
import 'dart:io';
import 'package:healthcrad_user/Components/custom_button.dart';
import 'package:healthcrad_user/Components/entry_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _emn1 = TextEditingController();
  final TextEditingController _emn2 = TextEditingController();
  final TextEditingController _emn3 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:FadedSlideAnimation(
        SingleChildScrollView(
          child: Column(
            children: [
              Container(height: 45,),
              Container(
                alignment: Alignment.center,
                height: 50, width: MediaQuery.of(context).size.width,
                color:Theme.of(context).primaryColor,
                child: ListTile(
                  leading: IconButton( onPressed: () {
                    Navigator.pop(context);
                  }, icon: Icon(Icons.arrow_back_ios, size: 18, color: Colors.white,),),
                    title: Center(
                      child: Text("Update Account", style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    )
                ),
              ),
              SizedBox(height: 20,),
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  padding: EdgeInsets.only( left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                   Center(
                    child:Stack(
                     children: [
                     file == null?
                     CircleAvatar(
                     radius: 70,
                       backgroundImage: AssetImage("assets/icons/doctor_logo.png"),
                     ):CircleAvatar(radius: 70, backgroundImage: FileImage(file!)),
                     Positioned(
                      right: 0,
                      bottom:0,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(50)
                        ),
                        child: IconButton(
                          onPressed: () {
                            _choose();
                          },
                          icon: Icon(Icons.camera_alt,size: 25,color: Theme.of(context).primaryColor,),
                         ))),
                        ],
                         ),),
                      SizedBox(height: 50.0),
                      EntryField(
                        controller: _name,
                        prefixIcon: Icons.person,
                        hint: "Enter Patent name",
                      ),
                      SizedBox(height: 10.0),
                      EntryField(
                        enabled: false,
                        controller: _phone,
                        prefixIcon: Icons.phone_android,
                        hint: "Enter your Mobile No",
                      ),
                      SizedBox(height: 10.0),
                      EntryField(
                        controller: _email,
                        prefixIcon: Icons.email,
                        hint: "Enter your Email",
                      ),
                      SizedBox(height: 10.0),
                      Divider(thickness: 2,),
                      SizedBox(height: 10.0),
                      EntryField(
                        controller: _emn1,
                        hint: "Emergency Mobile No",
                      ),
                      SizedBox(height: 10,),
                      EntryField(
                        controller: _emn2,
                        hint: "Emergency Mobile No",
                      ),
                      SizedBox(height: 10.0),
                      EntryField(
                        controller: _emn3,
                        hint: "Emergency Mobile No",
                      ),
                      SizedBox(height:20,),
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(height: 20.0),
                      CustomButton(onTap: () {
                        uploadImage(_name.text,  _phone.text,  _email.text,  _emn1.text,  _emn2.text,  _emn3.text);
                      },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
  File? file;
  final picker = ImagePicker();

  void _choose() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: 500,
        maxWidth: 500);
    setState(() {
      if (pickedFile != null) {
        file = File(pickedFile.path);
      } else {
      }
    });
  }
  uploadImage(String _name, String _phone, String _email, String _emn1, String _emn2, String _emn3) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'user_id';
    final user_id = prefs.getString(key) ?? 0;
    var url = Uri.parse('https://app.healthcrad.com/api/index.php/api/Mobile_app/update_images');
    var request = http.MultipartRequest('POST', url);
    request.fields["id"]="$user_id";
    request.fields["username"]=_name;
    request.fields["phone"]=_phone;
    request.fields["email"]=_email;
    request.fields["emergency_mobile_no_1"]=_emn1;
    request.fields["emergency_mobile_no_2"]=_emn2;
    request.fields["emergency_mobile_no_3"]=_emn3;
    file!=null?
    request.files.add(await http.MultipartFile.fromPath('image', file!.path)):"";
    var response = await request.send();
    if (response.statusCode == 200) {
      print('Profile updated successfully');
      Fluttertoast.showToast(
          msg: 'Profile updated successfully ',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.transparent,
          textColor: Colors.green,
          fontSize: 16.0);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MoreOptions()));

    }
    else {
      print('Error uploading image: ${response.reasonPhrase}');
      Fluttertoast.showToast(
          msg: 'Must be fill all required details ',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.red,
          fontSize: 16.0);
    }
  }

}
