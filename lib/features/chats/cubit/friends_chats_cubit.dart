import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nti_final_project/core/service/firebase_chat_service.dart';

part 'friends_chats_state.dart';

class FriendsChatsCubit extends Cubit<FriendsChatsState> {
  FriendsChatsCubit() : super(FriendsChatsInitial());


  FirebaseChatService chatService = FirebaseChatService();

  Future<void> fetchFriendsChats() async {
    emit(FriendsChatsLoading());
    try {
      
      chatService.streamUserChats();
      emit(FriendsChatsSuccess());
    } catch (e) {
      emit(FriendsChatsError(errMessage: 'Failed to fetch friends chats: $e'));
    }
  }
}
