// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// /*
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await Future.wait([
//     Firebase.initializeApp(),
//     //fdsjn
//   ]);
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const FirebaseScreen(),
//     );
//   }
// }
// */
// class FirebaseScreen extends StatefulWidget {
//   const FirebaseScreen({super.key});

//   @override
//   State<FirebaseScreen> createState() => _FirebaseScreenState();
// }

// class _FirebaseScreenState extends State<FirebaseScreen> {
//   FirebaseAuth firebaseAuthInstance = FirebaseAuth.instance;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             // Authentication
//             //1.Register
//             // await _registerUser();
//             //2.Login
//             await _loginUser(
//               emailAddress: 'flutter.upacademy10@gmail.com',
//               password: 'flutter123',
//             );
//             //3.email verification
//             // _emailVerificationUser();
//             //4.reset password.
//             // _resetPasswordUser(email: 'flutter.upacademy10@gmail.com');
//           },
//           child: const Text('Pressed'),
//         ),
//       ),
//     );
//   }

//   _registerUser() async {
//     try {
//       await firebaseAuthInstance.createUserWithEmailAndPassword(
//         email: 'flutter.upacademy10@gmail.com',
//         password: 'flutter123',
//       );
//     } on FirebaseAuthException catch (error) {
//       if (error.code == 'weak-password') {
//         print(error.message);
//       }
//       if (error.code == 'email-already-in-use') {
//         print(error.message);
//       }
//     }
//   }

//   _loginUser({required String emailAddress, required String password}) async {
//     try {
//       final UserCredential credential =
//           await firebaseAuthInstance.signInWithEmailAndPassword(
//         email: emailAddress,
//         password: password,
//       );
//       print(credential.user!.uid);
//       print(credential.user!.emailVerified);
//       if (credential.user!.emailVerified) {
//         //go to home
//         print('go to home screen');
//       } else {
//         print('please verfiy your mail address');
//         _emailVerificationUser();
//       }
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         print('No user found for that email.');
//       } else if (e.code == 'wrong-password') {
//         print('Wrong password provided for that user.');
//       }
//     }
//   }

//   _emailVerificationUser() async {
//     await firebaseAuthInstance.currentUser!.sendEmailVerification();
//   }

//   _resetPasswordUser({required String email}) async {
//     await firebaseAuthInstance.sendPasswordResetEmail(email: email);
//   }

//   void collectionAndDocument() async {
//     //collections
//     //read data
//     var firebaseInstace = FirebaseFirestore.instance;
//     /*
//           var doc =
//               firebaseInstace.collection('Users').doc('sBHfSYNBbQjXeLHiPTqg');
//           //read data
//           await doc.get().then((value) => print(value['name']));
//           //update and insert data
//           await doc.set({
//             'name': 'Your name',
//             'phone': '025120',
//             'email': 'your@example.com',
//             'address': 'Egypt',
//           });
//           //read data
//           await doc.get().then((value) => print(value['name']));
//           //delete document
//           await doc.delete();
//   */
//     //----------------
//     //delaing with collection
//     var collection = firebaseInstace.collection('Users');
//     collection.add({
//       'name': 'Samy',
//       'phone': '56128451',
//       'email': 'samy@example.com',
//       'address': 'Egypt',
//     });
//     //read data
//     var res = await collection.get();
//     for (var element in res.docs) {
//       print(element['name']);
//     }
//     // await collection
//     //     .get()
//     //     .then((value) => value.docs.forEach((element) {
//     //           print(element['name']);
//     //         }));
//     // write data
//     var doctwo = firebaseInstace
//         .collection('Users')
//         .doc('CnsCvDgoHpK1IslBMBGR')
//         .collection('Notes')
//         .add({
//       'note': 'element',
//       'date': '15/12',
//     });
//   }
// }
