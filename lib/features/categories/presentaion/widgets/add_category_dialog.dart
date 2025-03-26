import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurant_dashboard/app/dependancy_injection/dependancy_injection.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/utils/image_manager.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/cubit/categories_cubit.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/widgets/categories_save_button.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/widgets/category_name_text_feild.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/widgets/language_drop_down.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/cubit/menu_cubit.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/widgets/super_categories_drop_down.dart';

class AddCategoryDialog extends StatelessWidget {
  const AddCategoryDialog({super.key, required this.categoriesCubit});

  final CategoriesCubit categoriesCubit;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
  providers: [
    BlocProvider.value(
      value: categoriesCubit,
),
    BlocProvider(
      create: (context) => getIt<MenuCubit>(),
    ),
  ],
  child: Dialog(
        backgroundColor: AppColors.white,
        child: Container(
          width: 500,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.white,
          ),
          child: const Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              // Prevents taking full screen height
              children: [
                Row(
                  children: [
                    CustomText(
                      text: 'New Category',
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
                Divider(
                  color: Color.fromRGBO(115, 129, 141, 0.16),
                ),
                SizedBox(
                  height: 10,
                ),
                CategoriesDropDown(),
                SizedBox(
                  height: 10,
                ),
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
        ),
      ),
);
  }
}

class AddImageContainer extends StatelessWidget {
  const AddImageContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
  builder: (context, state) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.primary.withOpacity(.05),
          border: Border.all(color: AppColors.primary)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          context.read<CategoriesCubit>().myImage == null
          ? Image.asset(ImageManager.addImage)
          : Image.memory(
            height: 70,
              width: 70,
              context.read<CategoriesCubit>().fileBytes!

          ),
          const SizedBox(
            width: 5,
          ),
          Flexible(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  text: 'Category Image',
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
                RichText(
                  maxLines: 4,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Click here',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.read<CategoriesCubit>().chooseMyImage(
                                );
                            print("Clicked!");
                          },
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          // Make it bold
                          color: AppColors.primary,
                          // Make it look like a link
                          decoration: TextDecoration
                              .underline, // Optional: underline effect
                        ),
                      ),
                      const TextSpan(
                        text:
                            ' to upload an image, min height 100px, these extensions are acceptable .svg, .png, .jpeg',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors
                              .accentContainerColor, // Normal text color
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  },
);
  }
}
