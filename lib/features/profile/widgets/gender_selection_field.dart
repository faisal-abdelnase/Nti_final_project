import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nti_final_project/core/theme/color_managers.dart';

class GenderSelectionField extends StatefulWidget {
  const GenderSelectionField({super.key});

  @override
  State<GenderSelectionField> createState() => _GenderSelectionFieldState();
}

class _GenderSelectionFieldState extends State<GenderSelectionField> {
  String selectedGender = 'Male';
  final List<String> genders = ['Male', 'Female'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gender',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
            color: ColorManagers.chatsTimeColor,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          height: 56.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFD0D1DB)),
            borderRadius: BorderRadius.circular(8.r),
          ),

          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedGender,
              isExpanded: true,
              onChanged: (value) {
                if (value != null) {
                  setState(() => selectedGender = value);
                }
              },
              dropdownColor: ColorManagers.lightblueBackgroundColor,
              items: genders.map((gender) {
                return DropdownMenuItem(
                  value: gender,
                  child: Text(gender, style: TextStyle(fontSize: 14.sp)),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
