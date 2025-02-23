import 'package:bloc/bloc.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:meta/meta.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(AccountInitial());
  bool isObscure = true;
  bool isObscure1 = true;

  void changeVisibility() {
    isObscure = !isObscure;
    emit(ChangeVisibilityState());
  }

  void changeConfirmVisibility() {
    isObscure1 = !isObscure1;
    emit(ChangeConfirmVisibility());
  }

  String phoneNumber = "";
  String number = "";

  onInputChanged(PhoneNumber phone) {
    phoneNumber = "${phone.countryCode}${phone.number}";
    number = phone.number;
    emit(ChangeNumberState());
  }
}
