import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Presentation/screens/Home/HomeScreen.dart';
import '../../../../app/utils/myApplication.dart';
import '../../../repositories/authentication/get_user_by_token.dart';
import 'get_user_state.dart';

class GetUserCubit extends Cubit<GetUserState> {
  GetUserCubit() : super(GetUserInitial());
  GetUserRepo getUser = GetUserRepo();

  getUserMethod({
    BuildContext? context,
  }) {
    try {
      emit(GetUserLoading());
      getUser.getUser().then((value) {
        if (value != null) {
          emit(GetUserLoaded(value));
          MyApplication.navigateTo(context!, const HomeScreen());
        } else {
          emit(GetUserError());
        }
      });
    } catch (e) {
      emit(GetUserError());
    }
  }
}
