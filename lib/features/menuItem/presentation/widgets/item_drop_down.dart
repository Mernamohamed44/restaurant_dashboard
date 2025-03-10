import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/utils/constance.dart';

class ItemDropDown extends StatelessWidget {
  const ItemDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: DropDownTextField(
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
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              width: 1,
              color: AppColors.transparent,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              width: 1,
              color: AppColors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              width: 1,
              color: AppColors.palePrimary,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              width: 1,
              color: AppColors.red,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
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
