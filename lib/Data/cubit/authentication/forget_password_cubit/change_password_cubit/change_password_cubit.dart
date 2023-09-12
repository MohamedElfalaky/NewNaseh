import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasooh/Presentation/screens/AuthenticationScreens/LoginScreen/loginscreen.dart';
import '../../../../../Presentation/screens/AuthenticationScreens/ChangePassword/change_password.dart';
import '../../../../../app/utils/myApplication.dart';
import '../../../../repositories/authentication/forget_password/change_password_repo.dart';
import 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordInitial());
  ChangePassRepo changePassRepo = ChangePassRepo();

  changePassMethod({
    String? phone,
    String? pass,
    String? passwordConfirmation,
    BuildContext? context,
  }) {
    try {
      emit(ChangePasswordLoading());
      changePassRepo.change(phone:phone , pass: pass,passwordConfirmation:passwordConfirmation ).then((value) {
        if (value != null) {
          emit(ChangePasswordLoaded(value));
          MyApplication.navigateTo(context!, const LoginScreen());
        } else {
          emit(ChangePasswordError());
        }
      });
    } catch (e) {
      emit(ChangePasswordError());
    }
  }
}
