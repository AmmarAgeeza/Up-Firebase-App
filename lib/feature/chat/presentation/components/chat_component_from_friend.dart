import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatComponentFromFriend extends StatelessWidget {
  final String message;
  final String name;
  final Timestamp time;

  const ChatComponentFromFriend({
    Key? key,
    required this.message,
    required this.name,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(35),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(message),
            Text(
                '${time.toDate().hour > 12 ? time.toDate().hour - 12 : time.toDate().hour}:${time.toDate().minute} ${time.toDate().hour > 12 ? 'AM' : 'PM'}'),
          ],
        ),
      ),
    );
  }
}
