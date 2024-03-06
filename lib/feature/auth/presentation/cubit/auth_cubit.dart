import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_firebase/core/database/cache/cache_helper.dart';

import '../../../../core/services/service_locator.dart';
import '../../data/models/user_model.dart';
import '../../data/repository/auth_repo.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo) : super(AuthInitial());
  final AuthRepo authRepo;
  static AuthCubit get(context) => BlocProvider.of(context);

//auth logic
  final TextEditingController emailLoginController = TextEditingController();
  final TextEditingController passwordLoginController = TextEditingController();
  final TextEditingController emailRegisterController = TextEditingController();
  final TextEditingController passwordRegisterController =
      TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> formLoginKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formRegisterKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formForgetPasswordKey = GlobalKey<FormState>();
  final TextEditingController emailForgetPasswordController =
      TextEditingController();

  IconData suffixIcon = Icons.visibility;
  bool isPasswordShown = true;

  void changePasswordIcon() {
    isPasswordShown = !isPasswordShown;
    suffixIcon = isPasswordShown ? Icons.visibility : Icons.visibility_off;
    emit(ChangePasswordIconState());
  }

  UserModel? userModel;
// login
  void login() async {
    emit(LoginLoadingState());
    var res = await authRepo.login(
      email: emailLoginController.text,
      password: passwordLoginController.text,
    );
    res.fold((l) => emit(LoginErrorState(message: l)), (r) {
      userModel = r;
      sl<CacheHelper>().saveData(key: 'id', value: r.uid);
      emailLoginController.clear();
      passwordLoginController.clear();
      emit(
        LoginSucessfulltyState(message: 'تم تسجيل الدخول بنجاح'),
      );
    });
  }

  //forget password
  void forgetPassword() async {
    emit(ForgetPasswordLoadingState());
    var res = await authRepo.forgetPassword(
      email: emailForgetPasswordController.text,
    );
    res.fold(
      (l) => emit(ForgetPasswordErrorState(message: l)),
      (r) {
        emailForgetPasswordController.clear();
        emit(
          ForgetPasswordSucessfulltyState(message: r),
        );
      },
    );
  }

  //register
  void register() async {
    emit(RegisterLoadingState());
    var res = await authRepo.register(
      email: emailRegisterController.text,
      password: passwordRegisterController.text,
      name: nameController.text,
      phone: phoneNumberController.text,
    );
    res.fold(
      (l) => emit(RegisterErrorState(message: l)),
      (r) {
        nameController.clear();
        emailRegisterController.clear();
        passwordRegisterController.clear();
        phoneNumberController.clear();
        emit(
          RegisterSucessfulltyState(message: r),
        );
      },
    );
  }
}
