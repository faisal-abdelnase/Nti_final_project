import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nti_final_project/core/theme/color_managers.dart';
import 'package:nti_final_project/features/profile/models/country_model.dart';

class PhoneNumberField extends StatefulWidget {
  const PhoneNumberField({super.key});

  @override
  State<PhoneNumberField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  Country selectedCountry = countries.first;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Phone Number',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
            color: ColorManagers.chatsTimeColor,
          ),
        ),
        SizedBox(height: 8.h),

        SizedBox(
          height: 56.h,
          width: 345.w,
          child: TextFormField(
            keyboardType: TextInputType.phone,
            style: TextStyle(fontSize: 14.sp),
            decoration: InputDecoration(
              hintText: 'Enter phone number',
              contentPadding: EdgeInsets.symmetric(
                vertical: 18.h,
                horizontal: 12.w,
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
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 12.w, right: 8.w),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<Country>(
                    dropdownColor: ColorManagers.lightblueBackgroundColor,
                    value: selectedCountry,
                    onChanged: (value) {
                      if (value != null)
                        setState(() => selectedCountry = value);
                    },
                    items: countries.map((country) {
                      return DropdownMenuItem(
                        value: country,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              country.flag,
                              style: TextStyle(fontSize: 18.sp),
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              country.dialCode,
                              style: TextStyle(fontSize: 14.sp),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
