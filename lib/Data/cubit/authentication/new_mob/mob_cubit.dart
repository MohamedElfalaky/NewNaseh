import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Presentation/screens/AuthenticationScreens/RegistrationCycle/RegistrationStage2/RegistrationStage2.dart';
import '../../../../app/utils/myApplication.dart';
import '../../../repositories/authentication/mob_repo.dart';
import 'mob_state.dart';

class MobCubit extends Cubit<MobState> {
  MobCubit() : super(MobInitial());
  MobRepo mobRepo = MobRepo();

  register({
    String? phone,
    BuildContext? context,
  }) {
    try {
      emit(MobLoading());
      mobRepo
          .checkMob(
        phone: phone,
      )
          .then((value) {
        if (value != null) {
          emit(MobLoaded(value));
          MyApplication.navigateTo(context!, const RegistrationStage2());
        } else {
          emit(MobError());
        }
      });
    } catch (e) {
      emit(MobError());
    }
  }
}
