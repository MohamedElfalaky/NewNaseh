import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repositories/home_repos/home_one_repo.dart';
import 'home_one_state.dart';

class ListOneHomeCubit extends Cubit<ListOneHomeState> {
  ListOneHomeCubit() : super(ListOneHomeInitial());
  ListOneHomeRepo listHomeOne = ListOneHomeRepo();


  getOneHome(String id) async {
    try {
      emit(ListOneHomeLoading());
      final mList = await listHomeOne.getHSList(id);
      emit(ListOneHomeLoaded(mList));
    } catch (e) {
      emit(ListOneHomeError());
    }
  }
}
