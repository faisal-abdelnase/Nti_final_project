import 'package:flutter/material.dart';
import 'package:nti_final_project/core/helper/extensions.dart';
import 'package:nti_final_project/features/chats%20_%20conversation/widgets/attachment_option_item.dart';

class AttachmentOption extends StatelessWidget {
  const AttachmentOption({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
      margin: EdgeInsets.only(bottom: 80, left: 10, right: 10),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.5, 
      ),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              mainAxisSpacing: 20,
              crossAxisSpacing: 10,
              childAspectRatio: 0.85,
              children: [
                AttachmentOptionItem(
                  icon: Icons.person,
                  label: 'Contact',
                  color: Colors.blue,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                AttachmentOptionItem(
                  icon: Icons.location_on,
                  label: 'Location',
                  color: Colors.teal,
                  onTap: () {
                    context.pop();
                    
                  },
                ),
                AttachmentOptionItem(
                  icon: Icons.camera_alt,
                  label: 'Camera',
                  color: Colors.pink,
                  onTap: () {
                    context.pop();
                    
                  },
                ),
                AttachmentOptionItem(
                  icon: Icons.photo_library,
                  label: 'Gallery',
                  color: Colors.blue,
                  onTap: () {
                    context.pop();
                    
                  },
                ),
                AttachmentOptionItem(
                  icon: Icons.calendar_today,
                  label: 'Event',
                  color: Colors.pink,
                  onTap: () {
                    context.pop();
                  },
                ),
                AttachmentOptionItem(
                  icon: Icons.poll,
                  label: 'Poll',
                  color: Colors.orange,
                  onTap: () {
                    context.pop();
                  },
                ),
                AttachmentOptionItem(
                  icon: Icons.headset,
                  label: 'Audio',
                  color: Colors.deepOrange,
                  onTap: () {
                    context.pop();
                  },
                ),
                AttachmentOptionItem(
                  icon: Icons.description,
                  label: 'Document',
                  color: Colors.deepPurple,
                  onTap: () {
                    context.pop();
                    
                  },
                ),

              AttachmentOptionItem(
              icon: Icons.auto_awesome,
              label: 'AI Image',
              color: Colors.blue,
              onTap: () {
                context.pop();
              },
            ),
              ],
            ),
            
          ],
        ),
      ),
    ),
    );
  }
}




