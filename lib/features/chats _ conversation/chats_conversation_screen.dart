import 'package:flutter/material.dart';
import 'package:nti_final_project/features/chats%20_%20conversation/widgets/chats_conversation_app_bar.dart';

class ChatsConversationScreen extends StatelessWidget {
  static const String routeName = 'ChatsConversationScreen';
  const ChatsConversationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: ChatsConversationAppBar());
  }
}
