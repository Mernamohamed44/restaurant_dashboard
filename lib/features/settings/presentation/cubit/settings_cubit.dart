import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/phone_number.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());
  String phoneNumber = "";
  String number = "";

  onInputChanged(PhoneNumber phone) {
    phoneNumber = "${phone.countryCode}${phone.number}";
    number = phone.number;
    emit(ChangeNumberState());
  }

  TextEditingController keyWordsController = TextEditingController();
  TextEditingController linksController = TextEditingController();
  TextEditingController customInputController = TextEditingController();
  List<String> words = [];
  List<String> links = [];
  List<String> customerInput = [];

  void addKeyWords() {
    words.add(keyWordsController.text);
    print(words);
    keyWordsController.clear();
    emit(AddWordsState());
  }

  void clearKeyWords(index) {
    words.removeAt(index);
    print(words);
    emit(ClearWordsState());
  }

  void addLink() {
    links.add(linksController.text);
    print(links);
    linksController.clear();
    emit(AddWordsState());
  }

  void clearLink(index) {
    links.removeAt(index);
    print(links);
    emit(ClearWordsState());
  }

  void addCustomInput() {
    customerInput.add(customInputController.text);
    print(customerInput);
    customInputController.clear();
    emit(AddWordsState());
  }

  void clearCustomInput(index) {
    customerInput.removeAt(index);
    print(customerInput);
    emit(ClearWordsState());
  }

  bool starRatingValue = false;

  changeStarRatingValue(value) {
    starRatingValue = value;
    emit(ChangeStarRatingValueState());
  }

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

  TextEditingController blackController = TextEditingController();
  TextEditingController whiteController = TextEditingController();
  TextEditingController primaryController = TextEditingController();
  TextEditingController secondaryController = TextEditingController();
  TextEditingController focusTextOnLightController = TextEditingController();
  TextEditingController defaultTextOnLightController = TextEditingController();
  TextEditingController disabledTextOnLightController = TextEditingController();
  TextEditingController focusTextOnDarkController = TextEditingController();
  TextEditingController defaultTextOnDarkController = TextEditingController();
  TextEditingController disabledTextOnDarkController = TextEditingController();
}
