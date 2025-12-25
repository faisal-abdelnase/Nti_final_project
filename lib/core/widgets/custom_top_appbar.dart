import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nti_final_project/core/theme/color_managers.dart';

class CustomTopAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomTopAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(110.h);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.h,
      width: double.infinity,
      child: Stack(
        children: [
          // Base background
          Container(
            height: 110.h,
            width: double.infinity,
            color: ColorManagers.topBarMainColor,
          ),
          // White gradient layer
          Positioned(
            // bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 80.h,
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
          SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: SizedBox(
                height: 75.h,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: 62.h,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(width: 4.w),
                    Image.asset(
                      'assets/images/brand.png',
                      height: 15.h,
                      fit: BoxFit.contain,
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search_rounded),
                      iconSize: 36.sp,
                      color: Colors.white,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add_rounded),
                      iconSize: 36.sp,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
