import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String id;
  final String boardName;
  final String userId;
  final String userName;
  final String message;
  final DateTime timestamp;

  MessageModel({
    required this.id,
    required this.boardName,
    required this.userId,
    required this.userName,
    required this.message,
    required this.timestamp,
  });

  // Convert MessageModel to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'boardName': boardName,
      'userId': userId,
      'userName': userName,
      'message': message,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }

  // Create MessageModel from Firestore document
  factory MessageModel.fromMap(Map<String, dynamic> map, String id) {
    return MessageModel(
      id: id,
      boardName: map['boardName'] ?? '',
      userId: map['userId'] ?? '',
      userName: map['userName'] ?? '',
      message: map['message'] ?? '',
      timestamp: (map['timestamp'] as Timestamp).toDate(),
    );
  }

  // Create MessageModel from Firestore DocumentSnapshot
  factory MessageModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return MessageModel.fromMap(data, doc.id);
  }
}