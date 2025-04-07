import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/utils/constance.dart';
import 'package:restaurant_dashboard/features/categories/domin/entities/categories_entities.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/cubit/categories_cubit.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/cubit/menu_cubit.dart';

class SubCategoriesDropDown extends StatefulWidget {
  const SubCategoriesDropDown({
    super.key,
    this.isEdit = false,
  });
  final bool isEdit;

  @override
  State<SubCategoriesDropDown> createState() => _SubCategoriesDropDownState();
}

class _SubCategoriesDropDownState extends State<SubCategoriesDropDown> {
  SingleValueDropDownController controller = SingleValueDropDownController();
  @override
  void initState() {
    context.read<CategoriesCubit>().categoriesMenu[context.read<CategoriesCubit>().selectedIndex].name;
    if (widget.isEdit) controller.setDropDown(DropDownValueModel(name: context.read<CategoriesCubit>().categoriesMenu[context.read<CategoriesCubit>().selectedIndex].name!, value: 'value'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        List<CategoriesEntity> categories = context.read<CategoriesCubit>().categories;
        List<CategoriesEntity> categoriesMenu = context.read<CategoriesCubit>().categoriesMenu;
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
              hintText: 'Choose Subcategory',
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
              if (widget.isEdit) {
                if (value is DropDownValueModel) {
                  context.read<MenuCubit>().subCategory = value.value;
                }
              } else {
                if (value is DropDownValueModel) {
                  print(value.value);
                  print('cccccccccccccccccccc');
                  context.read<MenuCubit>().subCategory = value.value;
                }
              }
            },
            validator: (value) {
              if (value!.isEmpty) {
                return "please enter subCategory";
              }
              return null;
            },
            clearIconProperty: IconProperty(color: Colors.green),
            dropDownList: widget.isEdit ? categoriesMenu.map((category) => DropDownValueModel(name: category.name!, value: category.sId)).toList() : categories.map((category) => DropDownValueModel(name: category.name!, value: category.sId)).toList(),
          ),
        );
      },
    );
  }
}
