import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nti_final_project/core/widgets/add_options_popup.dart';

class TopAppBarDefaultContent extends StatelessWidget {
  final VoidCallback onSearchPressed;

  const TopAppBarDefaultContent({super.key, required this.onSearchPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      key: const ValueKey('default'),
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
          onPressed: onSearchPressed,
          icon: const Icon(Icons.search_rounded),
          iconSize: 36.sp,
          color: Colors.white,
        ),
        Builder(
          builder: (buttonContext) => IconButton(
            onPressed: () => addOptionsPopup(buttonContext),
            icon: const Icon(Icons.add_rounded),
            iconSize: 36.sp,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
