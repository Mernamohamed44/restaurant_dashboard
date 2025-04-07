import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_dashboard/app/dependancy_injection/dependancy_injection.dart';
import 'package:restaurant_dashboard/app/helper/extension.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/cubit/categories_cubit.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/widgets/add_category_dialog.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/widgets/categories_save_button.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/widgets/category_name_text_feild.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/widgets/language_drop_down.dart';

import '../../../../app/utils/colors.dart';

class AddCategories extends StatefulWidget {
  const AddCategories({super.key});

  @override
  State<AddCategories> createState() => _AddCategoriesState();
}

class _AddCategoriesState extends State<AddCategories> {
  @override
  void initState() {
// dispose controller
    context.read<CategoriesCubit>().categoryNameController.clear();
    context.read<CategoriesCubit>().myImage = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
          backgroundColor: AppColors.white,
          title: const CustomText(
            text: 'New Category',
            color: AppColors.textColor,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
          actions: const [
            SizedBox(
              width: 150,
              height: 40,
              child: LanguageDropDown(),
            ),
          ],
          leadingWidth: 20,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_outlined,
              size: 23,
              color: AppColors.textColor,
            ),
            color: AppColors.textColor,
            onPressed: () {
              MagicRouter.pop();
            },
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
          )),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            AddImageContainer(),
            SizedBox(
              height: 10,
            ),
            CategoryNameTextField(),
            SizedBox(
              height: 10,
            ),
            CategoriesButtonSave()
          ],
        ),
      ),
    );
  }
}
