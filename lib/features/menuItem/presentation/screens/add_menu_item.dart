import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_dashboard/app/helper/extension.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/utils/constance.dart';
import 'package:restaurant_dashboard/app/utils/image_manager.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:restaurant_dashboard/app/widget/custom_text_form_field.dart';
import 'package:restaurant_dashboard/app/widget/svg_icons.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/cubit/categories_cubit.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/widgets/save_button.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/screens/menu_item_screen.dart';

import '../../../categories/presentaion/widgets/categories_text_feild.dart';

class AddMemnuItem extends StatelessWidget {
  const AddMemnuItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
          backgroundColor: AppColors.white,
          title: const CustomText(
            text: 'New Menu Item',
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
            icon: const Icon(
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
              const DeleteImageContainer(),
              const SizedBox(
                height: 10,
              ),
              CategoriesTextField(),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                height: 40,
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
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        width: 1,
                        color: AppColors.transparent,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        width: 1,
                        color: AppColors.transparent,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        width: 1,
                        color: AppColors.palePrimary,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        width: 1,
                        color: AppColors.red,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
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
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                height: 40,
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
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        width: 1,
                        color: AppColors.transparent,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        width: 1,
                        color: AppColors.transparent,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        width: 1,
                        color: AppColors.palePrimary,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        width: 1,
                        color: AppColors.red,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        width: 1,
                        color: AppColors.red,
                      ),
                    ),
                    hintText: 'New category',
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
              ),
              const SizedBox(
                height: 10,
              ),
              const CustomTextFormField(
                title: 'Item Description ( local: English )',
                titleFontSize: 14,
                borderColor: AppColors.containerColor,
                maxLines: 2,
              ),
              const SizedBox(
                height: 10,
              ),
              const CustomTextFormField(
                title: 'Item Price',
                titleFontSize: 14,
                borderColor: AppColors.containerColor,
                maxLines: 1,
              ),
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
