import '../../../models/Auth_models/check_mobile_model.dart';

abstract class CheckCodeState {}

class CheckCodeInitial extends CheckCodeState {}

class CheckCodeLoading extends CheckCodeState {}

class CheckCodeLoaded extends CheckCodeState {
  MobModel? response;

  CheckCodeLoaded(this.response);
}

class CheckCodeError extends CheckCodeState {}
