import '../../../models/home_models/home_status_model.dart';

abstract class HomeStatusState {}

class HomeStatusInitial extends HomeStatusState {}

class HomeStatusLoading extends HomeStatusState {}

class HomeStatusLoaded extends HomeStatusState {
  HomeStatusModel? response;

  HomeStatusLoaded(this.response);
}

class HomeStatusError extends HomeStatusState {}
