part of 'friends_chats_cubit.dart';

@immutable
sealed class FriendsChatsState {}

final class FriendsChatsInitial extends FriendsChatsState {}

final class FriendsChatsLoading extends FriendsChatsState {}

final class FriendsChatsSuccess extends FriendsChatsState {}

final class FriendsChatsError extends FriendsChatsState {
  final String errMessage;

  FriendsChatsError({required this.errMessage});
}
