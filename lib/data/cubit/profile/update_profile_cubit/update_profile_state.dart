import '../../../models/Auth_models/register_model.dart';

abstract class UpdateProfileState {}

class UpdateProfileInitial extends UpdateProfileState {}

class UpdateProfileLoading extends UpdateProfileState {}

class UpdateProfileLoaded extends UpdateProfileState {
  RegisterModel? response;

  UpdateProfileLoaded(this.response);
}

class UpdateProfileError extends UpdateProfileState {}
