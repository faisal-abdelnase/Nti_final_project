import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nti_final_project/core/service/firebase_chat_service.dart';
import 'package:nti_final_project/features/chats%20_%20conversation/model/mesage_model.dart';
import 'package:nti_final_project/features/chats%20_%20conversation/widgets/chat_buble.dart';
import 'package:nti_final_project/features/chats%20_%20conversation/widgets/chat_buble_friend.dart';
import 'package:nti_final_project/features/chats%20_%20conversation/widgets/chats_conversation_app_bar.dart';
import 'package:nti_final_project/features/chats%20_%20conversation/widgets/send_message_container.dart';

class ChatsConversationScreen extends StatelessWidget {
  

  const ChatsConversationScreen({
    super.key, required this.chatId,
});

final String chatId;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: ChatsConversationAppBar(),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xffF0F0F3),
              ),
              child: StreamBuilder<List<MessageModel>>(
                stream: FirebaseChatService().streamMessages(chatId),
                builder: (context, snapshot) {
              
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text('No messages yet'),
                    );
                  }

                  final messages = snapshot.data!;

                  return ListView.builder(
                    reverse: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];

                      return message.senderId == FirebaseAuth.instance.currentUser!.uid
                          ? ChatBuble(message: message.text)
                          : ChatBubleFriend(
                              message: message.text,
                            );
                    },
                  );
                },
              ),
            ),
          ),

  
          SendMessageContainer(chatId: chatId,),
        ],
      ),
    );
  }
}
