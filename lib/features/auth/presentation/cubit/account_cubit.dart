import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:logger/logger.dart';
import 'package:restaurant_dashboard/app/caching/shared_prefs.dart';
import 'package:restaurant_dashboard/app/helper/image_services.dart';
import 'package:restaurant_dashboard/app/widget/toastification_widget.dart';
import 'package:restaurant_dashboard/features/auth/domain/entities/user_data_entity.dart';
import 'package:restaurant_dashboard/features/auth/domain/repository/base_auth_repository.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit(this.repo) : super(AccountInitial());
  bool isObscure = true;
  bool isObscure1 = true;
  bool isObscure2 = true;

  void changeVisibility() {
    isObscure = !isObscure;
    emit(ChangeVisibilityState());
  }

  void changeNewPasswordVisibility() {
    isObscure2 = !isObscure2;
    emit(ChangeVisibilityState());
  }

  void changeConfirmVisibility() {
    isObscure1 = !isObscure1;
    emit(ChangeConfirmVisibility());
  }

  String phoneNumber = "";
  String number = "";
  String isoCode = "";

  onInputChanged(PhoneNumber phone) {
    phoneNumber = "${phone.countryCode}${phone.number}";
    isoCode = phone.countryCode;
    number = phone.number;
    emit(ChangeNumberState());
  }

  final BaseAuthRepository repo;
  UserDataEntity? user;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future getUserData() async {
    emit(UserDataLoadingState());
    final response = await repo.getUserData();
    response.fold(
      (l) {
        emit(UserDataFailState(message: l.message));
        Logger().e(l.message);
      },
      (r) async {
        user = r;
        nameController.text = user!.displayName!;
        emailController.text = user!.username!;
        Caching.put(key: "image", value:user!.image);
        final phoneNumberData = PhoneNumber.fromCompleteNumber(completeNumber: "${user?.phone}");
        isoCode = phoneNumberData.countryISOCode;
        phoneNumber = phoneNumberData.number;
        phoneController = TextEditingController(text: phoneNumber);
        emit(UserDataSuccessState());
      },
    );
  }

  bool isUsernameAvailable = false;

  Future<void> checkUsername() async {
    emit(CheckUserLoadingState());

    final response = await repo.checkUsername(
      username: emailController.text,
    );
    response.fold(
      (l) {
        emit(CheckUserFailState(message: l.message));
      },
      (r) {
        isUsernameAvailable = r;
        emit(CheckUserSuccessState());
      },
    );
  }

  Future<void> changePassword() async {
    emit(ChangePasswordLoadingState());
    final response = await repo.changePassword(
      oldPassword: oldPasswordController.text,
      newPassword: newPasswordController.text,
      confirmPassword: confirmPasswordController.text,
    );
    response.fold(
      (l) {
        emit(ChangePasswordFailState(message: l.message));
      },
      (r) {
        emit(ChangePasswordSuccessState());
      },
    );
  }

  XFile? myImage;
  String imageUploaded = "";
  final formKey = GlobalKey<FormState>();

  Future<void> editProfile(BuildContext context) async {
    if ( phoneNumber.isNotEmpty && nameController.text.isNotEmpty && emailController.text.isNotEmpty) {
      emit(EditProfileLoadingState());
      try {
        if (myImage != null) {
          if (kIsWeb) {
            imageUploaded = await ImagesService.uploadImageWeb(myImage!);
          } else {
            imageUploaded = await ImagesService.uploadImage(myImage!.path);
          }
        }
      } on Exception catch (e) {
        emit(EditProfileFailState(message: e.toString()));
        return;
      }
      final response = await repo.editProfile(
        phone: phoneNumber,
        image: imageUploaded,
        displayName: nameController.text,
        username: emailController.text,
      );
      response.fold(
        (l) {
          emit(EditProfileFailState(message: l.message));
        },
        (r) {
          emit(EditProfileSuccessState());
        },
      );
    }
    else{
      showToastificationWidget(
        context: context,
        message: "All field is required",
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
}
