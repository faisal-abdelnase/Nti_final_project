import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nti_final_project/core/theme/color_managers.dart';
import 'package:nti_final_project/core/theme/style_managers.dart';
import 'package:nti_final_project/features/chats%20_%20conversation/chats_conversation_screen.dart';
import 'package:nti_final_project/features/chats/model/user_chat_item.dart';

class CardMessageContainer extends StatelessWidget {
  const CardMessageContainer({super.key, required this.userChat, });

  final UserChatItem userChat;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8), // For ripple clipping
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatsConversationScreen(chatId: userChat.chatId,),  ),
          );


        },
        child: Container(
          margin: EdgeInsets.only(bottom: 24.h),
          padding: EdgeInsets.symmetric(
            vertical: 8,
          ), // optional, to make ripple visible
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
                      userChat.otherUserName ?? "",
                      style: StyleManagers.font16Black700,
                    ),
                  ),
                  Text(
                    userChat.lastMessage,
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
      ),
    );
  }
}
