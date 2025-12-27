import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nti_final_project/core/theme/color_managers.dart';

class BirthdayField extends StatefulWidget {
  const BirthdayField({super.key});

  @override
  State<BirthdayField> createState() => _BirthdayFieldState();
}

class _BirthdayFieldState extends State<BirthdayField> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Birthday',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
            color: ColorManagers.chatsTimeColor,
          ),
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: selectedDate ?? DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.light(
                      primary: ColorManagers
                          .primaryColor, // header background and other prominent blue
                      onPrimary: Colors.white, // header text color
                      surface: ColorManagers
                          .lightblueBackgroundColor, // picker background
                      onSurface:
                          ColorManagers.primaryColor, // day text when selected
                      secondary: ColorManagers
                          .secondryColor, // not used mostly, but just in case
                    ),
                    dialogTheme: DialogThemeData(
                      backgroundColor: ColorManagers.lightblueBackgroundColor,
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        foregroundColor:
                            ColorManagers.primaryColor, // button text color
                      ),
                    ),
                  ),
                  child: child ?? SizedBox.shrink(),
                );
              },
            );
            if (pickedDate != null) {
              setState(() {
                selectedDate = pickedDate;
              });
            }
          },
          child: Container(
            height: 56.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFD0D1DB)),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    selectedDate != null
                        ? "${selectedDate!.day.toString().padLeft(2, '0')}/"
                              "${selectedDate!.month.toString().padLeft(2, '0')}/"
                              "${selectedDate!.year}"
                        : 'Select your date',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: selectedDate != null ? Colors.black : Colors.grey,
                    ),
                  ),
                ),
                Icon(
                  Icons.calendar_today_outlined,
                  size: 24.sp,
                  color: ColorManagers.chatsTimeColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
