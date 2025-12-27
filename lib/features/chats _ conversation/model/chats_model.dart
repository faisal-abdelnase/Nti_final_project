import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nti_final_project/features/chats%20_%20conversation/model/last_message_model.dart';
import 'package:nti_final_project/features/chats%20_%20conversation/model/participant_data_model.dart';

class ChatModel {
  final String chatId;
  final List<String> participants;
  final Map<String, ParticipantData> participantsData;
  final LastMessage? lastMessage;
  final DateTime updatedAt;
  final DateTime createdAt;

  ChatModel({
    required this.chatId,
    required this.participants,
    required this.participantsData,
    this.lastMessage,
    required this.updatedAt,
    required this.createdAt,
  });

  // Generate chatId from two user IDs
  static String generateChatId(String userId1, String userId2) {
    final sortedIds = [userId1, userId2]..sort();
    return sortedIds.join('_');
  }

  factory ChatModel.fromJson(String chatId, Map<String, dynamic> map) {
    // Parse participantsData
    Map<String, ParticipantData> participantsDataMap = {};
    if (map['participantsData'] != null) {
      (map['participantsData'] as Map<String, dynamic>).forEach((key, value) {
        participantsDataMap[key] = ParticipantData.fromJson(value);
      });
    }

    return ChatModel(
      chatId: chatId,
      participants: List<String>.from(map['participants'] ?? []),
      participantsData: participantsDataMap,
      lastMessage: map['lastMessage'] != null
          ? LastMessage.fromJson(map['lastMessage'])
          : null,
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    // Convert participantsData to Map
    Map<String, dynamic> participantsDataMap = {};
    participantsData.forEach((key, value) {
      participantsDataMap[key] = value.toJson();
    });

    return {
      'participants': participants,
      'participantsData': participantsDataMap,
      'lastMessage': lastMessage?.toJson(),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  ChatModel copyWith({
    String? chatId,
    List<String>? participants,
    Map<String, ParticipantData>? participantsData,
    LastMessage? lastMessage,
    DateTime? updatedAt,
    DateTime? createdAt,
  }) {
    return ChatModel(
      chatId: chatId ?? this.chatId,
      participants: participants ?? this.participants,
      participantsData: participantsData ?? this.participantsData,
      lastMessage: lastMessage ?? this.lastMessage,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
