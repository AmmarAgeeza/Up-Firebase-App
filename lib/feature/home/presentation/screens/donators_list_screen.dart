import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/app_colors.dart';
import '../../data/models/donator_model.dart';

class DonatorsListScreen extends StatelessWidget {
  const DonatorsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'كل المتبرعين',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Donators').snapshots(),
        builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active){
               List<DonatorModel> donators = snapshot.data!.docs
              .map((e) => DonatorModel.fromMap(e.data()))
              .toList();
          log(donators.length.toString());
          return ListView.builder(
            itemCount: donators.length,
            itemBuilder: (context, index) {

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  // style: ListTileStyle.,
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(16)),
                  leading: CircleAvatar(
                    child: Text('${index + 1}'),
                  ),
                  title: Text(donators[index].name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(donators[index].phone),
                      Text(donators[index].address),
                      Text(DateFormat.yMd('ar').format(donators[index].date)),
                    ],
                  ),
                  trailing: Text(
                    donators[index].type,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
              );
            },
          );
       
            }
            else{
             return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  );
            }
          },
      ),
    );
  }
}
