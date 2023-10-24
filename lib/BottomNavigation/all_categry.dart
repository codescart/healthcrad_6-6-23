import 'package:flutter/material.dart';
import 'package:healthcrad_user/BottomNavigation/Medicine/allmedi.dart';
import 'package:healthcrad_user/BottomNavigation/doctors_page.dart';
import 'package:healthcrad_user/ambulance/ambulance_booking.dart';
import 'package:healthcrad_user/path%20lab/pathlab_ui.dart';

class categryitem {
  String? title;
  String? image;
  Function onTap;
  categryitem(this.title, this.image,this.onTap);
}

class categry extends StatelessWidget {
  categry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<categryitem> _catitem = [
      categryitem("Ambulance","assets/banners/ambulance.png" ,() {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ambulance_booking(
          fromaddress: '',
          toaddress: '',
          from_lat: '',
          from_lon: '',
          to_lat: '',
          to_lan: '',)));
          }),
      categryitem("Doctor", "assets/banners/doct.png", () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorsHome()));
          }),
      categryitem("Medicines &\nEssentials","assets/banners/med.png", () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Medicinesall()));
          }),
      categryitem("PathLab", "assets/banners/lab.png",() {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>pathlab_ui()));
      }),
    ];
    return ListView.builder(
        itemCount: _catitem.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: _catitem[index].onTap as void Function()?,
            child: Container(
              height: 110,
              width: 100,
              child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 5,left: 5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12,width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Image.asset(_catitem[index].image!,
                          width: 65,
                          height: 65,
                          fit:BoxFit.fill ),
                    ),
                    SizedBox(height: 5,),
                    Container(
                        child: Text(_catitem[index].title!,
                          maxLines: 1,
                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.w100),)
                    ),
                  ]
              ),
            ),
          );
        });
    //   Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //     children: [
    //       GestureDetector(
    //         onTap: (){
    //           Navigator.push(context, MaterialPageRoute(builder: (context)=>ambulance_booking(
    //             fromaddress: '',
    //             toaddress: '',
    //             from_lat: '',
    //             from_lon: '',
    //             to_lat: '',
    //             to_lan: '',)));
    //         },
    //         child: Container(
    //           height: 110,
    //           width: 100,
    //           child: Column(
    //               children: [
    //                 Container(
    //                   padding: EdgeInsets.only(right: 5,left: 5),
    //                   decoration: BoxDecoration(
    //                       border: Border.all(color: Colors.black12,width: 1.0),
    //                       borderRadius: BorderRadius.all(Radius.circular(10))
    //                   ),
    //                   child: Image.asset('assets/banners/ambulance.png',
    //                       width: 65,
    //                       height: 65,
    //                       fit:BoxFit.fill ),
    //                 ),
    //                 SizedBox(height: 5,),
    //                 Container(
    //                     child: Text('Ambulance',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w100),)
    //                 ),
    //               ]
    //           ),
    //         ),
    //       ),
    //       VerticalDivider(
    //         color: Colors.black38,
    //         thickness: 0.5,
    //       ),
    //       GestureDetector(
    //         onTap: (){
    //           Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorsHome()));
    //         },
    //         child: Container(
    //           height: 110,
    //           width: 100,
    //           child: Column(
    //               children: [
    //                 Container(
    //                   padding: EdgeInsets.only(right: 5,left: 5),
    //                   decoration: BoxDecoration(
    //                       border: Border.all(color: Colors.black12,width: 1.0),
    //                       borderRadius: BorderRadius.all(Radius.circular(10))
    //                   ),
    //                   child: Image.asset('assets/banners/doct.png',
    //                       width: 65,
    //                       height: 65,
    //                       fit:BoxFit.fill ),
    //                 ),
    //                 SizedBox(height: 5,),
    //                 Container(
    //                     child: Text('Doctor',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w100),)
    //                 ),
    //               ]
    //           ),
    //         ),
    //       ),
    //       VerticalDivider(
    //         color: Colors.black38,
    //         thickness: 0.5,
    //       ),
    //       GestureDetector(
    //         onTap: (){
    //           Navigator.push(context, MaterialPageRoute(builder: (context)=>Medicinesall()));
    //         },
    //         child: Container(
    //           height: 113,
    //           width: 100,
    //           child: Column(
    //               children: [
    //                 Container(
    //                   padding: EdgeInsets.only(right: 5,left: 5),
    //                   decoration: BoxDecoration(
    //                       border: Border.all(color: Colors.black12,width: 1.0),
    //                       borderRadius: BorderRadius.all(Radius.circular(10))
    //                   ),
    //                   child: Image.asset('assets/banners/med.png',
    //                       width: 65,
    //                       height: 65,
    //                       fit:BoxFit.fill ),
    //                 ),
    //                 SizedBox(height: 5,),
    //                 Container(
    //                     child: Text('Medicines &\nEssentials',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w100, fontSize:13),)
    //                 ),
    //               ]
    //           ),
    //         ),
    //       ),
    //       VerticalDivider(
    //         color: Colors.black38,
    //         thickness: 0.5,
    //       ),
    //       GestureDetector(
    //         onTap: (){
    //           Navigator.push(context, MaterialPageRoute(builder: (context)=>pathlab_ui()));
    //         },
    //         child: Container(
    //           height: 110,
    //           width: 100,
    //           child: Column(
    //               children: [
    //                 Container(
    //                   padding: EdgeInsets.only(right: 5,left: 5),
    //                   decoration: BoxDecoration(
    //                       border: Border.all(color: Colors.black12,width: 1.0),
    //                       borderRadius: BorderRadius.all(Radius.circular(10))
    //                   ),
    //                   child: Image.asset('assets/banners/lab.png',
    //                       width: 65,
    //                       height: 65,
    //                       fit:BoxFit.fill ),
    //                 ),
    //                 SizedBox(height: 5,),
    //                 Container(
    //                     child: Text('PathLab',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w100),)
    //                 ),
    //               ]
    //           ),
    //         ),
    //       ),
    //     ]
    // );
  }
}
