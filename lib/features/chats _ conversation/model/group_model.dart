import 'package:cloud_firestore/cloud_firestore.dart';

class GroupMemberData {
  final String name;
  final String? photoURL;
  final String role; 

  GroupMemberData({
    required this.name,
    this.photoURL,
    required this.role,
  });

  bool get isAdmin => role == 'admin';

  factory GroupMemberData.fromJson(Map<String, dynamic> map) {
    return GroupMemberData(
      name: map['name'] ?? '',
      photoURL: map['photoURL'],
      role: map['role'] ?? 'member',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'photoURL': photoURL,
      'role': role,
    };
  }

  GroupMemberData copyWith({
    String? name,
    String? photoURL,
    String? role,
  }) {
    return GroupMemberData(
      name: name ?? this.name,
      photoURL: photoURL ?? this.photoURL,
      role: role ?? this.role,
    );
  }
}





class GroupLastMessage {
  final String text;
  final String senderId;
  final String senderName;
  final DateTime timestamp;

  GroupLastMessage({
    required this.text,
    required this.senderId,
    required this.senderName,
    required this.timestamp,
  });

  factory GroupLastMessage.fromJson(Map<String, dynamic> map) {
    return GroupLastMessage(
      text: map['text'] ?? '',
      senderId: map['senderId'] ?? '',
      senderName: map['senderName'] ?? '',
      timestamp: (map['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'senderId': senderId,
      'senderName': senderName,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }
}





class GroupModel {
  final String groupId;
  final String name;
  final String? description;
  final String? photoURL;
  final List<String> adminIds;
  final List<String> memberIds;
  final Map<String, GroupMemberData> membersData;
  final GroupLastMessage? lastMessage;
  final DateTime createdAt;
  final DateTime updatedAt;

  GroupModel({
    required this.groupId,
    required this.name,
    this.description,
    this.photoURL,
    required this.adminIds,
    required this.memberIds,
    required this.membersData,
    this.lastMessage,
    required this.createdAt,
    required this.updatedAt,
  });

  // Check if a user is admin
  bool isAdmin(String userId) => adminIds.contains(userId);

  // Check if a user is member
  bool isMember(String userId) => memberIds.contains(userId);

  // Get member count
  int get memberCount => memberIds.length;

  // Get admin count
  int get adminCount => adminIds.length;

  // Create from Firestore DocumentSnapshot
  factory GroupModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return GroupModel.fromJson(snapshot.id, data);
  }

  factory GroupModel.fromJson(String groupId, Map<String, dynamic> map) {
    // Parse membersData
    Map<String, GroupMemberData> membersDataMap = {};
    if (map['membersData'] != null) {
      (map['membersData'] as Map<String, dynamic>).forEach((key, value) {
        membersDataMap[key] = GroupMemberData.fromJson(value);
      });
    }

    return GroupModel(
      groupId: groupId,
      name: map['name'] ?? '',
      description: map['description'],
      photoURL: map['photoURL'],
      adminIds: List<String>.from(map['adminIds'] ?? []),
      memberIds: List<String>.from(map['memberIds'] ?? []),
      membersData: membersDataMap,
      lastMessage: map['lastMessage'] != null
          ? GroupLastMessage.fromJson(map['lastMessage'])
          : null,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    // Convert membersData to Map
    Map<String, dynamic> membersDataMap = {};
    membersData.forEach((key, value) {
      membersDataMap[key] = value.toJson();
    });

    return {
      'name': name,
      'description': description,
      'photoURL': photoURL,
      'adminIds': adminIds,
      'memberIds': memberIds,
      'membersData': membersDataMap,
      'lastMessage': lastMessage?.toJson(),
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  GroupModel copyWith({
    String? groupId,
    String? name,
    String? description,
    String? photoURL,
    List<String>? adminIds,
    List<String>? memberIds,
    Map<String, GroupMemberData>? membersData,
    GroupLastMessage? lastMessage,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return GroupModel(
      groupId: groupId ?? this.groupId,
      name: name ?? this.name,
      description: description ?? this.description,
      photoURL: photoURL ?? this.photoURL,
      adminIds: adminIds ?? this.adminIds,
      memberIds: memberIds ?? this.memberIds,
      membersData: membersData ?? this.membersData,
      lastMessage: lastMessage ?? this.lastMessage,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}



class GroupMessageModel {
  final String messageId;
  final String text;
  final String senderId;
  final String senderName;
  final DateTime timestamp;
  final String type; // text, image, file, etc.
  final List<String> readBy; // Array of user IDs who read the message
  final String? imageUrl;
  final String? fileUrl;
  final String? fileName;

  GroupMessageModel({
    required this.messageId,
    required this.text,
    required this.senderId,
    required this.senderName,
    required this.timestamp,
    required this.type,
    required this.readBy,
    this.imageUrl,
    this.fileUrl,
    this.fileName,
  });

  // Check if a specific user has read the message
  bool isReadBy(String userId) => readBy.contains(userId);

  // Get read count
  int get readCount => readBy.length;

  // Create from Firestore DocumentSnapshot
  factory GroupMessageModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return GroupMessageModel.fromJson(snapshot.id, data);
  }

  factory GroupMessageModel.fromJson(String messageId, Map<String, dynamic> map) {
    return GroupMessageModel(
      messageId: messageId,
      text: map['text'] ?? '',
      senderId: map['senderId'] ?? '',
      senderName: map['senderName'] ?? '',
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      type: map['type'] ?? 'text',
      readBy: List<String>.from(map['readBy'] ?? []),
      imageUrl: map['imageUrl'],
      fileUrl: map['fileUrl'],
      fileName: map['fileName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'senderId': senderId,
      'senderName': senderName,
      'timestamp': Timestamp.fromDate(timestamp),
      'type': type,
      'readBy': readBy,
      'imageUrl': imageUrl,
      'fileUrl': fileUrl,
      'fileName': fileName,
    };
  }

  GroupMessageModel copyWith({
    String? messageId,
    String? text,
    String? senderId,
    String? senderName,
    DateTime? timestamp,
    String? type,
    List<String>? readBy,
    String? imageUrl,
    String? fileUrl,
    String? fileName,
  }) {
    return GroupMessageModel(
      messageId: messageId ?? this.messageId,
      text: text ?? this.text,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      readBy: readBy ?? this.readBy,
      imageUrl: imageUrl ?? this.imageUrl,
      fileUrl: fileUrl ?? this.fileUrl,
      fileName: fileName ?? this.fileName,
    );
  }
}