// import 'package:flutter/material.dart';

// class ForgetPassword extends StatelessWidget {
//   const ForgetPassword({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(
//                 height: 72,
//               ),
//               Text(
//                 'Forgot Password?',
//                 style: CustomTextStyle.poppinsStyle28,
//               ),
//               const SizedBox(height: 16),
//               Text(
//                   'Enter your email address before proceeding to password reset ',
//                   style: CustomTextStyle.poppinsStyle16
//                       .copyWith(color: AppColors.gray)),
//               Image.asset(Assets.imagesOn2),
//               const CustomTextField(
//                 hint: "Email",
//                 suffixIcon: Icon(Icons.email_outlined),
//               ),
//               const SizedBox(height: 42),
//               Container(
//                 alignment: Alignment.center,
//                 width: MediaQuery.of(context).size.width,
//                 height: 60,
//                 decoration: ShapeDecoration(
//                   color: const Color(0xFF6D67E4),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 child: Text(
//                   'Send',
//                   textAlign: TextAlign.center,
//                   style: CustomTextStyle.poppinsStyle16.copyWith(
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }