import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:restaurant_dashboard/app/helper/image_services.dart';
import 'package:restaurant_dashboard/features/menuItem/domain/entities/categories_items_entities.dart';
import 'package:restaurant_dashboard/features/menuItem/domain/repository/base_menu_repository.dart';

part 'menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  MenuCubit(this.repo) : super(MenuInitial());
  final BaseMenuRepository repo;
  TextEditingController searchController = TextEditingController();

  List<CategoriesItemEntity> itemsData = [];
  int currentPage = 1;
  bool isLoadingMore = false;
  bool hasMore = true;
  Future getItemsData({
    required String id,
    required String items,
    bool loadMore = false,
  }) async {
    if (loadMore) {
      if (isLoadingMore || !hasMore) return; // Prevent multiple fetches
      isLoadingMore = true;
      emit(LoadingMoreItemCategoriesDataState());
    } else {
      emit(GetItemCategoriesDataLoadingState());
    }
    final response = await repo.getCategoriesItem(id: id, items: items, page: currentPage, search: searchController.text);
    response.fold(
      (l) {
        emit(GetItemCategoriesDataFailedState(message: l.message));
        Logger().e(l.message);
      },
      (r) async {
        itemsData = r;
        if (itemsData.isEmpty) {
          emit(NoItemCategoriesDataState());
        } else {
          emit(GetItemCategoriesDataSuccessState());
        }
      },
    );
  }

  void refreshItems(id) {
    currentPage = 1;
    isLoadingMore = false;
    hasMore = true;
    itemsData.clear();
    getItemsData(id: id, items: 'subCategory');
  }

  String imageUploaded = "";
  XFile? myImage;
  // Future<void> chooseMyImage() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['jpg', 'jpeg', 'png'],
  //   );
  //
  //   if (result != null) {
  //     fileBytes = result.files.single.bytes;
  //     myImage = result.files.single.name;
  //     emit(ChooseImageState());
  //   }
  // }

  // Future<void> uploadImage() async {
  //   emit(UploadImageLoadingState());
  //   final response =
  //       await repo.uploadImage(myImage: myImage, fileBytes: fileBytes);
  //   response.fold(
  //     (l) => emit(UploadImageFailedState(message: l.message)),
  //     (r) {
  //       imageUploaded = r;
  //       print(imageUploaded);
  //       emit(UploadImageSuccessState());
  //     },
  //   );
  // }

  final formKey = GlobalKey<FormState>();
  final editFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  String category = '';
  String subCategory = '';
  Future addItem() async {
    if (formKey.currentState!.validate()) {
      emit(AddItemLoadingState());
      try {
        if (myImage != null) {
          if (kIsWeb) {
            imageUploaded = await ImagesService.uploadImageWeb(myImage!);
          } else {
            imageUploaded = await ImagesService.uploadImage(myImage!.path);
          }
        }
      } on Exception catch (e) {
        emit(AddItemFailState(message: e.toString()));
        return;
      }

      final response = await repo.addItem(
        name: nameController.text,
        description: descriptionController.text,
        image: imageUploaded,
        category: category,
        subCategory: subCategory,
        price: priceController.text,
      );
      response.fold(
        (l) {
          emit(AddItemFailState(message: l.message));
          Logger().e(l.message);
        },
        (r) {
          emit(AddItemSuccessState());
        },
      );
    }
  }

  clearImage() {
    myImage = null;
    emit(ClearImageState());
  }

  Future editItem({required String id}) async {
    if (editFormKey.currentState!.validate()) {
      emit(EditItemLoadingState());
      try {
        if (myImage != null) {
          if (kIsWeb) {
            imageUploaded = await ImagesService.uploadImageWeb(myImage!);
          } else {
            imageUploaded = await ImagesService.uploadImage(myImage!.path);
          }
        }
      } on Exception catch (e) {
        emit(AddItemFailState(message: e.toString()));
        return;
      }
      // if (imageUploaded.isEmpty) return;
      final response = await repo.editItem(
        name: nameController.text,
        description: descriptionController.text,
        image: imageUploaded,
        subCategory: subCategory,
        price: priceController.text,
        id: id,
      );
      response.fold(
        (l) {
          emit(EditItemFailState(message: l.message));
          Logger().e(l.message);
        },
        (r) {
          emit(EditItemSuccessState());
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

  Future deleteItem({required String id}) async {
    emit(DeleteItemLoadingState());

    final response = await repo.deleteItem(id: id);
    response.fold(
      (l) {
        emit(DeleteItemFailState(message: l.message));
        Logger().e(l.message);
      },
      (r) async {
        emit(DeleteItemSuccessState());
      },
    );
  }
}
