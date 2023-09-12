import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../Presentation/screens/AuthenticationScreens/ChangePassword/change_password.dart';
import '../../../../../app/utils/myApplication.dart';
import '../../../../repositories/authentication/forget_password/check_forget_code_repo.dart';
import 'check_code_state.dart';

class CheckForgetCodeCubit extends Cubit<ForgetCodeState> {
  CheckForgetCodeCubit() : super(ForgetCodeInitial());
  CheckForgetCodeRepo checkCodeRepo = CheckForgetCodeRepo();

  checkCodeMethod({
    String? code,
    BuildContext? context,
  }) {
    try {
      emit(ForgetCodeLoading());
      checkCodeRepo.checkCode(code: code).then((value) {
        if (value != null) {
          emit(ForgetCodeLoaded(value));
          MyApplication.navigateTo(context!, const ChangePassword());
        } else {
          emit(ForgetCodeError());
        }
      });
    } catch (e) {
      emit(ForgetCodeError());
    }
  }
}
