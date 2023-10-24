import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';

class AddressTypeButton extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final Function? onPressed;
  final bool? isSelected;
  final Color selectedColor = Colors.white;
  final Color unSelectedColor = Colors.black;

  AddressTypeButton({this.label, this.icon, this.onPressed, this.isSelected});

  @override
  Widget build(BuildContext context) {
    return FadedScaleAnimation(
      TextButton.icon(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
          backgroundColor: isSelected!
              ? Theme.of(context).primaryColor
              : Theme.of(context).dividerColor,
        ),
        onPressed: onPressed as void Function()?,
        icon: Icon(
          icon,
          color: isSelected!
              ? Theme.of(context).scaffoldBackgroundColor
              : Theme.of(context).primaryColor,
        ),
        label: Text(
          label!,
          style: TextStyle(
            fontSize: 12,
            color: isSelected! ? selectedColor : unSelectedColor,
          ),
        ),
      ),
      durationInMilliseconds: 400,
    );
  }
}
