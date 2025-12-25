import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nti_final_project/core/theme/color_managers.dart';
import 'package:nti_final_project/features/profile/widgets/_show_edit_profile_sheet.dart';

class EditButton extends StatelessWidget {
  const EditButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 345.w,
      height: 56.h,
      child: ElevatedButton(
        onPressed: () => showEditProfileSheet(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManagers.notificationColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          elevation: 0,
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.edit_outlined, size: 24.sp, color: Colors.white),
            SizedBox(width: 16.w),
            Text(
              'Edit Profile',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
