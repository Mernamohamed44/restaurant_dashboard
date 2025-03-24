import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:logger/logger.dart';
import 'package:restaurant_dashboard/app/caching/shared_prefs.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/utils/image_manager.dart';
import 'package:restaurant_dashboard/app/widget/custom_text_form_field.dart';
import 'package:restaurant_dashboard/app/widget/phone_number_input.dart';
import 'package:restaurant_dashboard/features/settings/domain/repository/base_settings_repository.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this.repo) : super(SettingsInitial());
  String phoneNumber = "";
  String number = "";

  onInputChanged(PhoneNumber phone) {
    phoneNumber = "${phone.countryCode}${phone.number}";
    number = phone.number;
    emit(ChangeNumberState());
  }

  ///////////handel phone numbers list ////////////////
  List<Widget> phoneTextField = [];
  List<String> phoneControllers = [];
  List<FocusNode> focusNodesPhones = [FocusNode()];

  //listen to foucusnode
  addListenerFocusNode(int index) {
    focusNodesPhones[index].addListener(() {
      if (!focusNodesPhones[index].hasFocus) {
        if (phoneNumber.isNotEmpty) {
          addPhoneController();
        }
      }
    });
  }

  Widget buildPhoneTextField(int index) {
    return Row(
      children: [
        Expanded(
          child: PhoneNumberInput(
            title: 'Phone Number',
            onInputChanged: (PhoneNumber number) {
              onInputChanged(number);
            },
            focusNode: focusNodesPhones[index],
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: InkWell(
            onTap: () {
              int newIndex = focusNodesPhones.length;
              focusNodesPhones.add(FocusNode());
              addListenerFocusNode(newIndex);
              phoneTextField.add(buildPhoneTextField(newIndex));
              phoneNumber = '';
              emit(AddWordsState());
            },
            child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primary),
                    borderRadius: BorderRadius.circular(10)),
                child: const Icon(
                  Icons.add,
                  color: AppColors.primary,
                )),
          ),
        )
      ],
    );
  }

  addPhoneController() {
    phoneControllers.add(phoneNumber);
    print(phoneControllers);
    emit(AddWordsState());
  }

  ///////////handel emails list ////////////////

  List<Widget> emailTextField = [];
  List<TextEditingController> emailControllers = [TextEditingController()];
  List<String> emailControllersString = [];
  List<FocusNode> focusNodesEmails = [FocusNode()];

  addListenerFocusNodeEmails(int index) {
    focusNodesEmails[index].addListener(() {
      if (!focusNodesEmails[index].hasFocus) {
        if (emailControllers[index].text.isNotEmpty) {
          emailControllersString = emailControllers.map((e) => e.text).toList();
          print(emailControllersString);
        }
      }
    });
  }

  Widget buildEmailTextField(int index) {
    return Row(
      children: [
        Expanded(
          child: CustomTextFormField(
            controller: emailControllers[index],
            focusNode: focusNodesEmails[index],
            title: 'Email',
            titleFontSize: 14,
            hintText: 'Add Email',
            validator: (value) {
              if (value!.isEmpty) {
                return "please enter email";
              }
              return null;
            },
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: InkWell(
            onTap: () {
              int newIndex = emailControllers.length;
              emailControllers.insert(newIndex, TextEditingController());
              focusNodesEmails.insert(newIndex, FocusNode());
              addListenerFocusNodeEmails(newIndex);
              emailTextField.add(buildEmailTextField(newIndex));
              print(emailControllers.map((e) => e.text).toList());
              emit(AddWordsState());
            },
            child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primary),
                    borderRadius: BorderRadius.circular(10)),
                child: const Icon(
                  Icons.add,
                  color: AppColors.primary,
                )),
          ),
        )
      ],
    );
  }

  List<Widget> addressTextField = [];
  List<TextEditingController> addressControllers = [TextEditingController()];
  List<String> addressControllersString = [];
  List<FocusNode> focusNodesAddress = [FocusNode()];

  addListenerFocusNodeAddress(int index) {
    focusNodesAddress[index].addListener(() {
      if (!focusNodesAddress[index].hasFocus) {
        if (addressControllers[index].text.isNotEmpty) {
          addressControllersString =
              addressControllers.map((e) => e.text).toList();
          print(addressControllersString);
        }
      }
    });
  }

  Widget buildAddressTextField(int index) {
    return Row(
      children: [
        Expanded(
          child: CustomTextFormField(
            controller: addressControllers[index],
            focusNode: focusNodesAddress[index],
            title: 'Adress',
            titleFontSize: 14,
            hintText: 'Add Adress',
            validator: (value) {
              if (value!.isEmpty) {
                return "please enter Adress";
              }
              return null;
            },
            suffixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                ImageManager.address,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: InkWell(
            onTap: () {
              int newIndex = addressControllers.length;
              addressControllers.insert(newIndex, TextEditingController());
              focusNodesAddress.insert(newIndex, FocusNode());
              addListenerFocusNodeAddress(newIndex);
              addressTextField.add(buildAddressTextField(newIndex));
              print(addressControllers.map((e) => e.text).toList());
              emit(AddWordsState());
            },
            child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primary),
                    borderRadius: BorderRadius.circular(10)),
                child: const Icon(
                  Icons.add,
                  color: AppColors.primary,
                )),
          ),
        )
      ],
    );
  }

  TextEditingController keyWordsController = TextEditingController();
  TextEditingController linksController = TextEditingController();
  TextEditingController customInputController = TextEditingController();
  final SingleValueDropDownController inputTypeController =
      SingleValueDropDownController();
  List<String> tags = [];
  List<String> links = [];
  List<String> customerInputValue = [];

  void addKeyWords() {
    tags.add(keyWordsController.text);
    print(tags);
    keyWordsController.clear();
    emit(AddWordsState());
  }

  void clearKeyWords(index) {
    tags.removeAt(index);
    print(tags);
    emit(ClearWordsState());
  }

  SingleValueDropDownController platformController =
      SingleValueDropDownController();
  List<Map<String, String>> platformList = [];
  GlobalKey<FormState> settingsFormKey = GlobalKey<FormState>();

  void addLink() {
    if (settingsFormKey.currentState!.validate()) {
      platformList.add({
        'platform': platformController.dropDownValue!.name.toLowerCase(),
        'url': linksController.text,
      });
      print(platformList);
      emit(AddWordsState());
    }
  }

  void clearLink(index) {
    platformList.removeAt(index);
    print(platformList);
    emit(ClearWordsState());
  }

  bool isCustomerOptions = false;
  List customerInput = [];
  void addCustomInput() {
    if (settingsFormKey.currentState!.validate()) {
      if (inputTypeController.dropDownValue!.name == 'select') {
        isCustomerOptions = true;
        customerInput.add(customInputController.text);
        customerInputValue.add(inputTypeController.dropDownValue!.name);
      } else {
        customerInput.add(customInputController.text);
        customerInputValue.add(inputTypeController.dropDownValue!.name);
        addCustomInputs([]);
        customInputController.clear();
        inputTypeController.clearDropDown();
      }
      emit(AddWordsState());
    }
  }

  void clearCustomInput(index) {
    customerInput.removeAt(index);
    customInputs.removeAt(index);
    print(customInputs);
    emit(ClearWordsState());
  }

  bool starRatingValue = false;
  bool generalCommentValue = false;
  bool customerNameValue = false;
  bool customerEmailValue = false;
  bool requiredValue = false;
  List<bool> requiredInputValues = List.generate(10, (index) => false);
  bool thankValue = false;
  TextEditingController thankMessageController = TextEditingController();

  changeStarRatingValue(value) {
    starRatingValue = value;
    emit(ChangeStarRatingValueState());
  }

  changeGeneralCommentValue(value) {
    generalCommentValue = value;
    emit(ChangeStarRatingValueState());
  }

  changeCustomerNameValue(value) {
    customerNameValue = value;
    emit(ChangeStarRatingValueState());
  }

  changeCustomerEmailValue(value) {
    customerEmailValue = value;
    emit(ChangeStarRatingValueState());
  }

  changeThankValue(value) {
    thankValue = value;
    emit(ChangeStarRatingValueState());
  }

  changeInputValue(value, index) {
    requiredInputValues[index] = value;
    requiredValue = requiredInputValues[index];
    print(requiredValue);
    customInputs[index]['required'] = requiredValue;
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

  void onChangePrimary() {
    emit(OnColorChangedState());
  }

  BaseSettingsRepository repo;

  Future createContact() async {
    if (settingsFormKey.currentState!.validate()) {
      emit(ContactsLoadingState());
      final response = await repo.createContacts(
          phones: phoneControllers,
          emails: emailControllersString,
          addresses: addressControllersString,
          socialMedia: platformList);
      response.fold(
        (l) {
          emit(ContactsFailState(message: l.message));
          Logger().e(l.message);
        },
        (r) {
          emit(ContactsSuccessState());
        },
      );
    }
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Future createAboutUs() async {
    if (settingsFormKey.currentState!.validate()) {
      emit(AboutUsLoadingState());
      final response = await repo.createAboutUs(
          name: nameController.text,
          title: titleController.text,
          description: descriptionController.text,
          tags: tags);
      response.fold(
        (l) {
          emit(AboutUsFailState(message: l.message));
          Logger().e(l.message);
        },
        (r) {
          emit(AboutUsSuccessState());
        },
      );
    }
  }

  List<Widget> optionsTextField = [];
  List<TextEditingController> optionsControllers = [TextEditingController()];
  List<String> optionsControllersString = [];
  List<FocusNode> focusNodesOptions = [FocusNode()];

  addListenerFocusNodeOptions(int index) {
    focusNodesOptions[index].addListener(() {
      if (!focusNodesOptions[index].hasFocus) {
        if (optionsControllers[index].text.isNotEmpty) {
          optionsControllersString =
              optionsControllers.map((e) => e.text).toList();
          print('optionsControllersString :$optionsControllersString');
          // customInputs.add({
          //   "inputType": inputTypeController.dropDownValue!.name,
          //   "label": customInputController.text,
          //   "required": '$requiredValue',
          //   "options": optionsControllersString
          // });
          addCustomInputs(optionsControllersString);
          print('vvvvvvvvvv');
          customInputController.clear();
          inputTypeController.clearDropDown();
          //optionsControllers[index].clear();
        }
      }
    });
  }

  Widget buildOptionsTextField(int index) {
    return Row(
      children: [
        SizedBox(
          width: 350,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: CustomTextFormField(
              controller: optionsControllers[index],
              focusNode: focusNodesOptions[index],
              titleFontSize: 14,
              hintText: 'Add Option',
              validator: (value) {
                if (value!.isEmpty) {
                  return "please enter Option";
                }
                return null;
              },
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        InkWell(
          onTap: () {
            int newIndex = optionsControllers.length;
            optionsControllers.insert(newIndex, TextEditingController());
            focusNodesOptions.insert(newIndex, FocusNode());
            optionsTextField.add(buildOptionsTextField(newIndex));
            addListenerFocusNodeOptions(newIndex);
            // print(optionsControllers.map((e) => e.text).toList());
            emit(AddWordsState());
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary),
                borderRadius: BorderRadius.circular(10)),
            child: const Icon(
              Icons.add,
              color: AppColors.primary,
            ),
          ),
        )
      ],
    );
  }

  List<Map<String, dynamic>> customInputs = [];

  void addCustomInputs(optionsControllersString) {
    customInputs.add({
      "inputType": inputTypeController.dropDownValue!.name,
      "label": customInputController.text,
      "required": '$requiredValue',
      "options": optionsControllersString
    });
    emit(AddWordsState());
    // if (settingsFormKey.currentState!.validate()) {
    //   customInputs.add({
    //     "inputType": inputTypeController.dropDownValue!.name,
    //     "label": customInputController.text,
    //     "required": '$requiredValue',
    //     "options": optionsControllersString
    //   });
    //   print(customInputs);
    //   emit(AddWordsState());
    // }
  }

  Future createReviews() async {
    // print('customInputs : $customInputs');

      emit(CreateReviewsLoadingState());
      final response = await repo.createReviews(
          user: Caching.get(key: 'user'),
          starRatingEnabled: '$starRatingValue',
          generalCommentEnabled: '$generalCommentValue',
          customerEmailRequired: '$customerEmailValue',
          customerNameRequired: '$customerNameValue',
          thankYouMessage: thankMessageController.text,
          customInputs: customInputs);
      response.fold(
        (l) {
          emit(CreateReviewsFailState(message: l.message));
          Logger().e(l.message);
        },
        (r) {
          emit(CreateReviewsSuccessState());
        },
      );
    }

}
