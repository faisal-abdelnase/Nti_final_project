import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nti_final_project/core/service/firebase_chat_service.dart';
import 'package:nti_final_project/features/chats/model/user_chat_item.dart';
import 'package:nti_final_project/features/chats/widgets/card_message_container.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseChatService chatService = FirebaseChatService();
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<UserChats?>(
          stream: chatService.streamUserChats(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data == null) {
              return const Center(child: Text('No chats yet'));
            }

            final userChats = snapshot.data!;
            final chatsList = userChats.sortedChats; 

            return ListView.builder(
              padding: EdgeInsets.only(top: 24.h, right: 24.w, left: 24.w),
              itemCount: userChats.chats.length,
              itemBuilder: (context, index) {
                  final UserChatItem chat = chatsList[index];
                
          

                return CardMessageContainer(userChat: chat,);
              },
            );
          },
        ),
      ),
    );
  }
}
