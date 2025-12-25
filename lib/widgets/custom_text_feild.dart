import 'package:flutter/material.dart';
import 'package:nti_final_project/core/theme/color_managers.dart';
import 'package:nti_final_project/core/theme/style_managers.dart';

class CustomTextFeild extends StatelessWidget {
  final String text;
  final IconData iconData;
  final IconData? icon;
  final TextEditingController textEditingController;
  const CustomTextFeild({
    this.icon,
    required this.text,
    required this.iconData,
    required this.textEditingController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        style: StyleManagers.font16BlackBlue700.copyWith(fontSize: 23),
        controller: textEditingController,
        decoration: InputDecoration(
          prefixIcon: Icon(iconData, size: 25, color: ColorManagers.blackColor,),
          suffixIcon: Icon(icon),
          hintText: text,
          hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 24),
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(
            color: ColorManagers.secondryColor, width: 2.7)),
          border: UnderlineInputBorder(borderSide: BorderSide(
            color: ColorManagers.blackColor, width: 2.5)),
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(
            color: ColorManagers.blackColor, width: 2.5)),
          disabledBorder: UnderlineInputBorder(borderSide: BorderSide(
            color: ColorManagers.blackColor, width: 2.5)),    
        ),
      ),
    );
  }
}
