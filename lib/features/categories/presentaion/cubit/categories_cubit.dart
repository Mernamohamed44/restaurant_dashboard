import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:restaurant_dashboard/features/categories/domin/entities/categories_entities.dart';
import 'package:restaurant_dashboard/features/categories/domin/repository/base_categories_repository.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit(this.repo) : super(CategoriesInitial());
  File? imageSelected;
  String imageUploaded = "";

  Future chooseImage({
    required ImageSource source,
    required BuildContext context,
  }) async {
    final image =
        await ImagePicker().pickImage(source: source, imageQuality: 50);
    if (image == null) return;
    imageSelected = File(image.path);
    //uploadImage();
    emit(ChooseImageState());


  }
  final BaseCategoriesRepository repo;
  List<CategoriesEntity> superCategories = [];
  Future getCategoriesData() async {
    emit(SuperCategoriesDataLoadingState());
    final response = await repo.getSuperCategoriesData();
    response.fold(
    (l) {
    emit(SuperCategoriesDataFailedState(message: l.message));
    Logger().e(l.message);
    },
    (r) async {
      superCategories = r;
    emit(SuperCategoriesDataSuccessState());
    },
    );
  }
}
