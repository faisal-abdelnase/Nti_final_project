import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nti_final_project/core/theme/color_managers.dart';
import 'package:nti_final_project/core/theme/style_managers.dart';

class SendMessageContainer extends StatefulWidget {
  const SendMessageContainer({
    super.key,
  });

  @override
  State<SendMessageContainer> createState() => _SendMessageContainerState();
}

class _SendMessageContainerState extends State<SendMessageContainer> {

  late TextEditingController controller;

  bool isTextEmpty = true;
  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color(0xffF0F0F3),
      ),
    
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: TextField(
                decoration: InputDecoration(
    
                  hintText: "Type a message...",
                  hintStyle: StyleManagers.font16Grey500,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
    
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: ColorManagers.secondryColor),
                  ),
    
    
                  suffixIcon: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: (){}, 
                        icon: Icon(Icons.camera_alt_rounded, 
                        color: Colors.blueGrey, size: 24,),
                        ),
    
                      IconButton(
                        onPressed: (){}, 
                        icon: FaIcon(FontAwesomeIcons.paperclip, 
                        color: Colors.blueGrey, ),
                        ),
                    ],
                  ),
                ),


                onChanged: (value) {

                  setState(() {
                    isTextEmpty = value.isEmpty;
                  });

                },
              ),
            ),
          ),
    
          IconButton(
            style: IconButton.styleFrom(
              backgroundColor: ColorManagers.secondryColor,
              minimumSize: Size(45, 45),
              shape: CircleBorder()
            ),
            onPressed: (){}, 
            icon: isTextEmpty 
            ? FaIcon(FontAwesomeIcons.microphoneLines, color: Colors.white,)
            : Icon(Icons.send_sharp, color: Colors.white,)
            )
        ],
      ),
    );
  }
}