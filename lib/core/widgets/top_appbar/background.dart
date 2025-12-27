import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nti_final_project/core/theme/color_managers.dart';

class TopAppBarBackground extends StatelessWidget {
  const TopAppBarBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Base background
        Container(
          height: 100.h,
          width: double.infinity,
          color: ColorManagers.topBarMainColor,
        ),
        // White gradient layer
        Positioned(
          left: 0,
          right: 0,
          child: Container(
            height: 100.h,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [
                  Color.fromARGB(52, 255, 255, 255),
                  Color.fromARGB(0, 255, 255, 255),
                ],
                stops: [0.0, .25],
              ),
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0F000000),
                  offset: Offset(0, 4),
                  blurRadius: 12,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
