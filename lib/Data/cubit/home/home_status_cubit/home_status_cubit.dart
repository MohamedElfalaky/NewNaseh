import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/home_models/home_status_model.dart';
import '../../../repositories/home_repos/home_status_repo.dart';
import 'home_status_state.dart';

class HomeStatusCubit extends Cubit<HomeStatusState> {
  HomeStatusCubit() : super(HomeStatusInitial());
  HomeStatusRepo homeRepo = HomeStatusRepo();

  HomeStatusModel? homeStatusModel;

  static HomeStatusCubit get(context) => BlocProvider.of(context);

  getDataHomeStatus() async {
    try {
      emit(HomeStatusLoading());
      final mList = await homeRepo.getHSList();
      homeStatusModel = mList;
      emit(HomeStatusLoaded(mList));
    } catch (e) {
      emit(HomeStatusError());
    }
  }
}
