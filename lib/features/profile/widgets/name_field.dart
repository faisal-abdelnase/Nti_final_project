import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nti_final_project/core/theme/color_managers.dart';

class NameField extends StatelessWidget {
  final TextEditingController nameController;
  const NameField({super.key, required this.nameController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Name',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
            color: ColorManagers.chatsTimeColor,
          ),
        ),

        SizedBox(height: 8.h),
        SizedBox(
          width: 345.w,
          height: 56.h,
          child: TextFormField(
            controller: nameController,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            maxLines: 1,
            textAlignVertical: TextAlignVertical.center,
            style: TextStyle(fontSize: 14.sp),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 18.h,
              ),
              hintText: 'Enter your name',
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
            ),
          ),
        ),
      ],
    );
  }
}
