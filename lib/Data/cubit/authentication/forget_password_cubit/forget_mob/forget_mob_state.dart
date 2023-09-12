
import '../../../../models/Auth_models/check_mobile_model.dart';

abstract class CheckMobState {}

class CheckMobInitial extends CheckMobState {}

class CheckMobLoading extends CheckMobState {}

class CheckMobLoaded extends CheckMobState {
  MobModel? response;

  CheckMobLoaded(this.response);
}

class CheckMobError extends CheckMobState {}
