import 'package:flutter/material.dart';
import 'package:nti_final_project/core/theme/style_managers.dart';

class ChatsConversationAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatsConversationAppBar({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: ListTile(
        leading: CircleAvatar(
        radius: 18,
        backgroundImage: AssetImage("assets/images/Avatar.png"),
      ),
      title: Text("David Wayne", style: StyleManagers.font16Black500,),
      subtitle: Text("(+44) 50 9285 3022" ,style: StyleManagers.font12grey700,),
      ),
      leading: IconButton(
        style: IconButton.styleFrom(
          shape: CircleBorder(),
          shadowColor: Colors.black,
          elevation: 3,
          backgroundColor: Colors.white,
          minimumSize: Size(5, 5)
        ),
        onPressed: (){}, 
        icon: Icon(Icons.arrow_back, size: 20,),
        ),
    
      actions: [
        IconButton(
          onPressed: (){}, 
          icon: Icon(Icons.videocam_outlined , color: Colors.black,),
          ),
    
        IconButton(
          onPressed: (){}, 
          icon: Icon(Icons.local_phone_outlined , color: Colors.black,),
          ),
      ],
    );
  }
}