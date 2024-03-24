import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasooh/Data/models/home_models/home_one_model.dart';

import '../../../models/advice_models/show_advice_model.dart';
import '../../../repositories/home_repos/home_one_repo.dart';
import 'home_one_state.dart';

class ListOneHomeCubit extends Cubit<ListOneHomeState> {
  ListOneHomeCubit() : super(ListOneHomeInitial());
  ListOneHomeRepo listHomeOne = ListOneHomeRepo();
  HomeOrdersList? ordersList;
  List<ShowAdData>? homeSearchList = [];

  getHomeSearch({required String name}) {
    if (name == '') {
      homeSearchList?.clear();
      emit(ListOneHomeLoaded(ordersList));
      return;
    }
    homeSearchList?.clear();
    ordersList?.data?.map((e) {
      if (e.name?.contains(name) == true || e.id.toString() == name) {
        homeSearchList?.add(e);
      }
    }).toList();

    if (homeSearchList?.isEmpty == true) {
      homeSearchList?.clear();
      emit(ListOneHomeLoaded(ordersList));
      return;
    }

    emit(ListOneHomeLoaded(ordersList));
  }

  getOneHome(String id) async {
    try {
      emit(ListOneHomeLoading());
      ordersList = await listHomeOne.getHSList(id);
      emit(ListOneHomeLoaded(ordersList));
    } catch (e) {
      emit(ListOneHomeError());
    }
  }
}
