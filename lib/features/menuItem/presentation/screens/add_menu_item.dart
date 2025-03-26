import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_dashboard/app/dependancy_injection/dependancy_injection.dart';
import 'package:restaurant_dashboard/app/helper/extension.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/cubit/categories_cubit.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/widgets/language_drop_down.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/cubit/menu_cubit.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/widgets/add_menu_item_dialog.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/widgets/category_drop_down.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/widgets/item_description_text_field.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/widgets/super_categories_drop_down.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/widgets/item_price_text_field.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/widgets/menu_item_button_save.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/widgets/name_item_text_field.dart';

class AddMenuItem extends StatelessWidget {
  const AddMenuItem({super.key, required this.categoriesCubit, required this.menuCubit});
  final CategoriesCubit categoriesCubit;
  final MenuCubit menuCubit;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: categoriesCubit,
        ),
        BlocProvider.value(
            value: menuCubit
        ),
      ],
      child: Form(
        key: menuCubit.formKey,
        child: Scaffold(
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
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const AddImageContainer(),
                const SizedBox(
                  height: 10,
                ),
                ItemNameTextField(),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                const CategoriesDropDown(),
                const SizedBox(
                  height: 10,
                ),
                const SubCategoriesDropDown(),
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
      ),
    );
  }
}
