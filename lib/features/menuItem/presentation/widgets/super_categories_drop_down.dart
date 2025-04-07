import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/utils/constance.dart';
import 'package:restaurant_dashboard/features/categories/domin/entities/categories_entities.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/cubit/categories_cubit.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/cubit/menu_cubit.dart';

class CategoriesDropDown extends StatefulWidget {
  const CategoriesDropDown({super.key, this.isEdit = false, this.superCategoryName = ''});
  final bool isEdit;
  final String superCategoryName;

  @override
  State<CategoriesDropDown> createState() => _CategoriesDropDownState();
}

class _CategoriesDropDownState extends State<CategoriesDropDown> {
  SingleValueDropDownController controller = SingleValueDropDownController();
  @override
  void initState() {
    controller.setDropDown(DropDownValueModel(name: widget.superCategoryName, value: 'value'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        List<CategoriesEntity> superCategories = context.read<CategoriesCubit>().superCategories;
        return Flexible(
          child: DropDownTextField(
            controller: controller,
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
              hintText: widget.isEdit ? widget.superCategoryName : 'Choose category',
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
                if (widget.isEdit) {
                  context.read<CategoriesCubit>().parent = value.value;
                  print(context.read<CategoriesCubit>().parent);
                } else {
                  print(value.value);
                  context.read<MenuCubit>().category = value.value;
                  context.read<CategoriesCubit>().parent = value.value;
                  context.read<CategoriesCubit>().getCategoriesData(parent: value.value);
                }
                //     .whenComplete(() {
                //   print('xxxxxxxxxxxxx');
                //   if (context.read<CategoriesCubit>().categoriesMenu.isNotEmpty) {
                //     context.read<MenuCubit>().getItemsData(
                //         id: context.read<CategoriesCubit>().categoriesMenu[0].sId!,
                //         items: 'subCategory');
                //   }
                // });
              }
            },
            validator: (value) {
              if (value!.isEmpty) {
                return "please enter category";
              }
              return null;
            },
            clearIconProperty: IconProperty(color: Colors.green),
            dropDownList: superCategories.map((category) => DropDownValueModel(name: category.name!, value: category.sId)).toList(),
          ),
        );
      },
    );
  }
}
