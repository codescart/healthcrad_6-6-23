 import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:healthcrad_user/BottomNavigation/More/update_profile.dart';
import 'package:healthcrad_user/Components/custom_button.dart';

class profile_view extends StatefulWidget {
  final String Name;
  final String Phone;
  final String Email;
  final String Image;
  final String em_no1;
  final String em_no2;
  final String em_no3;
  profile_view({required this.Name, required this.Phone, required this.Email, required this.Image, required this.em_no1, required this.em_no2, required this.em_no3});
  @override
  _profile_viewState createState() => _profile_viewState();
}

class _profile_viewState extends State<profile_view> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.chevron_left,color: Colors.grey,)),
          centerTitle: true,
          title: Text( "View Account",
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
          ),
          textTheme: Theme.of(context).textTheme,
        ),
        body: FadedSlideAnimation(
          Stack(
            children: [
              ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  Center(child:
                  Stack(
                    children: [
                      widget.Image==null?CircleAvatar(
                          radius: 70,
                          backgroundImage: AssetImage("assets/icons/doctor_logo.png")):CircleAvatar(
                          radius: 70,
                          backgroundImage: NetworkImage("https://app.healthcrad.com/api/uploads/"+widget.Image)),
                    ],
                  ),
                  ),
                  SizedBox(height: 10,),
                  Divider(
                    thickness: 3,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                    child: Column(
                      children: [
                        Container(
                          // height: 40,
                          decoration: BoxDecoration(
                            color: Theme.of(context).backgroundColor,
                            borderRadius:BorderRadius.circular(12),
                          ),
                          alignment: Alignment.topLeft,
                          child:
                          ListTile(
                            leading:Icon(Icons.account_circle,color: Theme.of(context).primaryColor,),
                            title: Text(widget.Name),
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          // height: 40,
                          decoration: BoxDecoration(
                            color: Theme.of(context).backgroundColor,
                            borderRadius:BorderRadius.circular(12),
                          ),
                          alignment: Alignment.topLeft,
                          child:
                          ListTile(
                            leading:Icon(Icons.phone_iphone,color: Theme.of(context).primaryColor,),
                            title: Text("+91  "+widget.Phone??""),
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          // height: 40,
                          decoration: BoxDecoration(
                            color: Theme.of(context).backgroundColor,
                            borderRadius:BorderRadius.circular(12),
                          ),
                          alignment: Alignment.topLeft,
                          child:
                          ListTile(
                            leading:Icon(Icons.mail,color: Theme.of(context).primaryColor,),
                            title:Text(widget.Email==null?"hii":widget.Email),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(thickness: 2),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: SizedBox(
                      child: Text("Emergency Contact Numbers"),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Padding(padding: EdgeInsets.only(left: 20, right: 20,),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                          borderRadius:BorderRadius.circular(12),
                        ),
                        alignment: Alignment.topLeft,
                        child:
                        ListTile(
                          leading:Icon(Icons.phone_iphone,color: Theme.of(context).primaryColor,),
                          title: widget.em_no1=="null"?Text("Update Contect"):Text("+91 "+widget.em_no1),
                        ),
                      ),
                      SizedBox(height: 5,),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                          borderRadius:BorderRadius.circular(12),
                        ),
                        alignment: Alignment.topLeft,
                        child:
                        ListTile(
                          leading:Icon(Icons.phone_iphone,color: Theme.of(context).primaryColor,),
                          title: widget.em_no2==null?Text("Update Contect"):Text("+91 "+widget.em_no2),
                        ),
                      ),
                      SizedBox(height: 5,),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                          borderRadius:BorderRadius.circular(12),
                        ),
                        alignment: Alignment.topLeft,
                        child:
                        ListTile(
                          leading:Icon(Icons.phone_iphone,color: Theme.of(context).primaryColor,),
                          title: widget.em_no3==null?Text("Update Contect"):Text("+91 "+widget.em_no3)
                        ),
                      ),
                    ],
                  ),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child:CustomButton(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()));
                  },
                  label: 'Edit Profile',
                ),
              ),
            ],
          ),
          beginOffset: Offset(0, 0.3),
          endOffset: Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
        ));
  }

}




