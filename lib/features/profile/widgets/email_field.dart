import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nti_final_project/core/theme/color_managers.dart';

class EmailField extends StatelessWidget {
  final TextEditingController emailController;
  final String? Function(String?)? validator;
  const EmailField({
    super.key,
    required this.emailController,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
            color: ColorManagers.chatsTimeColor,
          ),
        ),

        SizedBox(height: 8.h),
        TextFormField(
          controller: emailController,
          validator: validator,
          keyboardType: TextInputType.emailAddress,
          textCapitalization: TextCapitalization.none,
          style: TextStyle(fontSize: 14.sp),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 18.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFFD0D1DB)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFFD0D1DB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: ColorManagers.notificationColor),
            ),
            hintText: 'Enter your email',
          ),
        ),
      ],
    );
  }
}
