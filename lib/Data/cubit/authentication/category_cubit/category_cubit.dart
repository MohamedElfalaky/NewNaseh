import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasooh/Data/repositories/authentication/category_repo/category_repo.dart';
import 'category_state.dart';

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