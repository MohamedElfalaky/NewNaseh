import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repositories/advice_repos/show_advice_repo.dart';
import 'show_advice_state.dart';

class ShowAdviceCubit extends Cubit<ShowAdviceState> {
  ShowAdviceCubit() : super(ShowAdviceInitial());
  ShowAdviceRepo showAdvice = ShowAdviceRepo();

  show(int id) async {
    try {
      emit(ShowAdviceLoading());
      final mList = await showAdvice.show(id);
      emit(ShowAdviceLoaded(mList));
    } catch (e) {
      emit(ShowAdviceError());
    }
  }
}
