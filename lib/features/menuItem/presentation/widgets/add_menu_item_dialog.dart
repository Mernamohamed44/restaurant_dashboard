import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/utils/constance.dart';
import 'package:restaurant_dashboard/app/utils/image_manager.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:restaurant_dashboard/app/widget/custom_text_form_field.dart';
import 'package:restaurant_dashboard/app/widget/svg_icons.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/cubit/categories_cubit.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/widgets/language_drop_down.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/widgets/categories_save_button.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/widgets/category_drop_down.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/widgets/item_description_text_field.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/widgets/item_drop_down.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/widgets/item_price_text_field.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/widgets/menu_item_button_save.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/widgets/menu_item_text_field.dart';

class AddMenuItemDialog extends StatelessWidget {
  const AddMenuItemDialog({super.key, required this.categoriesCubit});
  final CategoriesCubit categoriesCubit;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: categoriesCubit,
      child: Dialog(
        child: Container(
          width: 500,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                // Prevents taking full screen height
                children: [
                  const Row(
                    children: [
                      FittedBox(
                        child: CustomText(
                          text: 'New Menu Item',
                          color: AppColors.textColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
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
                  const DeleteImageContainer(),
                  const SizedBox(
                    height: 5,
                  ),
                  MenuItemTextField(),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ItemDropDown(),
                      SizedBox(
                        width: 50,
                      ),
                      CategoryDropDown()
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const ItemDescriptionTextField(),
                  const SizedBox(
                    height: 12,
                  ),
                  const ItemPriceTextField(),
                  const SizedBox(
                    height: 10,
                  ),
                  const MenuItemButtonSave()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DeleteImageContainer extends StatelessWidget {
  const DeleteImageContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: AppColors.containerColor,
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            Image.asset(ImageManager.addImage),
            const SizedBox(
              width: 5,
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'untitled.jpeg',
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
                CustomText(
                  text: '12 MB',
                  color: AppColors.grey73818D99,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ],
            ),
            const Spacer(),
            const CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.white,
                child: SvgIcon(
                  icon: ImageManager.clear,
                  color: AppColors.red,
                  height: 25,
                )),
          ],
        ));
  }
}
