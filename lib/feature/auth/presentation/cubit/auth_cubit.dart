import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_firebase/core/database/cache/cache_helper.dart';
import 'package:test_firebase/feature/auth/data/models/user_model.dart';

import '../../../../core/services/service_locator.dart';
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
  // final userAccount = FirebaseAuth.instance;

  IconData suffixIcon = Icons.visibility;
  bool isPasswordShown = true;

  void changePasswordIcon() {
    isPasswordShown = !isPasswordShown;
    suffixIcon = isPasswordShown ? Icons.visibility : Icons.visibility_off;
    emit(ChangePasswordIconState());
  }

  String dropDownValueDepartment = 'SC';

  // List of items in our dropdown menu
  List<String> itemsDepartments = ['SC', 'AI', 'CS', 'IS'];

  void changeDepartmentValue(d) {
    dropDownValueDepartment = d!;
    emit(ChangeDepartmentValueState());
  }

  UserModel? userModel;
// login
  void login() async {
    emit(LoginLoadingState());
    final result = await authRepo.login(
      email: emailLoginController.text,
      password: passwordLoginController.text,
    );
    result.fold(
      (l) => emit(LoginErrorState(message: l)),
      (r) {
        userModel = r;
        sl<CacheHelper>().saveData(key: 'id', value: r.id);
        emit(LoginSucessfulltyState(message: 'Login Sucessfullty'));
      },
    );
  }

  //forget password
  void forgetPassword() async {
    emit(ForgetPasswordLoadingState());
    final result = await authRepo.forgetPassword(
      email: emailLoginController.text,
    );
    result.fold(
      (l) => emit(ForgetPasswordErrorState(message: l)),
      (r) => emit(ForgetPasswordSucessfulltyState(message: r)),
    );
  }

  //register
  void register() async {
    emit(RegisterLoadingState());
    final result = await authRepo.register(
      email: emailRegisterController.text,
      password: passwordRegisterController.text,
      name: nameController.text,
      phoneNumber: phoneNumberController.text,
      department: dropDownValueDepartment,
    );
    result.fold(
      (l) => emit(RegisterErrorState(message: l)),
      (r) => emit(RegisterSucessfulltyState(message: r)),
    );
  }
}
