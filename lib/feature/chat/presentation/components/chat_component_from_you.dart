import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class ChatComponentFromYou extends StatelessWidget {
  final String message;
  final Timestamp time;

  const ChatComponentFromYou({
    Key? key,
    required this.message,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'You',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(message),
            Text(time.toDate().hour.toString()),
            Text(
              '${time.toDate().hour > 12 ? time.toDate().hour - 12 : time.toDate().hour}:${time.toDate().minute} ${time.toDate().hour > 12 ? 'PM' : 'AM'}',
            ),
          ],
        ),
      ),
    );
  }
}
