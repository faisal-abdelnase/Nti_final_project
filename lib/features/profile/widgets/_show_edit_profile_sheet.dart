import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nti_final_project/core/theme/color_managers.dart';
import 'package:nti_final_project/features/profile/widgets/name_field.dart';
import 'package:nti_final_project/features/profile/widgets/phone_number_field.dart';
import 'package:nti_final_project/features/profile/widgets/gender_selection_field.dart';
import 'package:nti_final_project/features/profile/widgets/birthday_field.dart';
import 'package:nti_final_project/features/profile/widgets/email_field.dart';
import 'package:nti_final_project/features/profile/widgets/save_button.dart';

void showEditProfileSheet(BuildContext context) {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    return null;
  }

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15.r),
        topRight: Radius.circular(15.r),
      ),
    ),
    builder: (context) {
      final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
      return SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.only(bottom: bottomInset),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(24.w, 10.h, 24.w, 4.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 61.3.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: Color(0x33000000),
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                  SizedBox(height: 32.h),
                  Text(
                    "Edit Profile",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  SizedBox(height: 16.h),
                  NameField(nameController: nameController),
                  SizedBox(height: 16.h),
                  PhoneNumberField(),
                  SizedBox(height: 16.h),
                  GenderSelectionField(),
                  SizedBox(height: 16.h),
                  BirthdayField(),
                  SizedBox(height: 16.h),
                  EmailField(
                    emailController: emailController,
                    validator: validator,
                  ),
                  SizedBox(height: 38.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 160.5.w,
                        height: 60.h,
                        child: ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                ColorManagers.lightblueBackgroundColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: ColorManagers.lightblueTextColor,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      SaveButton(),
                    ],
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
