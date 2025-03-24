import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_dashboard/app/dependancy_injection/dependancy_injection.dart';
import 'package:restaurant_dashboard/app/helper/extension.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/cubit/categories_cubit.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/widgets/language_drop_down.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/widgets/add_menu_item_dialog.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/widgets/category_drop_down.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/widgets/item_description_text_field.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/widgets/item_drop_down.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/widgets/item_price_text_field.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/widgets/menu_item_button_save.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/widgets/menu_item_text_field.dart';

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
        create: (context) => getIt<CategoriesCubit>(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const DeleteImageContainer(),
              const SizedBox(
                height: 10,
              ),
              MenuItemTextField(),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              const ItemDropDown(),
              const SizedBox(
                height: 10,
              ),
              const CategoryDropDown(),
              const SizedBox(
                height: 10,
              ),
              const ItemDescriptionTextField(),
              const SizedBox(
                height: 10,
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
    );
  }
}
