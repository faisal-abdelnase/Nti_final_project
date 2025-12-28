import 'package:flutter/material.dart';
import 'package:nti_final_project/core/routing/routes.dart';
import 'package:nti_final_project/features/auth/login/login_screen.dart';
import 'package:nti_final_project/features/auth/sign_up/sign_up_screen.dart';
import 'package:nti_final_project/features/chats%20_%20conversation/chats_conversation_screen.dart';
import 'package:nti_final_project/features/chats/add_friends_screen.dart';
import 'package:nti_final_project/features/chats/chats_screen.dart';
import 'package:nti_final_project/features/main_layout.dart';
import 'package:nti_final_project/features/profile/profile_screen.dart';

class AppRouter {
  static Route? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.chatsConversation:
        return MaterialPageRoute(builder: (_) => ChatsConversationScreen(chatId: routeSettings.arguments as String,));
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case Routes.signUpScreen:
        return MaterialPageRoute(builder: (_) => SignUpScreen());

      case Routes.chats:
        return MaterialPageRoute(builder: (_) => ChatsScreen());
      case Routes.profile:
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case Routes.mainLayout:
        return MaterialPageRoute(builder: (_) => MainLayout());

      case Routes.addFriendsScreen:
        return MaterialPageRoute(builder: (_) =>  AddFriendsScreen());
      default:
        return null;
    }
  }
}
