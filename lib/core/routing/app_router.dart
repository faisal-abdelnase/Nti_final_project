import 'package:flutter/material.dart';
import 'package:nti_final_project/core/routing/routes.dart';
import 'package:nti_final_project/features/chats%20_%20conversation/chats_conversation_screen.dart';
import 'package:nti_final_project/features/chats/chats_screen.dart';
import 'package:nti_final_project/features/profile/profile_screen.dart';

class AppRouter {
  static Route? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.chatsConversation:
        return MaterialPageRoute(builder: (_) => ChatsConversationScreen());

      case Routes.chats:
        return MaterialPageRoute(builder: (_) => ChatsScreen());
      case Routes.profile:
        return MaterialPageRoute(builder: (_) => ProfileScreen());

      default:
        return null;
    }
  }
}
