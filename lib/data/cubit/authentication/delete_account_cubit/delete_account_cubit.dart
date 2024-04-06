import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/utils/my_application.dart';
import '../../../../presentation/screens/authentication/LoginScreen/login_screen.dart';
import '../../../repositories/authentication/delete_account_repo.dart';
import 'delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  DeleteAccountCubit() : super(DeleteAccountInitial());
  DeleteAccountRepo deleteAccountRepo = DeleteAccountRepo();

  delete({
    BuildContext? context,
  }) {
    try {
      emit(DeleteAccountLoading());
      deleteAccountRepo.logOut().then((value) {
        if (value != null) {
          emit(DeleteAccountLoaded(value));
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
