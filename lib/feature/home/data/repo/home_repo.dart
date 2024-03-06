import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:test_firebase/feature/home/data/models/donator_model.dart';

class HomeRepo {
  Future<Either<String, String>> addDonator(
      {required DonatorModel model}) async {
    try {
     await FirebaseFirestore.instance.collection('Donators').add(model.toMap());
       var data = await FirebaseFirestore.instance
          .collection('BagNumbers')
          .doc('nUD3z9bG7JjaNz6rfs1o')
          .get();
      int realNumber = data.data()!['number'];
      log(data.data()!['number'].toString());
      if (realNumber >= 0) {
     await   FirebaseFirestore.instance
            .collection('BagNumbers')
            .doc('nUD3z9bG7JjaNz6rfs1o')
            .set({
          'number': (realNumber +1),
        });}
      return const Right('تم تسجيل المتبرع بنجاح');
    } catch (e) {
      return const Left('برجاء المحاولة مرة أخرى');
    }
    
  }
  
}
//  final result = await FirebaseFirestore.instance
//           .collection('Users')
//           .doc(user.user!.uid)
//           .get();

      //     FirebaseFirestore.instance
      //     .collection('Users')
      //     .doc(userAccount.user!.uid)
      //     .set(
      //   {
      //     'name': name,
      //     'email': email,
      //     'phone': phone,
      //     'uid': userAccount.user!.uid,
      //   },
      // );