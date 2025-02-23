import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_dashboard/app/helper/extension.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:restaurant_dashboard/app/widget/svg_icons.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/cubit/categories_cubit.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/screens/categories_screen.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/widgets/categories_text_feild.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/widgets/save_button.dart';

import '../../../../app/utils/colors.dart';
import '../../../../app/utils/constance.dart';
import '../../../../app/utils/image_manager.dart';

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
          actions: [
            SizedBox(
              width: 150,
              height: 40,
              child: DropDownTextField(
                dropDownIconProperty: IconProperty(
                  icon: Icons.keyboard_arrow_down,
                  size: 24,
                  color: AppColors.textColor,
                ),
                textFieldDecoration: InputDecoration(
                  // fillColor: AppColors.boldContainerColor,
                  // filled: true,
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
              ),
            ),
          ],
          leadingWidth: 20,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_outlined,
              size: 20,
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
        create: (context) => CategoriesCubit(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              AddImageContainer(),
              const SizedBox(
                height: 10,
              ),
              CategoriesTextField(),
              const SizedBox(
                height: 10,
              ),
              const ButtonSave()
            ],
          ),
        ),
      ),
    );
  }
}
