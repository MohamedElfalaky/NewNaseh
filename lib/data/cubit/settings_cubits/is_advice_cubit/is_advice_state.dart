import '../../../models/Auth_models/user_model.dart';

abstract class IsAdviceState {}

class IsAdviceInitial extends IsAdviceState {}

class IsAdviceLoading extends IsAdviceState {}

class IsAdviceLoaded extends IsAdviceState {
  LoginModel? response;

  IsAdviceLoaded(this.response);
}

class IsAdviceError extends IsAdviceState {}
