abstract class AuthState {}

class AuthInitial extends AuthState {}

class ChangePasswordIconState extends AuthState {}
class LoginLoadingState extends AuthState {}
class LoginSucessfulltyState extends AuthState {
   final String message;

  LoginSucessfulltyState({required this.message});
}
class LoginErrorState extends AuthState {
  final String message;

  LoginErrorState({required this.message});
}
class ForgetPasswordLoadingState extends AuthState {}
class ForgetPasswordSucessfulltyState extends AuthState {
   final String message;

  ForgetPasswordSucessfulltyState({required this.message});
}
class ForgetPasswordErrorState extends AuthState {
  final String message;

  ForgetPasswordErrorState({required this.message});
}


class ChangeDepartmentValueState extends AuthState {}

class RegisterLoadingState extends AuthState {}
class RegisterSucessfulltyState extends AuthState {
   final String message;

  RegisterSucessfulltyState({required this.message});
}
class RegisterErrorState extends AuthState {
  final String message;

  RegisterErrorState({required this.message});
}