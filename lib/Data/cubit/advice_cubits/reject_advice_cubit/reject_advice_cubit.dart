import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repositories/advice_repos/reject_advice_repo.dart';
import 'reject_advice_state.dart';

class RejectAdviceCubit extends Cubit<RejectAdviceState> {
  RejectAdviceCubit() : super(RejectAdviceInitial());
  RejectAdviceRepo rejectAdviceRepo = RejectAdviceRepo();

  rejectRequest({dynamic id, String? reject, String? rejectOther}) async {
    try {
      emit(RejectAdviceLoading());
      final mList = await rejectAdviceRepo.reject(
          id: id, reject: reject, rejectOther: rejectOther);
      emit(RejectAdviceLoaded(mList));
    } catch (e) {
      emit(RejectAdviceError());
    }
  }
}
