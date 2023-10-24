import 'package:healthcrad_user/BottomNavigation/Medicine/my_cart.dart';
import 'package:flutter/material.dart';
import 'package:healthcrad_user/Routes/routes.dart';

class CustomAddItemButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CartPage()));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
          color: Theme.of(context).primaryColor,
        ),
        height: 30,
        width: 30,
        child: Icon(
          Icons.add,
          size: 22,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
      ),
    );
  }
}
