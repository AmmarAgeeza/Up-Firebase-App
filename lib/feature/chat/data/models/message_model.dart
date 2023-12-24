import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String message;
  final String name;
  final Timestamp time;

  MessageModel(this.message, this.time, this.name);

  factory MessageModel.fromJson(jsonData) {
    return MessageModel(
      jsonData['message'],
      jsonData['time'],
      jsonData['name'],
    );
  }
}
