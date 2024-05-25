import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasooh/Data/models/settings_models/privacy_policy_model.dart';
import 'package:nasooh/data/repositories/settings/about_us_repo.dart';
import 'about_state.dart';

class AboutCubit extends Cubit<AboutState> {
  AboutCubit() : super(AboutInitial());
  AboutUsRepo privacyRepo = AboutUsRepo();

  getAbout() async {
    try {
      emit(AboutLoading());
      final mList = await privacyRepo.getAbout();
      emit(AboutLoaded(mList));
    } catch (e) {
      emit(AboutError());
    }
  }
}
