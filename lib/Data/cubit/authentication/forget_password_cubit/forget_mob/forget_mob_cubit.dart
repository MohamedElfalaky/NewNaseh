import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Presentation/screens/AuthenticationScreens/ChangePassword/check_forget_code_screen.dart';
import '../../../../../app/utils/myApplication.dart';
import '../../../../repositories/authentication/forget_password/check_forget_mobile_repo.dart';
import 'forget_mob_state.dart';

class CheckCheckMobCubit extends Cubit<CheckMobState> {
  CheckCheckMobCubit() : super(CheckMobInitial());
  CheckMobForget mobRepo = CheckMobForget();

  register({
    String? phone,
    BuildContext? context,
  }) {
    try {
      emit(CheckMobLoading());
      mobRepo
          .checkMob(
        phone: phone,
      )
          .then((value) {
        if (value != null) {
          emit(CheckMobLoaded(value));
          MyApplication.navigateTo(context!, const CheckForgetCode());
        } else {
          emit(CheckMobError());
        }
      });
    } catch (e) {
      emit(CheckMobError());
    }
  }
}
