import 'package:flutter/material.dart';
import 'package:nti_final_project/core/theme/color_managers.dart';

class CustomButton extends StatelessWidget {
  final String name;
  final Function()? onTap;
  const CustomButton({required this.name , required this.onTap,super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManagers.secondryColor,
          padding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        ),
        onPressed: onTap,
        child: Center(
          child: Text(
            name,
            style: TextStyle(fontSize: 28, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
