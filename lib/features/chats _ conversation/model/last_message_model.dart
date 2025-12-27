import 'package:cloud_firestore/cloud_firestore.dart';

class LastMessage {
  final String text;
  final String senderId;
  final DateTime timestamp;
  final bool read;

  LastMessage({
    required this.text,
    required this.senderId,
    required this.timestamp,
    required this.read,
  });

  factory LastMessage.fromJson(Map<String, dynamic> map) {
    return LastMessage(
      text: map['text'] ?? '',
      senderId: map['senderId'] ?? '',
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      read: map['read'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'senderId': senderId,
      'timestamp': Timestamp.fromDate(timestamp),
      'read': read,
    };
  }
}
