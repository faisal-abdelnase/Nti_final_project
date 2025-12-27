import 'package:flutter/material.dart';
import 'package:nti_final_project/core/routing/routes.dart';
import 'package:nti_final_project/features/auth/login/login_screen.dart';
import 'package:nti_final_project/features/auth/sign_up/sign_up_screen.dart';
import 'package:nti_final_project/features/chats%20_%20conversation/chats_conversation_screen.dart';

class AppRouter {
  static Route? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.chatsConversation:
        return MaterialPageRoute(builder: (_) => ChatsConversationScreen());
      case Routes.loginScreen:
          return MaterialPageRoute(builder: (_) => LoginScreen());
      case Routes.signUpScreen:
          return  MaterialPageRoute(builder: (_) => SignUpScreen()); 
      default:
        return null;
    }
  }
}