import '../../../models/Auth_models/country_model.dart';

abstract class CountryState {}

class CountryInitial extends CountryState {}

class CountryLoading extends CountryState {}

class CountryLoaded extends CountryState {
  CountryModel? response;

  CountryLoaded(this.response);
}

class CountryError extends CountryState {}
