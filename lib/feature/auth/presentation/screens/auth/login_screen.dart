import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/routes/app_routes.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/commons.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../cubit/auth_cubit.dart';
import '../../cubit/auth_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LoginSucessfulltyState) {
            showToast(message: state.message, state: ToastStates.success);
            navigateRepacement(context: context, route: Routes.home);
          }
          if (state is LoginErrorState) {
            showToast(message: state.message, state: ToastStates.error);
          }
        },
        builder: (context, state) {
          var cubit = AuthCubit.get(context);
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: cubit.formLoginKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                        height: 300.h,
                        width: double.infinity,
                        // color: AppColor.primaryColor,
                        child: Image.asset(AppAssets.auth)),
                    SizedBox(
                      height: 15.h,
                    ),
                    //email
                    CustomTextFormField(
                        lable: 'البريد الإلكترونى',
                        controller: cubit.emailLoginController,
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
                        controller: cubit.passwordLoginController,
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
                    //forgetPassword
                    Row(
                      children: [
                        const Spacer(),
                        state is ForgetPasswordLoadingState
                            ? const CircularProgressIndicator()
                            : TextButton(
                                onPressed: () async {
                                  navigate(
                                      context: context,
                                      route: Routes.forgetPassword);
                                },
                                child: const Text(
                                  'نسيت كلمة السر؟',
                                ),
                              ),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    //sign in button
                    state is LoginLoadingState
                        ? const CircularProgressIndicator(
                            color: AppColors.primary,
                          )
                        : CustomButton(
                            text: 'تسجيل الدخول',
                            onPressed: () async {
                              if (cubit.formLoginKey.currentState!.validate()) {
                                cubit.login();
                              }
                            },
                          ),
                    SizedBox(
                      height: 25.h,
                    ),
                    TextButton(
                      onPressed: () {
                        navigate(route: Routes.register, context: context);
                      },
                      child: const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text: 'ليس لديك حساب؟',
                                style: TextStyle(color: Colors.black)),
                            TextSpan(text: ' إنشاء حساب'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      )),
    );
  }
}
