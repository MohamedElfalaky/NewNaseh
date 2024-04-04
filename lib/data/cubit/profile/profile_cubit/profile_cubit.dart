import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Data/cubit/profile/profile_cubit/profile_state.dart';
import '../../../../Data/models/profile_models/profile_model.dart';
import '../../../../Data/repositories/profile/profile_repo.dart';


class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  GetProfileRepo profileRepo = GetProfileRepo();

  ProfileModel? profileModel;

  static ProfileCubit get(context) => BlocProvider.of(context);

  getDataProfile() async {
    try {
      emit(ProfileLoading());
      final mList = await profileRepo.getProfile();
      profileModel = mList;
      emit(ProfileLoaded(mList));
    } catch (e) {
      emit(ProfileError());
    }
  }
}
