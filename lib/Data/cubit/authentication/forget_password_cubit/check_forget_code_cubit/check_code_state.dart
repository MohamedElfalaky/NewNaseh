import '../../../../models/Auth_models/check_mobile_model.dart';

abstract class ForgetCodeState {}

class ForgetCodeInitial extends ForgetCodeState {}

class ForgetCodeLoading extends ForgetCodeState {}

class ForgetCodeLoaded extends ForgetCodeState {
  MobModel? response;

  ForgetCodeLoaded(this.response);
}

class ForgetCodeError extends ForgetCodeState {}
