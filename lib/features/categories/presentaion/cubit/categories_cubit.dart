import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:restaurant_dashboard/app/helper/image_services.dart';
import 'package:restaurant_dashboard/app/widget/toastification_widget.dart';
import 'package:restaurant_dashboard/features/categories/domin/entities/categories_entities.dart';
import 'package:restaurant_dashboard/features/categories/domin/repository/base_categories_repository.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit(this.repo) : super(CategoriesInitial());
  XFile? myImage;
  String imageUploaded = "";
  //Uint8List? fileBytes;

  final BaseCategoriesRepository repo;
  List<CategoriesEntity> superCategories = [];
  TextEditingController superCategoryNameController = TextEditingController();

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
        if (superCategories.isEmpty) {
          emit(NoItemSuperCategoriesDataState());
        } else {
          emit(SuperCategoriesDataSuccessState());
        }
      },
    );
  }

  List<CategoriesChildrenEntity> itemSuperCategories = [];
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
  Future getCategoriesDataForMenu({ String ?parent}) async {
    emit(CategoriesDataForMenuLoadingState());
    final response = await repo.getCategoriesDataForMenu(parent: parent!);
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
  Future addCategory({required String name, required BuildContext context}) async {
    if (myImage != null && name.isNotEmpty) {
      emit(AddCategoryLoadingState());
      try {
        if (myImage != null) {
          if (kIsWeb) {
            imageUploaded = await ImagesService.uploadImageWeb(myImage!);
          } else {
            imageUploaded = await ImagesService.uploadImage(myImage!.path);
          }
        }
      } on Exception catch (e) {
        emit(AddCategoryFailedState(message: e.toString()));
        return;
      }
      // if (imageUploaded.isEmpty) return;
      final response = await repo.addCategory(parent: parent, image: imageUploaded.isEmpty ? ' ' : imageUploaded, name: name);
      response.fold(
        (l) {
          emit(AddCategoryFailedState(message: l.message));
          Logger().e(l.message);
        },
        (r) async {
          emit(AddCategorySuccessState());
        },
      );
    } else {
      showToastificationWidget(message: 'All field required', context: context);
      //AddCategoryFailedState(message: 'All field required');
    }
  }

  final formKey = GlobalKey<FormState>();

  Future editCategory({required String name, required String id, required BuildContext context}) async {
    if (formKey.currentState!.validate()) {
      emit(EditCategoryLoadingState());
      try {
        if (myImage != null) {
          if (kIsWeb) {
            imageUploaded = await ImagesService.uploadImageWeb(myImage!);
          } else {
            imageUploaded = await ImagesService.uploadImage(myImage!.path);
          }
        }
      } on Exception catch (e) {
        emit(EditCategoryFailedState(message: e.toString()));
        return;
      }

      final response = await repo.editSuperCategoriesData(parent: parent, image: imageUploaded, name: name, id: id);
      response.fold(
        (l) {
          emit(EditCategoryFailedState(message: l.message));
          Logger().e(l.message);
        },
        (r) async {
          emit(EditCategorySuccessState());
        },
      );
    }
  }

  void pickMemberImageFile({
    required BuildContext context,
    required ImageSource source,
  }) async {
    myImage = await ImagesService.pickFile(context: context, source: source);
    emit(ChooseImageState());
  }

  Future deleteCategory({required String id}) async {
    emit(DeleteCategoryLoadingState());

    final response = await repo.deleteSuperCategoriesData(id: id);
    response.fold(
      (l) {
        emit(DeleteCategoryFailedState(message: l.message));
        Logger().e(l.message);
      },
      (r) async {
        emit(DeleteCategorySuccessState());
      },
    );
  }

  String selectedCategory = "";
  int selectedIndex = 0;
  changeSelectedIndex(int index) {
    selectedIndex = index;
    emit(ChangeSelectedIndexState());
  }
}
