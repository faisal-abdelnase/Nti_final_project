import 'package:flutter/material.dart';
import 'package:nti_final_project/core/theme/style_managers.dart';

class ChatBubleFriend extends StatelessWidget {
  const ChatBubleFriend({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentGeometry.centerLeft,
      child: Container(
        margin: EdgeInsets.only(left: 24, right: 64,top: 12, bottom: 6),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
            topRight: Radius.circular(16)
          )
        ),
                    
        child: Text(message, style: StyleManagers.font16Black500,),
      ),
    );
  }
}