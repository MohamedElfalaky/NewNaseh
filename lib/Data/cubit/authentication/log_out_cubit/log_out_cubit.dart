import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Presentation/screens/AuthenticationScreens/LoginScreen/loginscreen.dart';
import '../../../../app/utils/myApplication.dart';
import '../../../repositories/authentication/log_out_repo.dart';
import 'log_out_state.dart';

class LogOutCubit extends Cubit<LogOutState> {
  LogOutCubit() : super(LogOutInitial());
  LogOutRepo logOutRepo = LogOutRepo();

  logOut({
    BuildContext? context,
  }) {
    try {
      emit(LogOutLoading());
      logOutRepo.logOut().then((value) {
        if (value != null) {
          emit(LogOutLoaded(value));
          MyApplication.navigateToReplaceAllPrevious(
              context!, const LoginScreen());
        } else {
          emit(LogOutError());
        }
      });
    } catch (e) {
      emit(LogOutError());
    }
  }
}
