import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nti_final_project/core/service/firebase_chat_service.dart';
import 'package:nti_final_project/features/auth/model/user_model.dart';

part 'friends_chats_state.dart';

class FriendsChatsCubit extends Cubit<FriendsChatsState> {
  FriendsChatsCubit() : super(FriendsChatsInitial());


  FirebaseChatService chatService = FirebaseChatService();

  List<UserModel> searchedUsers = [];

  Future<void> searchUsers(String query) async {
    emit(FriendsChatsLoading());
    try {

      searchedUsers = await chatService.searchUsers(query);
      emit(FriendsChatsSuccess());
    } catch (e) {
      emit(FriendsChatsError(errMessage: 'Failed to fetch users: $e'));
    }
  }
}
