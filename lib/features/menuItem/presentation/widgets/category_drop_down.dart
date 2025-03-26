import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/utils/constance.dart';
import 'package:restaurant_dashboard/features/categories/domin/entities/categories_entities.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/cubit/categories_cubit.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/cubit/menu_cubit.dart';

class SubCategoriesDropDown extends StatelessWidget {
  const SubCategoriesDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        List<CategoriesEntity> categories =
            context.read<CategoriesCubit>().categories;
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
              hintText:  'Choose Subcategory',
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
            onChanged: (value) {
              if (value is DropDownValueModel) {
                print(value.value);
                print('cccccccccccccccccccc');
                context.read<MenuCubit>().subCategory = value.value;
              }
            },
            validator: (value) {
              if (value!.isEmpty) {
                return "please enter subCategory";
              }
              return null;
            },
            clearIconProperty: IconProperty(color: Colors.green),
            dropDownList: categories
                .map((category) => DropDownValueModel(
                name: category.name!, value: category.sId))
                .toList(),
          ),
        );
      },
    );
  }
}
