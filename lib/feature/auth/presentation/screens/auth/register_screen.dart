import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/commons.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../cubit/auth_cubit.dart';
import '../../cubit/auth_state.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is RegisterSucessfulltyState) {
              showToast(message: state.message, state: ToastStates.success);
              Navigator.pop(context);
            }
            if (state is RegisterErrorState) {
              showToast(message: state.message, state: ToastStates.error);
            }
          },
          builder: (context, state) {
            var cubit = AuthCubit.get(context);
            return state is RegisterLoadingState
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: cubit.formRegisterKey,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 15.h,
                            ),
                            SizedBox(
                                height: 300.h,
                                width: double.infinity,
                                // color: AppColor.primaryColor,
                                child: Image.asset(AppAssets.auth)),
                            SizedBox(
                              height: 15.h,
                            ),

                            //name
                            CustomTextFormField(
                                lable: 'الاسم كامل',
                                controller: cubit.nameController,
                                type: TextInputType.name,
                                validate: (val) {
                                  if (val!.isEmpty) {
                                    return 'مطلوب';
                                  }
                                  return null;
                                }),
                            SizedBox(
                              height: 15.h,
                            ),
                            //phone
                            CustomTextFormField(
                                lable: 'رقم الهاتف',
                                controller: cubit.phoneNumberController,
                                type: TextInputType.phone,
                                validate: (val) {
                                  if (val!.isEmpty || val.length != 11) {
                                    return 'أدخل رقم هاتف صالح';
                                  }
                                  return null;
                                }),
                            SizedBox(
                              height: 15.h,
                            ),
                            //email
                            CustomTextFormField(
                                lable: 'البريد الالكترونى',
                                controller: cubit.emailRegisterController,
                                type: TextInputType.emailAddress,
                                validate: (val) {
                                  if (val!.isEmpty) {
                                    return 'أدخل البريد الالكترونى صالح';
                                  }
                                  if (!(val.contains('@gmail.com'))) {
                                    return 'أدخل البريد الالكترونى صالح';
                                  }
                                  return null;
                                }),
                            SizedBox(
                              height: 15.h,
                            ),

                            //password
                            CustomTextFormField(
                                lable: 'كلمة السر',
                                controller: cubit.passwordRegisterController,
                                type: TextInputType.visiblePassword,
                                isPassword: cubit.isPasswordShown,
                                icon: cubit.suffixIcon,
                                textInputAction: TextInputAction.done,
                                suffixIconOnPressed: () {
                                  cubit.changePasswordIcon();
                                },
                                validate: (val) {
                                  if (val!.isEmpty) {
                                    return 'أدخل كلمة سر صالحة';
                                  }
                                  return null;
                                }),
                            SizedBox(
                              height: 15.h,
                            ),

                            //submit button

                            CustomButton(
                              text: 'إنشاء حساب',
                              onPressed: () async {
                                if (cubit.formRegisterKey.currentState!
                                    .validate()) {
                                  cubit.register();
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
