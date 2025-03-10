import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/utils/constance.dart';
import 'package:restaurant_dashboard/app/widget/svg_icons.dart';

import '../../../../app/utils/image_manager.dart';

class LanguageDropDown extends StatelessWidget {
  const LanguageDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    return DropDownTextField(
      dropDownIconProperty: IconProperty(
        icon: Icons.keyboard_arrow_down,
        size: 24,
        color: AppColors.textColor,
      ),
      textFieldDecoration: InputDecoration(
        prefixIcon: const Padding(
          padding: EdgeInsets.all(10),
          child: SvgIcon(
            icon: ImageManager.language,
            color: AppColors.accentContainerColor,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: 1,
            color: AppColors.transparent,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: 1,
            color: AppColors.transparent,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: 1,
            color: AppColors.palePrimary,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: 1,
            color: AppColors.red,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: 1,
            color: AppColors.red,
          ),
        ),
        hintText: 'English',
        hintStyle: const TextStyle(
          color: AppColors.textColor,
          fontWeight: FontWeight.w700,
          fontSize: 14,
          fontFamily: AppConstance.appFontName,
        ),
        errorStyle: const TextStyle(
          color: AppColors.red,
          fontWeight: FontWeight.w400,
          fontSize: 12,
          fontFamily: AppConstance.appFontName,
        ),
      ),
      clearOption: true,
      clearIconProperty: IconProperty(color: Colors.green),
      dropDownList: const [
        DropDownValueModel(name: 'English', value: "value1"),
        DropDownValueModel(name: 'Arabic', value: "value2"),
      ],
    );
  }
}
