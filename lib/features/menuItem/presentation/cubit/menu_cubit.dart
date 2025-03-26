import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:restaurant_dashboard/features/menuItem/domain/entities/categories_items_entities.dart';
import 'package:restaurant_dashboard/features/menuItem/domain/repository/base_menu_repository.dart';

part 'menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  MenuCubit(this.repo) : super(MenuInitial());
  final BaseMenuRepository repo;

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
    final response =
        await repo.getCategoriesItem(id: id, items: items, page: currentPage);
    response.fold(
      (l) {
        emit(GetItemCategoriesDataFailedState(message: l.message));
        Logger().e(l.message);
      },
      (r) async {
        itemsData = r;
        if(itemsData.isEmpty){
          emit(NoItemCategoriesDataState());
        }
        else{
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
  final formKey=GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  String category = '';
  String subCategory = '';
  Future addItem() async {
    if(formKey.currentState!.validate()){
      emit(AddItemLoadingState());
      if (fileBytes != null) {
        await uploadImage();
      }
      if (imageUploaded.isEmpty) return;
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
}
