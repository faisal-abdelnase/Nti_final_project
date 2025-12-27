import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_final_project/core/routing/app_router.dart';
import 'package:nti_final_project/cubits/auth_cubit.dart';
import 'package:nti_final_project/features/auth/login/login_screen.dart';
import 'package:nti_final_project/features/auth/sign_up/sign_up_screen.dart';
import 'package:nti_final_project/features/chats%20_%20conversation/chats_conversation_screen.dart';
import 'package:nti_final_project/firebase/firebase_db.dart';
import 'package:nti_final_project/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(FirebaseDb()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(scaffoldBackgroundColor: Colors.white),
        onGenerateRoute: AppRouter.generateRoute,
        // initialRoute: SignUpScreen.routeName,
        // routes: {
        //   SignUpScreen.routeName : (context) => SignUpScreen(),
        //   LoginScreen.routeName : (context) => LoginScreen(),
        //   ChatsConversationScreen.routeName : (context) => ChatsConversationScreen(),
        // },
      ),
    );
  }
}
