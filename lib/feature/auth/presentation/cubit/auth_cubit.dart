import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

// login
 

  //forget password
  
}
