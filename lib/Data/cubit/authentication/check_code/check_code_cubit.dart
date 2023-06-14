import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Presentation/screens/AuthenticationScreens/RegistrationCycle/RegistrationStage3/RegistrationStage3.dart';
import '../../../../app/utils/myApplication.dart';
import '../../../repositories/authentication/check_code_repo.dart';
import 'check_code_state.dart';

class CheckCodeCubit extends Cubit<CheckCodeState> {
  CheckCodeCubit() : super(CheckCodeInitial());
  CheckCodeRepo checkCodeRepo = CheckCodeRepo();

  checkCodeMethod({
    String? phone,
    String? code,
    BuildContext? context,
  }) {
    try {
      emit(CheckCodeLoading());
      checkCodeRepo.checkCode(phone: phone, code: code).then((value) {
        if (value != null) {
          emit(CheckCodeLoaded(value));
          MyApplication.navigateTo(context!, const RegistrationStage3());
        } else {
          emit(CheckCodeError());
        }
      });
    } catch (e) {
      emit(CheckCodeError());
    }
  }
}
