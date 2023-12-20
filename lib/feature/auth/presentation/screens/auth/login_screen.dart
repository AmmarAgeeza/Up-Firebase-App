import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/routes/app_routes.dart';
import '../../../../../core/utils/app_assets.dart';
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
          }
          if (state is LoginErrorState) {
            showToast(message: state.message, state: ToastStates.error);
          }
          if (state is ForgetPasswordSucessfulltyState) {
            showToast(message: state.message, state: ToastStates.success);
          }
          if (state is ForgetPasswordErrorState) {
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
                        lable: 'E-mail',
                        controller: cubit.emailLoginController,
                        type: TextInputType.emailAddress,
                        validate: (val) {
                          if (val!.isEmpty) {
                            return 'Please Enter E-mail';
                          }
                          if (!(val.contains('@gmail.com'))) {
                            return 'E-mail must contains @gmail.com';
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 15.h,
                    ),
                    //password
                    CustomTextFormField(
                        lable: 'Password',
                        controller: cubit.passwordLoginController,
                        type: TextInputType.visiblePassword,
                        isPassword: cubit.isPasswordShown,
                        icon: cubit.suffixIcon,
                        suffixIconOnPressed: () {
                          cubit.changePasswordIcon();
                        },
                        validate: (val) {
                          if (val!.isEmpty) {
                            return 'Please Enter valid password';
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
                                onPressed: () async {},
                                child: const Text(
                                  'Forget Password?',
                                ),
                              ),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    //sign in button
                    state is LoginLoadingState
                        ? const CircularProgressIndicator()
                        : CustomButton(
                            text: 'Sign in',
                            onPressed: () async {
                              if (cubit.formLoginKey.currentState!.validate()) {
                                // difftent way to use cubit
                                // read => not rebuild
                                //watch => rebuild
                                context.read<AuthCubit>().login();
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
                                text: 'Don\'t have an account?',
                                style: TextStyle(color: Colors.black)),
                            TextSpan(text: ' Sign up'),
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
