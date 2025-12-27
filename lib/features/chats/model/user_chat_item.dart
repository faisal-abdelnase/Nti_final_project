import 'package:cloud_firestore/cloud_firestore.dart';

class UserChatItem {
  final String chatId;
  final String type;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;

  // For direct chats
  final String? otherUserId;
  final String? otherUserName;
  final String? otherUserPhoto;

  // For group chats
  final String? groupName;
  final String? groupPhoto;

  UserChatItem({
    required this.chatId,
    required this.type,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.unreadCount,
    this.otherUserId,
    this.otherUserName,
    this.otherUserPhoto,
    this.groupName,
    this.groupPhoto,
  });

  // Check if it's a direct chat
  bool get isDirect => type == 'direct';

  // Check if it's a group chat
  bool get isGroup => type == 'group';

  factory UserChatItem.fromJson(String chatId, Map<String, dynamic> map) {
    return UserChatItem(
      chatId: chatId,
      type: map['type'] ?? 'direct',
      lastMessage: map['lastMessage'] ?? '',
      lastMessageTime: (map['lastMessageTime'] as Timestamp).toDate(),
      unreadCount: map['unreadCount'] ?? 0,
      otherUserId: map['otherUserId'],
      otherUserName: map['otherUserName'],
      otherUserPhoto: map['otherUserPhoto'],
      groupName: map['groupName'],
      groupPhoto: map['groupPhoto'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = {
      'type': type,
      'lastMessage': lastMessage,
      'lastMessageTime': Timestamp.fromDate(lastMessageTime),
      'unreadCount': unreadCount,
    };

    // Add direct chat fields
    if (isDirect) {
      map['otherUserId'] = otherUserId ?? "";
      map['otherUserName'] = otherUserName ?? "";
      map['otherUserPhoto'] = otherUserPhoto ?? "";
    }

    // Add group chat fields
    if (isGroup) {
      map['groupName'] = groupName ?? "";
      map['groupPhoto'] = groupPhoto ?? "";
    }

    return map;
  }

  UserChatItem copyWith({
    String? chatId,
    String? type,
    String? lastMessage,
    DateTime? lastMessageTime,
    int? unreadCount,
    String? otherUserId,
    String? otherUserName,
    String? otherUserPhoto,
    String? groupName,
    String? groupPhoto,
  }) {
    return UserChatItem(
      chatId: chatId ?? this.chatId,
      type: type ?? this.type,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      unreadCount: unreadCount ?? this.unreadCount,
      otherUserId: otherUserId ?? this.otherUserId,
      otherUserName: otherUserName ?? this.otherUserName,
      otherUserPhoto: otherUserPhoto ?? this.otherUserPhoto,
      groupName: groupName ?? this.groupName,
      groupPhoto: groupPhoto ?? this.groupPhoto,
    );
  }
}

class UserChats {
  final String userId;
  final Map<String, UserChatItem> chats;

  UserChats({required this.userId, required this.chats});

  // Create from Firestore DocumentSnapshot
  factory UserChats.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>?;
    Map<String, UserChatItem> chatsMap = {};

    if (data != null && data['chats'] != null) {
      (data['chats'] as Map<String, dynamic>).forEach((chatId, chatData) {
        chatsMap[chatId] = UserChatItem.fromJson(chatId, chatData);
      });
    }

    return UserChats(
      userId: snapshot.id, // Document ID is the userId
      chats: chatsMap,
    );
  }

  // Create from Map with userId
  factory UserChats.fromJson(String userId, Map<String, dynamic> map) {
    Map<String, UserChatItem> chatsMap = {};

    if (map['chats'] != null) {
      (map['chats'] as Map<String, dynamic>).forEach((chatId, chatData) {
        chatsMap[chatId] = UserChatItem.fromJson(chatId, chatData);
      });
    }

    return UserChats(userId: userId, chats: chatsMap);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> chatsMap = {};
    chats.forEach((chatId, chatItem) {
      chatsMap[chatId] = chatItem.toJson();
    });

    return {'chats': chatsMap};
  }

  // Get list of chats sorted by last message time
  List<UserChatItem> get sortedChats {
    final chatList = chats.values.toList();
    chatList.sort((a, b) => b.lastMessageTime.compareTo(a.lastMessageTime));
    return chatList;
  }

  // Get only direct chats
  List<UserChatItem> get directChats {
    return chats.values.where((chat) => chat.isDirect).toList();
  }

  // Get only group chats
  List<UserChatItem> get groupChats {
    return chats.values.where((chat) => chat.isGroup).toList();
  }

  // Get total unread count
  int get totalUnreadCount {
    return chats.values.fold(0, (total, chat) => total + chat.unreadCount);
  }

  // Get unread chats
  List<UserChatItem> get unreadChats {
    return chats.values.where((chat) => chat.unreadCount > 0).toList();
  }

  UserChats copyWith({String? userId, Map<String, UserChatItem>? chats}) {
    return UserChats(userId: userId ?? this.userId, chats: chats ?? this.chats);
  }
}
