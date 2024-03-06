import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_firebase/core/utils/app_assets.dart';
import 'package:test_firebase/feature/auth/presentation/cubit/auth_cubit.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/commons.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../cubit/auth_state.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is ForgetPasswordSucessfulltyState) {
              showToast(message: state.message, state: ToastStates.success);
              Navigator.pop(context);
            }
            if (state is ForgetPasswordErrorState) {
              showToast(message: state.message, state: ToastStates.error);
            }
          },
          builder: (context, state) {
            var cubit = AuthCubit.get(context);
            return state is ForgetPasswordLoadingState
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SingleChildScrollView(
                      child: Form(
                        key: cubit.formForgetPasswordKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 72,
                            ),
                            Image.asset(
                              height: 300.h,
                              AppAssets.auth,
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Text(
                              'نسيت كلمة السر؟',
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'أدخل بريدك الالكترونى قبل الاستكمال لاستعادة كلمة السر',
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            CustomTextFormField(
                              type: TextInputType.emailAddress,
                              controller: cubit.emailForgetPasswordController,
                              textInputAction: TextInputAction.done,
                              hint: "البريد الالكترونى",
                              // suffixIcon: Icon(Icons.email_outlined),
                              validate: (p0) {
                                if (p0!.isEmpty ||
                                    !(p0.contains('@gmail.com'))) {
                                  return 'أدخل بريد الكترونى صالح';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 42),
                            CustomButton(
                              text: 'استعادة كلمة السر',
                              onPressed: () async {
                                if (cubit.formForgetPasswordKey.currentState!
                                    .validate()) {
                                  cubit.forgetPassword();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
