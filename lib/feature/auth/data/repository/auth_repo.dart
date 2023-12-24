import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_firebase/feature/auth/data/models/user_model.dart';

class AuthRepo {
//login
  Future<Either<String, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userData =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      var doc = FirebaseFirestore.instance
          .collection('Users')
          .doc(userData.user!.uid);
      //read data
      var dataMap = await doc.get();
      var model = UserModel.fromJson(
        dataMap.data()!,
        userData.user!.uid,
      );
      return  Right(model);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return const Left('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        return const Left('Wrong password provided for that user.');
      } else {
        return Left(e.message.toString());
      }
    }
  }

//register
  Future<Either<String, String>> register({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
    required String department,
  }) async {
    try {
      final UserCredential userData =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userData.user!.uid)
          .set({
        'email': email,
        'name': name,
        'phoneNumber': phoneNumber,
        'department': department,
      });
      return const Right('Email Created Sucessfully');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return const Left('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return const Left('The account already exists for that email.');
      } else {
        return Left(e.code);
      }
    }
  }

//forget password
  Future<Either<String, String>> forgetPassword({required String email}) async {
    try {
      final res =
          await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return const Right('Check your mail');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return const Left('No user found for that email.');
      } else {
        return Left(e.message.toString());
      }
    }
  }
}
//1. get id from user credentials in register [Done]
//2. save data of user in firestore [Done]
//3. get id from user credentials in login [Done]
//4. get data of user from firestore through id. [Done]