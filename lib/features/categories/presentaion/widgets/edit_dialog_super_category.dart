import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:restaurant_dashboard/app/widget/custom_text_form_field.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/cubit/categories_cubit.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/widgets/edit_categories_button.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/widgets/language_drop_down.dart';

class EditSuperCategory extends StatefulWidget {
  const EditSuperCategory({super.key, required this.categoryId, required this.text});
  final String categoryId;
  final String text;

  @override
  State<EditSuperCategory> createState() => _EditSuperCategoryState();
}

class _EditSuperCategoryState extends State<EditSuperCategory> {
  @override
  void initState() {
    context.read<CategoriesCubit>().superCategoryNameController.text = widget.text;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      child: Form(
        key: context.read<CategoriesCubit>().formKey,
        child: Container(
          width: 500,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              // Prevents taking full screen height
              children: [
                const Row(
                  children: [
                    CustomText(
                      text: 'Edit Category',
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                    Spacer(),
                    Flexible(
                      child: LanguageDropDown(),
                    ),
                  ],
                ),
                const Divider(
                  color: Color.fromRGBO(115, 129, 141, 0.16),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  title: 'Name',
                  controller: context.read<CategoriesCubit>().superCategoryNameController,
                  titleFontSize: 14,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Name ';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CategoriesButtonEdit(
                  id: widget.categoryId,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
