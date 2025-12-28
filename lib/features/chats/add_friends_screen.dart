import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_final_project/core/service/firebase_chat_service.dart';
import 'package:nti_final_project/core/theme/color_managers.dart';
import 'package:nti_final_project/core/theme/style_managers.dart';
import 'package:nti_final_project/features/chats/cubit/friends_chats_cubit.dart';

class AddFriendsScreen extends StatelessWidget {
  const AddFriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManagers.primaryColor,
        title: const Text(
          'Add Friends',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),

        centerTitle: true,
        leadingWidth: 90,
        leading: IconButton(
          style: IconButton.styleFrom(
            shape: CircleBorder(),
            backgroundColor: Colors.grey.withValues(alpha: 0.2),
          ),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Enter friend's username or email",
                hintStyle: StyleManagers.font16Grey500,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey),
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: ColorManagers.secondryColor),
                ),
              ),

              onChanged: (value) {
                context
                    .read<FriendsChatsCubit>().searchUsers(value);
              },
            ),

            BlocBuilder<FriendsChatsCubit, FriendsChatsState>(
              builder: (context, state) {

                final cubit = context.read<FriendsChatsCubit>();
                if(state is FriendsChatsLoading){
                  return Center(
                    child: CircularProgressIndicator(
                      color: ColorManagers.primaryColor,
                    ),
                  );
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: cubit.searchedUsers.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(
                            "assets/images/Avatar.png",
                          ),
                        ),
                        title: Text(
                          cubit.searchedUsers[index].name,
                          style: StyleManagers.font18PrimColor600,
                        ),
                        subtitle: Text( cubit.searchedUsers[index].email),
                        trailing: IconButton(
                          onPressed: (){
                            FirebaseChatService().createOrGetDirectChat(
                              cubit.searchedUsers[index].uid
                            );
                          }, 
                          icon: Icon(Icons.person_add_alt_1_rounded, color: ColorManagers.secondryColor,)),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
