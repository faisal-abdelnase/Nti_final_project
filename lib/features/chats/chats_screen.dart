import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nti_final_project/features/chats/widgets/card_message_container.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(top: 24.h, right: 24.w, left: 24.w),
        itemCount: 10,
        itemBuilder: (context, index) => CardMessageContainer(),
      ),
    );
  }
}
