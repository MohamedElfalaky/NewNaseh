import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../Presentation/screens/Home/HomeScreen.dart';
import '../../../../app/utils/myApplication.dart';
import '../../../repositories/authentication/register_repo.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  Register register = Register();

  registerMethod({
    String? phone,
    String? pass,
    String? fullName,
    String? mobile,
    String? countryId,
    String? cityId,
    String? gender,
    String? nationalityId,
    String? category,
    String? userName,
    String? info,
    XFile? avatar,
    String? description,
    String? experienceYear,
    String? documents,
    String? bankName,
    String? bankAccount,
    String? birthday,
    BuildContext? context,
  }) {
    try {
      emit(RegisterLoading());
      register
          .register(
        phone: phone,
        pass: pass,
        experienceYear: experienceYear,
        fullName: fullName,
        gender: gender,
        info: info,
        mobile: mobile,
        nationalityId: nationalityId,
        userName: userName,
        avatar: avatar,
        bankAccount: bankAccount,
        bankName: bankName,
        birthday: birthday,
        category: category,
        cityId: cityId,
        countryId: countryId,
        description: description,
        documents: documents,
      )
          .then((value) {
        if (value != null) {
          emit(RegisterLoaded(value));
          MyApplication.navigateTo(context!, const HomeScreen());
        } else {
          emit(RegisterError());
        }
      });
    } catch (e) {
      emit(RegisterError());
    }
  }
}
