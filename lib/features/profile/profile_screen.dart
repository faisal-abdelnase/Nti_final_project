import 'package:flutter/material.dart';
import 'package:nti_final_project/core/theme/color_managers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nti_final_project/features/profile/widgets/edit_button.dart';
import 'package:nti_final_project/features/profile/widgets/logout_button.dart';
import 'package:nti_final_project/features/profile/widgets/user_data_row.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 85.r,
                    backgroundImage: AssetImage("assets/images/model.png"),
                  ),
                  Positioned(
                    top: 2,
                    right: 2,
                    child: Container(
                      width: 36.w,
                      height: 36.h,
                      decoration: BoxDecoration(
                        color: ColorManagers.notificationColor,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.edit_rounded,
                          color: Colors.white,
                          size: 24.sp,
                        ),
                        onPressed: () {},
                        splashRadius: 20.r,
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Text(
                'John Lennon',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorManagers.chatsMainTextColor,
                ),
              ),

              SizedBox(height: 20.h),
              UserDataRow(title: "Phone", data: "(+44) 20 1234 5689"),
              SizedBox(height: 16.h),
              UserDataRow(title: "Gender", data: "Male"),
              SizedBox(height: 16.h),
              UserDataRow(title: "Birthday", data: "12/01/1997"),
              SizedBox(height: 16.h),
              UserDataRow(title: "Email", data: "john.lennon@mail.com"),
              SizedBox(height: 16.h),
              EditButton(),
              SizedBox(height: 16.h),
              LogoutButton(),
            ],
          ),
        ),
      ),
    );
  }
}
