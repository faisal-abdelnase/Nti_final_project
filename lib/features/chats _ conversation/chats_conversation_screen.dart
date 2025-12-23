import 'package:flutter/material.dart';
import 'package:nti_final_project/features/chats%20_%20conversation/model/mesage_model.dart';
import 'package:nti_final_project/features/chats%20_%20conversation/widgets/chat_buble.dart';
import 'package:nti_final_project/features/chats%20_%20conversation/widgets/chat_buble_friend.dart';
import 'package:nti_final_project/features/chats%20_%20conversation/widgets/chats_conversation_app_bar.dart';
import 'package:nti_final_project/features/chats%20_%20conversation/widgets/send_message_container.dart';

class ChatsConversationScreen extends StatelessWidget {
  const ChatsConversationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatsConversationAppBar(),

      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
            
              decoration: BoxDecoration(
                color: Color(0xffF0F0F3),
              ),
            
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index){
                  return messages[index].id == "me"
                  ? ChatBuble(message: messages[index].message,)
                  :ChatBubleFriend(message: messages[index].message);
                }),
            ),
          ),


          SendMessageContainer()
        ],
      ),
    );
  }
}



