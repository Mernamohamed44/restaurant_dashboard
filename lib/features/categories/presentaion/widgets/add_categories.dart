import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_dashboard/app/dependancy_injection/dependancy_injection.dart';
import 'package:restaurant_dashboard/app/helper/extension.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/cubit/categories_cubit.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/widgets/categories_save_button.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/widgets/categories_text_feild.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/widgets/language_drop_down.dart';

import '../../../../app/utils/colors.dart';
import '../../../settings/presentation/screens/theme_setting.dart';

class AddCategories extends StatelessWidget {
  const AddCategories({super.key});

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
      body: BlocProvider(
        create: (context) => getIt<CategoriesCubit>(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const AddImageContainer(),
              const SizedBox(
                height: 10,
              ),
              CategoriesTextField(),
              const SizedBox(
                height: 10,
              ),
              const CategoriesButtonSave()
            ],
          ),
        ),
      ),
    );
  }
}
