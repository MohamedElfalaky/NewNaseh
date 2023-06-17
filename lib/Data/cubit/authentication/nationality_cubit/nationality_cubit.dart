import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repositories/authentication/nationality_repo/country_repo.dart';
import 'nationality_state.dart';

class NationalityCubit extends Cubit<NationalityState> {
  NationalityCubit() : super(NationalityInitial());
  NationalityRepo nationalityRepo = NationalityRepo();

  getNationalities() async {
    try {
      emit(NationalityLoading());
      final mList = await nationalityRepo.getNationalities();
      // if (mList?.status == 1) {
      emit(NationalityLoaded(mList));
      // } else {
      //   emit(NationalityError());
      // }
    } catch (e) {
      emit(NationalityError());
    }
  }
}
