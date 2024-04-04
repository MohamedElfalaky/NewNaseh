import '../../../../models/Auth_models/user_model.dart';

abstract class ChangePasswordState {}

class ChangePasswordInitial extends ChangePasswordState {}

class ChangePasswordLoading extends ChangePasswordState {}

class ChangePasswordLoaded extends ChangePasswordState {
  LoginModel? response;

  ChangePasswordLoaded(this.response);
}

class ChangePasswordError extends ChangePasswordState {}
