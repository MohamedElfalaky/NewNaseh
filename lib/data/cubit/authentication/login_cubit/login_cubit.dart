
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../../../Data/cubit/authentication/login_cubit/login_state.dart';
import '../../../../Data/repositories/authentication/login_repo.dart';
import '../../../../Presentation/screens/Home/home_screen.dart';
import '../../../../app/utils/my_application.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  Auth auth = Auth();

  login({
    String? phone,
    String? pass,
    BuildContext? context,
  }) {
    try {
      emit(LoginLoading());
      auth
          .login(
        phone: phone,
        pass: pass,
      )
          .then((value) {
        if (value != null) {
          emit(LoginLoaded(value));
          MyApplication.navigateToReplaceAllPrevious(
              context!, const HomeScreen());
        } else {
          emit(LoginError());
        }
      });
    } catch (e) {
      emit(LoginError());
    }
  }
}
