import '../../../models/home_models/home_one_model.dart';

abstract class ListOneHomeState {}

class ListOneHomeInitial extends ListOneHomeState {}

class ListOneHomeLoading extends ListOneHomeState {}

class ListOneHomeLoaded extends ListOneHomeState {
  HomeOrdersList? response;

  ListOneHomeLoaded(this.response);
}

class ListOneHomeError extends ListOneHomeState {}
