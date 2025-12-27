import 'package:flutter/material.dart';
import 'package:nti_final_project/core/theme/color_managers.dart';
import 'package:nti_final_project/core/theme/style_managers.dart';

class ChatBuble extends StatelessWidget {
  const ChatBuble({
    super.key, required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentGeometry.centerRight,
      child: Container(
        margin: EdgeInsets.only(left: 64, right: 24,top: 12, bottom: 6),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ColorManagers.bubleColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            bottomLeft: Radius.circular(16),
            topRight: Radius.circular(16)
          )
        ),
                    
        child: Text(message, style: StyleManagers.font16White500,),
      ),
    );
  }
}

