import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurant_dashboard/app/helper/extension.dart';
import 'package:restaurant_dashboard/app/network/end_points.dart';
import 'package:restaurant_dashboard/app/routing/routes.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/utils/image_manager.dart';
import 'package:restaurant_dashboard/app/widget/custom_alert.dart';
import 'package:restaurant_dashboard/app/widget/custom_cached_image.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:restaurant_dashboard/app/widget/custom_text_form_field.dart';
import 'package:restaurant_dashboard/app/widget/toastification_widget.dart';
import 'package:restaurant_dashboard/features/categories/domin/entities/categories_entities.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/cubit/categories_cubit.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/widgets/edit_categories_button.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/widgets/edit_categories_dialog.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/widgets/language_drop_down.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/widgets/super_categories_drop_down.dart';
import 'package:toastification/toastification.dart';

class CategoryListItem extends StatelessWidget {
  const CategoryListItem({
    super.key,
    required this.itemSuperCategories,
    required this.superCategoryName, required this.categoriesCubit,
  });
  final CategoriesEntity itemSuperCategories;
  final String superCategoryName;
  final CategoriesCubit categoriesCubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: AppColors.containerColor, borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            ClipOval(
              child: CustomCachedImage(
                height: 50,
                width: 50,
                fit: BoxFit.cover,
                image: '${ApiConstants.baseImagesUrl}/${itemSuperCategories.image}',
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: itemSuperCategories.name!,
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomText(
                  text: '${itemSuperCategories.itemsCount} items',
                  color: AppColors.accentContainerColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ],
            ),
            const Spacer(),
            PopupMenuButton(
                color: AppColors.white,
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (c) {
                              return BlocProvider.value(
                                value: categoriesCubit,
                                child: EditCategoryDialog(
                                  superCategoryName: superCategoryName,
                                  itemSuperCategories: itemSuperCategories,
                                ),
                              );
                            });
                      },
                      child: const CustomText(
                        text: 'Edit',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: AppColors.black,
                      ),
                    ),
                    PopupMenuItem(
                      child: const CustomText(
                        text: 'Delete',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: AppColors.red,
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (c) {
                              return BlocProvider.value(
                                value: categoriesCubit,
                                child: CustomAlert(
                                  title: 'Delete Category',
                                  body: 'Do You sure delete this Category?',
                                  submitWidget: BlocConsumer<CategoriesCubit, CategoriesState>(
                                    listener: (context, state) {
                                      if (state is DeleteCategorySuccessState) {
                                        showToastificationWidget(
                                          message: 'Super Category Deleted successfully',
                                          context: context,
                                          notificationType: ToastificationType.success,
                                        );
                                        context.pushReplacementNamed(Routes.category);
                                      }
                                    },
                                    builder: (context, state) {
                                      return TextButton(
                                        onPressed: () {
                                          context.read<CategoriesCubit>().deleteCategory(id: itemSuperCategories.sId!);
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 10),
                                          child: CustomText(
                                            text: "delete",
                                            color: AppColors.red,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            });
                      },
                    ),
                  ];
                },
                child: Image.asset(ImageManager.dotIcon))
          ],
        ),
      ),
    );
  }
}
