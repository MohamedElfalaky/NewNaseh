import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repositories/advice_repos/approve_advice_repo.dart';
import 'approve_advice_state.dart';

class ApproveAdviceCubit extends Cubit<ApproveAdviceState> {
  ApproveAdviceCubit() : super(ApproveAdviceInitial());
  ApproveAdviceRepo approveAdvice = ApproveAdviceRepo();

  approve(int id) async {
    try {
      emit(ApproveAdviceLoading());
      final mList = await approveAdvice.approve(id);
      emit(ApproveAdviceLoaded(mList));
    } catch (e) {
      emit(ApproveAdviceError());
    }
  }
}
