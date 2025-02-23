import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_dashboard/app/helper/extension.dart';

import '../../../../app/utils/colors.dart';
import '../../../../app/utils/constance.dart';

class DropDownItem extends StatelessWidget {
  DropDownItem({super.key});

  final SingleValueDropDownController itemController =
      SingleValueDropDownController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenWidth > 500 ? 100 : double.infinity,
      height: 40,
      child: DropDownTextField(
        controller: itemController,
        dropDownIconProperty: IconProperty(
          icon: Icons.keyboard_arrow_down,
          size: 24,
          color: AppColors.textColor,
        ),
        textFieldDecoration: InputDecoration(
          fillColor: AppColors.boldContainerColor,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
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
          hintText: 'Food',
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
          DropDownValueModel(name: 'drinks', value: "value1"),
          DropDownValueModel(name: 'food', value: "value2"),
          DropDownValueModel(
            name: 'sweets',
            value: "value3",
          ),
        ],
      ),
    );
  }
}
