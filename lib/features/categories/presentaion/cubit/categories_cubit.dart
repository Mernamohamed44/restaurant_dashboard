import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:restaurant_dashboard/features/categories/domin/entities/categories_entities.dart';
import 'package:restaurant_dashboard/features/categories/domin/repository/base_categories_repository.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit(this.repo) : super(CategoriesInitial());
  String? myImage;
  String imageUploaded = "";
  Uint8List? fileBytes;
  Future<void> chooseMyImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      fileBytes = result.files.single.bytes;
      myImage = result.files.single.name;
      emit(ChooseImageState());
    }
  }

  Future<void> uploadImage() async {
    emit(UploadImageLoadingState());
    final response =
        await repo.uploadImage(myImage: myImage, fileBytes: fileBytes);
    response.fold(
      (l) => emit(UploadImageFailedState(message: l.message)),
      (r) {
        imageUploaded = r;
        print(imageUploaded);
        emit(UploadImageSuccessState());
      },
    );
  }

  final BaseCategoriesRepository repo;
  List<CategoriesEntity> superCategories = [];
  Future getSuperCategoriesData() async {
    emit(SuperCategoriesDataLoadingState());
    final response = await repo.getSuperCategoriesData();
    response.fold(
      (l) {
        emit(SuperCategoriesDataFailedState(message: l.message));
        Logger().e(l.message);
      },
      (r) async {
        superCategories = r;
        if(superCategories.isEmpty){
          emit(NoItemSuperCategoriesDataState());
        }
        else {
          emit(SuperCategoriesDataSuccessState());
        }
      },
    );
  }List<CategoriesChildrenEntity> itemSuperCategories = [];
  Future getItemSuperCategoriesData() async {
    emit(SuperCategoriesDataLoadingState());
    final response = await repo.getItemsSuperCategoriesData();
    response.fold(
      (l) {
        emit(SuperCategoriesDataFailedState(message: l.message));
        Logger().e(l.message);
      },
      (r) async {
        itemSuperCategories = r;
        emit(SuperCategoriesDataSuccessState());
      },
    );
  }

  List<CategoriesEntity> categories = [];
  Future getCategoriesData({required String parent}) async {
    emit(CategoriesDataLoadingState());
    final response = await repo.getCategoriesData(parent: parent);
    response.fold(
      (l) {
        emit(CategoriesDataFailedState(message: l.message));
        Logger().e(l.message);
      },
      (r) async {
        categories = r;
        emit(CategoriesDataSuccessState());
      },
    );
  }

  List<CategoriesEntity> categoriesMenu = [];
  Future getCategoriesDataForMenu({required String parent}) async {
    emit(CategoriesDataForMenuLoadingState());
    final response = await repo.getCategoriesDataForMenu(parent: parent);
    response.fold(
      (l) {
        emit(CategoriesDataForMenuFailedState(message: l.message));
        Logger().e(l.message);
      },
      (r) async {
        categoriesMenu = r;
        emit(CategoriesDataForMenuSuccessState());
      },
    );
  }

  TextEditingController categoryNameController = TextEditingController();

  String? parent;
  Future addCategory({required String name}) async {
    emit(AddCategoryLoadingState());
    if (fileBytes != null) {
      await uploadImage();
    }
    // if (imageUploaded.isEmpty) return;
    final response = await repo.addCategory(
        parent: parent,
        image: imageUploaded.isEmpty ? ' ' : imageUploaded,
        name: name);
    response.fold(
      (l) {
        emit(AddCategoryFailedState(message: l.message));
        Logger().e(l.message);
      },
      (r) async {
        emit(AddCategorySuccessState());
      },
    );
  }

  int selectedIndex = 0;
  changeSelectedIndex(int index) {
    selectedIndex = index;
    emit(ChangeSelectedIndexState());
  }
}
