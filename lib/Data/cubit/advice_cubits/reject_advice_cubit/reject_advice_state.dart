import '../../../models/advice_models/show_advice_model.dart';

abstract class RejectAdviceState {}

class RejectAdviceInitial extends RejectAdviceState {}

class RejectAdviceLoading extends RejectAdviceState {}

class RejectAdviceLoaded extends RejectAdviceState {
  ShowAdviceModel? response;

  RejectAdviceLoaded(this.response);
}

class RejectAdviceError extends RejectAdviceState {}
