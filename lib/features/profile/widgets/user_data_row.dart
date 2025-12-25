import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nti_final_project/core/theme/color_managers.dart';

class UserDataRow extends StatelessWidget {
  final String title;
  final String data;
  const UserDataRow({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "$title : ",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w400,
            color: ColorManagers.chatsSubTextColor,
          ),
        ),

        Expanded(
          child: Text(
            data,
            maxLines: 1,
            softWrap: false,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w400,
              color: ColorManagers.chatsMainTextColor,
            ),
          ),
        ),
        SizedBox(width: 10.w),
        IconButton(
          onPressed: () {
            // Clipboard.setData(ClipboardData(text: "(+44)  20 1234 5689"));
          },
          icon: Icon(
            Icons.copy_outlined,
            size: 20.sp,
            color: ColorManagers.chatsMainTextColor,
          ),
          splashRadius: 20.r,
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
        ),
      ],
    );
  }
}
