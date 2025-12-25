import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopAppBarSearchContent extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onClosePressed;

  const TopAppBarSearchContent({
    super.key,
    required this.controller,
    required this.onClosePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      key: const ValueKey('search'),
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 16.w),
            height: 42.h,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(21.r),
            ),
            child: Center(
              child: TextField(
                controller: controller,
                autofocus: true,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  height: 1.1,
                ),
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 16.sp,
                  ),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: Colors.white.withValues(alpha: 0.6),
                    size: 24.sp,
                  ),
                  border: InputBorder.none,
                  isCollapsed: true,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 0,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        IconButton(
          onPressed: onClosePressed,
          icon: Icon(Icons.close_rounded, color: Colors.white, size: 24.sp),
          iconSize: 42.w,
          padding: EdgeInsets.zero,
          splashRadius: 24.w,
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(const Color(0x33FFFFFF)),
            shape: WidgetStateProperty.all(const CircleBorder()),
            shadowColor: WidgetStateProperty.all(const Color(0x26000000)),
            elevation: WidgetStateProperty.all(10),
          ),
        ),
        SizedBox(width: 12.w),
      ],
    );
  }
}
