import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Data/cubit/authentication/category_cubit/category_state.dart';
import '../../../../Data/repositories/authentication/category_repo/category_repo.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());
  CategoryRepo categoryRepo = CategoryRepo();

  getCategories() async {
    try {
      emit(CategoryLoading());
      final mList = await categoryRepo.getData();
      // if (mList?.status == 1) {
      emit(CategoryLoaded(mList));
      // } else {
      //   emit(CategoryError());
      // }
    } catch (e) {
      emit(CategoryError());
    }
  }
}
