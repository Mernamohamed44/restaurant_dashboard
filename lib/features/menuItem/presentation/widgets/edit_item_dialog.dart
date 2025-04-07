import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurant_dashboard/app/network/end_points.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/widget/custom_cached_image.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:restaurant_dashboard/app/widget/custom_text_form_field.dart';
import 'package:restaurant_dashboard/features/categories/domin/entities/categories_entities.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/cubit/categories_cubit.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/widgets/language_drop_down.dart';
import 'package:restaurant_dashboard/features/menuItem/domain/entities/categories_items_entities.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/cubit/menu_cubit.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/widgets/category_drop_down.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/widgets/edit_items_buttons.dart';

class EditItemDialog extends StatefulWidget {
  const EditItemDialog({super.key, required this.itemsCategories});
  final CategoriesItemEntity itemsCategories;

  @override
  State<EditItemDialog> createState() => _EditItemDialogState();
}

class _EditItemDialogState extends State<EditItemDialog> {
  @override
  void initState() {
    context.read<MenuCubit>().nameController.text = widget.itemsCategories.name!;
    context.read<MenuCubit>().descriptionController.text = widget.itemsCategories.description!;
    context.read<MenuCubit>().priceController.text = widget.itemsCategories.price.toString();
    context.read<MenuCubit>().category = widget.itemsCategories.category.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      child: Container(
        width: 500,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: context.read<MenuCubit>().editFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                // Prevents taking full screen height
                children: [
                  const Row(
                    children: [
                      CustomText(
                        text: 'Edit Item',
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
                  const Divider(
                    color: Color.fromRGBO(115, 129, 141, 0.16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BlocBuilder<MenuCubit, MenuState>(
                    builder: (context, state) {
                      return GestureDetector(
                        onTap: () {
                          context.read<MenuCubit>().pickMemberImageFile(context: context, source: ImageSource.gallery);
                        },
                        child: SizedBox(
                          width: double.infinity,
                          height: 150,
                          child: DottedBorder(
                            color: AppColors.primary,
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(12),
                            padding: const EdgeInsets.all(16),
                            child: Center(
                              child: context.read<MenuCubit>().myImage != null
                                  ? kIsWeb
                                      ? Image.network(
                                          context.read<MenuCubit>().myImage!.path,
                                          height: 70,
                                          width: 100,
                                        )
                                      : Image.file(
                                          File(context.read<MenuCubit>().myImage!.path),
                                          height: 70,
                                          width: 70,
                                        )
                                  : CustomCachedImage(
                                      image: '${ApiConstants.baseImagesUrl}/${widget.itemsCategories.image}',
                                    ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    title: 'Name',
                    controller: context.read<MenuCubit>().nameController,
                    titleFontSize: 14,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Name ';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SubCategoriesDropDown(
                    isEdit: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    title: 'Description',
                    controller: context.read<MenuCubit>().descriptionController,
                    titleFontSize: 14,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Description ';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    title: 'Price',
                    controller: context.read<MenuCubit>().priceController,
                    titleFontSize: 14,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter price ';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MenuButtonEdit(
                    id: widget.itemsCategories.sId!,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
