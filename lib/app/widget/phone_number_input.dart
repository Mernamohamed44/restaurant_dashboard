import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/utils/constance.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';

class PhoneNumberInput extends StatelessWidget {
  const PhoneNumberInput({
    Key? key,
    required this.onInputChanged,
    this.validator,
    this.isLastInput = false,
    this.readOnly = false,
    this.hint = "123 456-7890",
    this.isoCode = "EG",
    this.autoValidate = AutovalidateMode.onUserInteraction,
    this.onTap,
    required this.title,
    this.titleColor,
    this.titleFontSize = 13,
    this.titleFontWeight,
    this.controller,
  }) : super(key: key);
  final Function(PhoneNumber)? onInputChanged;
  final FutureOr<String?> Function(PhoneNumber?)? validator;
  final bool isLastInput, readOnly;
  final String hint;
  final String title;
  final Color? titleColor;
  final double titleFontSize;
  final FontWeight? titleFontWeight;
  final TextEditingController? controller;

  final String? isoCode;
  final AutovalidateMode autoValidate;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: CustomText(
              text: title,
              color: titleColor ?? AppColors.accentContainerColor,
              fontSize: titleFontSize,
              fontWeight: titleFontWeight ?? FontWeight.w600,
            ),
          ),
        IntlPhoneField(
          readOnly: readOnly,
          controller: controller,
          onTap: onTap,
          initialCountryCode: isoCode,
          onChanged: onInputChanged,
          validator: validator ??
              (value) {
                if (value!.number.isEmpty) {
                  return "Enter Phone";
                }
                return null;
              },
          invalidNumberMessage: "Enter Correct phone",
          autovalidateMode: autoValidate,
          dropdownIconPosition: IconPosition.trailing,
          style: const TextStyle(
            color: AppColors.black,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            fontFamily: AppConstance.appFontName,
          ),
          textInputAction:
              isLastInput ? TextInputAction.done : TextInputAction.next,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          dropdownIcon: const Icon(
            Icons.keyboard_arrow_down,
            color: Color(0xff7F7F7F),
            size: 30,
          ),
          flagsButtonPadding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFF0EFEF).withOpacity(0.3),
              contentPadding: const EdgeInsets.symmetric(vertical: 15),
              counterStyle: const TextStyle(fontSize: 0),
              enabled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  width: 1,
                  color: AppColors.grey73818D.withOpacity(.16),
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  width: 1,
                  color: AppColors.grey73818D.withOpacity(.16),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(
                  width: 1,
                  color: AppColors.primary,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(
                  width: 1,
                  color: AppColors.primary,
                ),
              ),
              hintText: hint,
              hintStyle: const TextStyle(
                color: AppColors.accentContainerColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: AppConstance.appFontName,
              )),
        ),
      ],
    );
  }
}
