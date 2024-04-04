import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Data/cubit/settings_cubits/privacy_cubit/privacy_state.dart';
import '../../../../Data/repositories/settings/privacy_policy_repo.dart';


class PrivacyCubit extends Cubit<PrivacyState> {
  PrivacyCubit() : super(PrivacyInitial());
  PolicyRepo privacyRepo = PolicyRepo();

  getPrivacy() async {
    try {
      emit(PrivacyLoading());
      final mList = await privacyRepo.getPolicy();
      emit(PrivacyLoaded(mList));
    } catch (e) {
      emit(PrivacyError());
    }
  }
}
