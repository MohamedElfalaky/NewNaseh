import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repositories/settings/change_advice_repo.dart';
import 'is_advice_state.dart';

class IsAdviceCubit extends Cubit<IsAdviceState> {
  IsAdviceCubit() : super(IsAdviceInitial());
  final IsAdviceRepo _isAdviceRepo = IsAdviceRepo();

  isAdvice() {
    try {
      emit(IsAdviceLoading());
      _isAdviceRepo.isAdvice().then((value) {
        if (value != null) {
          emit(IsAdviceLoaded(value));
        } else {
          emit(IsAdviceError());
        }
      });
    } catch (e) {
      emit(IsAdviceError());
    }
  }
}
