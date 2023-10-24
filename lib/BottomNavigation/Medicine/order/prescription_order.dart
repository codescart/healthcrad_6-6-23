import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:healthcrad_user/BottomNavigation/Medicine/order/prescription_summry.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class prescription_upload extends StatefulWidget {
  const prescription_upload({Key? key}) : super(key: key);

  @override
  State<prescription_upload> createState() => _prescription_uploadState();
}


class _prescription_uploadState extends State<prescription_upload> {
  File? file;
  final picker = ImagePicker();

  void _choose() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera, imageQuality: 50, maxHeight: 500, maxWidth: 500);
    setState(() {
      if (pickedFile != null) {
        file = File(pickedFile.path);
        Fluttertoast.showToast(
            msg: "prescription uoloaded successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>prescription_summry(
        )));

      } else {
      }
    });
  }

  File? filee;
  final pickers = ImagePicker();

  void _choosee() async {
    final pickedFile = await pickers.pickImage(source: ImageSource.gallery, imageQuality: 50, maxHeight: 500, maxWidth: 500);
    setState(() {
      if (pickedFile != null) {
        filee = File(pickedFile.path);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>prescription_summry()));
      } else {
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
     appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.chevron_left, color: Colors.white,)),
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Order by Prescription",
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontSize: 19, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Container(),
            file == null
                ? InkWell(
              onTap: () {
                _choose();
              },
              child: Container(
                height: 60,
                width:MediaQuery.of(context).size.width/1.5,
                decoration: BoxDecoration(
                  border: Border.all(width: 0.1,color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.greenAccent.withOpacity(0.1),
                ),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 8),
                    Icon(Icons.camera_alt,color: Colors.grey,size: 40,),
                    SizedBox(width: 10,),
                    Text("Open Camera",style: TextStyle(color: Colors.grey,fontSize: 22,fontWeight: FontWeight.bold,fontFamily: "Proxima Nova"),)
                  ],
                ),
              ),
            )
                :  InkWell(
              onTap: (){
                _choose();
              },
              child: Container(
                height: 60,
                // width:MediaQuery.of(context).size.width/1.5,
                decoration: BoxDecoration(
                  border: Border.all(width: 0.1,color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.greenAccent.withOpacity(0.1),
                ),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 8),
                    Icon(Icons.camera,color: Colors.grey,),
                    SizedBox(width: 10,),
                    Text("Prescription uploaded successfully",style: TextStyle(color: Colors.grey,fontSize: 18,fontWeight: FontWeight.bold,fontFamily: "Proxima Nova"),),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(Icons.verified , color: Colors.green,),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 40,),
            filee == null
                ? InkWell(
              onTap: () {
                _choosee();
              },
              child: Container(
                height: 60,
                width:MediaQuery.of(context).size.width/1.5,
                decoration: BoxDecoration(
                  border: Border.all(width: 0.1,color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.greenAccent.withOpacity(0.1),
                ),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 8),
                    Icon(Icons.camera_alt,color: Colors.grey,size: 40,),
                    SizedBox(width: 10,),
                    Text("Choose from gallery",style: TextStyle(color: Colors.grey,fontSize: 22,fontWeight: FontWeight.bold,fontFamily: "Proxima Nova"),)
                  ],
                ),
              ),
            )
                :  InkWell(
              onTap: (){
                _choosee();
              },
              child: Container(
                height: 60,
                // width:MediaQuery.of(context).size.width/1.5,
                decoration: BoxDecoration(
                  border: Border.all(width: 0.1,color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.greenAccent.withOpacity(0.1),
                ),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 8),
                    Icon(Icons.camera,color: Colors.grey,),
                    SizedBox(width: 10,),
                    Text("Prescription uploaded successfully",style: TextStyle(color: Colors.grey,fontSize: 18,fontWeight: FontWeight.bold,fontFamily: "Proxima Nova"),),
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
    ));
  }
}


