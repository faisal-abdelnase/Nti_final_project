import 'package:flutter/material.dart';
import 'package:nti_final_project/core/routing/app_router.dart';
import 'package:nti_final_project/core/routing/routes.dart';

void main() {
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: Routes.chatsConversation,
    );
  }
}