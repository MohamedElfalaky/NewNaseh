import '../../../models/advice_models/show_advice_model.dart';

abstract class ApproveAdviceState {}

class ApproveAdviceInitial extends ApproveAdviceState {}

class ApproveAdviceLoading extends ApproveAdviceState {}

class ApproveAdviceLoaded extends ApproveAdviceState {
  ShowAdviceModel? response;

  ApproveAdviceLoaded(this.response);
}

class ApproveAdviceError extends ApproveAdviceState {}
