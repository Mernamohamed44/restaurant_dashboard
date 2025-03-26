import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_dashboard/app/helper/extension.dart';
import 'package:restaurant_dashboard/features/categories/domin/entities/categories_entities.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/cubit/categories_cubit.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/cubit/menu_cubit.dart';

import '../../../../app/utils/colors.dart';
import '../../../../app/utils/constance.dart';

class DropDownItem extends StatelessWidget {
  DropDownItem({super.key});

  List<CategoriesEntity> superCategories = [];
  final SingleValueDropDownController itemController =
      SingleValueDropDownController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenWidth > 500 ? 150 : double.infinity,
      height: 40,
      child: BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, state) {
          superCategories = context.read<CategoriesCubit>().superCategories;
          return DropDownTextField(
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
              hintText: superCategories.isNotEmpty
                  ? superCategories[0].name
                  : 'Choose category',
              hintStyle: const TextStyle(
                color: AppColors.textColor,
                fontWeight: FontWeight.w700,
                fontSize: 12,
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
            onChanged: (value) {
              if (value is DropDownValueModel) {
                print(value.value);
                print('cccccccccccccccccccc');
                context.read<CategoriesCubit>().changeSelectedIndex(0);
                context
                    .read<CategoriesCubit>()
                    .getCategoriesDataForMenu(parent: value.value)
                    .whenComplete(() {
                  print('xxxxxxxxxxxxx');

                  if (context.read<CategoriesCubit>().categoriesMenu.isNotEmpty) {
                    context.read<MenuCubit>().getItemsData(
                        id: context.read<CategoriesCubit>().categoriesMenu[0].sId!,
                        items: 'subCategory');
                  }
                });
              }
            },
            clearIconProperty: IconProperty(color: Colors.green),
            dropDownList: superCategories
                .map((category) => DropDownValueModel(
                    name: category.name!, value: category.sId))
                .toList(),
          );
        },
      ),
    );
  }
}
