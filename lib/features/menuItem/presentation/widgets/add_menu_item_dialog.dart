import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurant_dashboard/app/dependancy_injection/dependancy_injection.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/utils/image_manager.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:restaurant_dashboard/app/widget/svg_icons.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/cubit/categories_cubit.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/widgets/language_drop_down.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/cubit/menu_cubit.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/widgets/category_drop_down.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/widgets/item_description_text_field.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/widgets/super_categories_drop_down.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/widgets/item_price_text_field.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/widgets/menu_item_button_save.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/widgets/name_item_text_field.dart';

class AddMenuItemDialog extends StatelessWidget {
  const AddMenuItemDialog({super.key, required this.categoriesCubit, required this.menuCubit});

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
                    const AddImageContainer(),
                    const SizedBox(
                      height: 5,
                    ),
                    ItemNameTextField(),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CategoriesDropDown(),
                        SizedBox(
                          width: 50,
                        ),
                        SubCategoriesDropDown()
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const ItemDescriptionTextField(),
                    const SizedBox(
                      height: 12,
                    ),
                    const ItemPriceTextField(

                    ),
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
      ),
    );
  }
}

class AddImageContainer extends StatelessWidget {
  const AddImageContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuCubit, MenuState>(
      builder: (context, state) {
        return Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: AppColors.containerColor,
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                InkWell(
                    onTap: () async {
                      await context.read<MenuCubit>().chooseMyImage(
                         );
                    },
                    child: context.read<MenuCubit>().fileBytes == null
                        ? Image.asset(ImageManager.addImage)
                        : Image.memory(
                      context.read<MenuCubit>().fileBytes!,
                            height: 70,
                            width: 70,
                           ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: context.read<MenuCubit>().imageUploaded == ''
                            ? 'Image Name'
                            : context.read<MenuCubit>().imageUploaded,
                        color: AppColors.textColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        maxLines: 4,
                      ),
                    ],
                  ),
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
      },
    );
  }
}
