import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_firebase/core/database/cache/cache_helper.dart';
import 'package:test_firebase/core/utils/app_assets.dart';
import 'package:test_firebase/core/utils/commons.dart';
import 'package:test_firebase/core/widgets/custom_button.dart';
import 'package:test_firebase/core/widgets/custom_text_form_field.dart';
import 'package:test_firebase/feature/home/data/models/donator_model.dart';
import 'package:test_firebase/feature/home/presentation/cubit/home_cubit.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/confirmation_dialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is DecreaseBagsNumbersSucessfulltyState) {
          showToast(message: state.message, state: ToastStates.success);
        }
        if (state is DecreaseBagsNumbersErrorState) {
          showToast(message: state.message, state: ToastStates.error);
        }
      },
      child: Scaffold(
        body: Form(
          key: context.read<HomeCubit>().numberKey,
          child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('Donators').snapshots(),
            builder: (context, snapshot) {
              return StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('BagNumbers')
                      .snapshots(),
                  builder: (context, snapshotBags) {
                    if (snapshotBags.connectionState ==
                            ConnectionState.active &&
                        snapshot.connectionState == ConnectionState.active) {
                      List<DonatorModel> donators = snapshot.data!.docs
                          .map((e) => DonatorModel.fromMap(e.data()))
                          .toList();
                      log(donators.length.toString());
                      log(snapshotBags.data!.docs[0].get('number').toString());
                      int number = snapshotBags.data!.docs[0].get('number');
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            //image header
                            Image.asset(
                              AppAssets.blood,
                              height: 200.h,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(
                              height: 45,
                            ),
                            //no donaotors
                            Text(
                              'عدد المتبرعين الحالين : ${donators.length}',
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            //current sack
                            Text(
                              'عدد الأكياس الحالي : $number',
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            //decrease sack
                            CustomButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext ctx) =>
                                      ConfirmationDialog(
                                    alertMsg: 'هل متأكد من صرف الكمية؟',
                                    onTapConfirm: () {
                                      Navigator.pop(context);
                                      context
                                          .read<HomeCubit>()
                                          .decreaseBagsNumbers();
                                    },
                                  ),
                                );
                              },
                              text: 'صرف كيس',
                              width: 250.w,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            //decrease sack input
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: CustomButton(
                                      onPressed: () {
                                        if (context
                                            .read<HomeCubit>()
                                            .numberKey
                                            .currentState!
                                            .validate()) {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext ctx) =>
                                                ConfirmationDialog(
                                              alertMsg:
                                                  'هل متأكد من صرف الكمية؟',
                                              onTapConfirm: () {
                                                Navigator.pop(context);
                                                context
                                                    .read<HomeCubit>()
                                                    .decreaseBagsNumbers(
                                                        number: int.parse(
                                                            context
                                                                .read<
                                                                    HomeCubit>()
                                                                .numbers
                                                                .text));
                                              },
                                            ),
                                          );
                                        }
                                      },
                                      text: 'صرف',
                                      width: 250.w,
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    flex: 2,
                                    child: CustomTextFormField(
                                      controller:
                                          context.read<HomeCubit>().numbers,
                                      type: TextInputType.number,
                                      textInputAction: TextInputAction.done,
                                      hint: 'عدد الأكياس',
                                      validate: (p0) {
                                        if (p0!.isEmpty ||
                                            num.tryParse(p0) == null) {
                                          return 'أدخل رقم صالح';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                      child: Text(
                                    'كيس',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge,
                                  ))
                                ],
                              ),
                            ),
                            //reports
                            //add new donator
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  CustomButton(
                                    onPressed: () {
                                      navigate(
                                          context: context,
                                          route: Routes.donatorsList);
                                    },
                                    text: 'عرض التقرير',
                                    // width: 250.w,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  CustomButton(
                                    onPressed: () {
                                      navigate(
                                          context: context,
                                          route: Routes.addDonator);
                                    },
                                    text: 'تسجيل متبرع جديد',
                                    // width: 250.w,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 45,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomButton(
                                onPressed: () async {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext ctx) =>
                                        ConfirmationDialog(
                                      alertMsg:
                                          'هل متأكد من تسجيل الخروج من التطبيق؟',
                                      onTapConfirm: () async {
                                        Navigator.pop(context);
                                        await sl<CacheHelper>()
                                            .sharedPreferences
                                            .clear()
                                            .then((value) => navigateRepacement(
                                                context: context,
                                                route: Routes.login));
                                      },
                                    ),
                                  );
                                },
                                text: 'تسجيل الخروج من التطبيق',
                                // width: 250.w,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      );
                    }
                  });
            },
          ),
        ),
      ),
    );
  }
}
