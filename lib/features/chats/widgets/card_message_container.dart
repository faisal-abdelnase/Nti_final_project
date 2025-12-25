import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nti_final_project/core/theme/color_managers.dart';
import 'package:nti_final_project/core/theme/style_managers.dart';
import 'package:nti_final_project/features/chats%20_%20conversation/chats_conversation_screen.dart';

class CardMessageContainer extends StatelessWidget {
  const CardMessageContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChatsConversationScreen()),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 24.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage("assets/images/Avatar.png"),
            ),
            SizedBox(width: 16.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "David Wayne",
                    style: StyleManagers.font16Black700,
                  ),
                ),
                Text(
                  "Thanks a bunch! Have a great day! 😊",
                  style: StyleManagers.font12grey700,
                ),
              ],
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "12:00",
                  style: StyleManagers.font12grey700.copyWith(
                    color: ColorManagers.chatsTimeColor,
                  ),
                ),
                SizedBox(height: 10.h),
                Container(
                  constraints: BoxConstraints(minWidth: 16),
                  decoration: BoxDecoration(
                    color: ColorManagers.notificationColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 5.w,
                      right: 5.w,
                      top: 2.h,
                      bottom: 4.h,
                    ),
                    child: Text(
                      "5",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
