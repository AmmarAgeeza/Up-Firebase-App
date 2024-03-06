import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';

class AuthRepo {
  // Either<int,int>
//login
  Future<Either<String, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      //  login with firebase auth
      UserCredential user =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // get user data from firestore
      final result = await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.user!.uid)
          .get();

      return Right(UserModel.fromJson(result.data()!));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return const Left('يوجد خطأ فى البريد الالكترونى أو كلمة السر');
      } else if (e.code == 'wrong-password') {
        return const Left('يوجد خطأ فى البريد الالكترونى أو كلمة السر');
      } else {
        return const Left('يوجد خطأ فى البريد الالكترونى أو كلمة السر');
      }
    } catch (e) {
      return const Left('رجاء المحاولة مرة أخرى');
    }
  }

//register
  Future<Either<String, String>> register({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async {
    try {
      //register with firebase auth
      final userAccount =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // save user data in firestore
      FirebaseFirestore.instance
          .collection('Users')
          .doc(userAccount.user!.uid)
          .set(
        {
          'name': name,
          'email': email,
          'phone': phone,
          'uid': userAccount.user!.uid,
        },
      );
      return const Right('تم إنشاء حساب بنجاح');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return const Left('كلمة السر ضعيفة جدا');
      } else if (e.code == 'email-already-in-use') {
        return const Left('الحساب مستخدم من قبل');
      } else {
        return const Left('رجاء المحاولة مرة أخرى');
      }
    } catch (e) {
      return const Left('رجاء المحاولة مرة أخرى');
    }
  }

//forget password
  Future<Either<String, String>> forgetPassword({
    required String email,
  }) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return const Right('تم إرسال الكود بنجاح');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return const Left('لا يوجد مستخدم لهذا الحساب');
      } else {
        return const Left('رجاء المحاولة مرة أخرى');
      }
    } catch (e) {
      return const Left('رجاء المحاولة مرة أخرى');
    }
  }
}
//algorithm
//1. register with firebase auth
//2. save user data in firestore
//3. login with firebase auth
//4. get user data from firestore
