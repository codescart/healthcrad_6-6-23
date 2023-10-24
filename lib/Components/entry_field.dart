import 'package:healthcrad_user/Theme/colors.dart';
import 'package:flutter/material.dart';

class EntryField extends StatelessWidget {
  final String? hint;
  final IconData? prefixIcon;
  final Color? color;
  final TextEditingController? controller;
  final String? initialValue;
  final bool? readOnly;
  final TextAlign? textAlign;
  final IconData? suffixIcon;
  final TextInputType? textInputType;
  final String? label;
  final int? maxLines;
  final Function? onTap;
  final IconData? suffix;
  final Function? onChange;
  final bool? enabled;

  EntryField({
    this.hint,
    this.prefixIcon,
    this.color,
    this.controller,
    this.initialValue,
    this.readOnly,
    this.textAlign,
    this.suffixIcon,
    this.textInputType,
    this.label,
    this.maxLines,
    this.onTap,
    this.suffix,
    this.onChange,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        label != null
            ? Text('\n' + label! + '\n',
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(color: Color(0xff808080), fontSize: 15))
            : SizedBox.shrink(),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                enabled: enabled,
                controller: controller,
                initialValue: initialValue,
                readOnly: readOnly ?? false,
                maxLines: maxLines ?? 1,
                textAlign: textAlign ?? TextAlign.left,
                keyboardType: textInputType,
                decoration: InputDecoration(
                  prefixIcon: prefixIcon != null
                      ? Icon(
                          prefixIcon,
                          color: Theme.of(context).primaryColor,
                          size: 18.5,
                        )
                      : null,
                  suffixIcon: IconButton(onPressed: () {  }, icon: Icon(suffixIcon),),
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: textFieldColor, fontSize: 15),
                  hintText: hint,
                  filled: true,
                  fillColor: color ?? Color(0xfff4f7f8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide.none,
                  ),
                ),
                // onTap: onTap as void Function()?,
                // onChanged: onChange as void Function()?,
              ),
            ),
            if (suffix != null)
              GestureDetector(
                onTap: () {},
                child: Container(
                  margin: EdgeInsetsDirectional.only(start: 8),
                  height: 56,
                  width: 56,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Icon(
                    suffix,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              )
          ],
        ),
      ],
    );
  }
}
