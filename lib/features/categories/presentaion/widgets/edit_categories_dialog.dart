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
import 'package:restaurant_dashboard/features/categories/presentaion/widgets/edit_categories_button.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/widgets/language_drop_down.dart';

import '../../../menuItem/presentation/widgets/super_categories_drop_down.dart';

class EditCategoryDialog extends StatefulWidget {
  const EditCategoryDialog({super.key, required this.itemSuperCategories, required this.superCategoryName});
  final CategoriesEntity itemSuperCategories;
  final String superCategoryName;

  @override
  State<EditCategoryDialog> createState() => _EditCategoryDialogState();
}

class _EditCategoryDialogState extends State<EditCategoryDialog> {
  @override
  void initState() {
    context.read<CategoriesCubit>().superCategoryNameController.text = widget.itemSuperCategories.name!;
    context.read<CategoriesCubit>().imageUploaded = widget.itemSuperCategories.image!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      child: Form(
        key: context.read<CategoriesCubit>().formKey,
        child: Container(
          width: 500,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              // Prevents taking full screen height
              children: [
                const Row(
                  children: [
                    CustomText(
                      text: 'Edit Category',
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
                BlocBuilder<CategoriesCubit, CategoriesState>(
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: () {
                        context.read<CategoriesCubit>().pickMemberImageFile(context: context, source: ImageSource.gallery);
                      },
                      child: SizedBox(
                        width: double.infinity,
                        child: DottedBorder(
                          color: AppColors.primary,
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(12),
                          padding: const EdgeInsets.all(16),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                            child: context.read<CategoriesCubit>().myImage != null
                                ? kIsWeb
                                    ? Image.network(
                                        context.read<CategoriesCubit>().myImage!.path,
                                        height: 70,
                                        width: 70,
                                      )
                                    : Image.file(
                                        File(context.read<CategoriesCubit>().myImage!.path),
                                        fit: BoxFit.cover,
                                        height: 70,
                                        width: 70,
                                      )
                                : CustomCachedImage(
                                    fit: BoxFit.fill,
                                    image: '${ApiConstants.baseImagesUrl}/${widget.itemSuperCategories.image}',
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
                  controller: context.read<CategoriesCubit>().superCategoryNameController,
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
                CategoriesDropDown(
                  isEdit: true,
                  superCategoryName: widget.superCategoryName,
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                CategoriesButtonEdit(
                  id: widget.itemSuperCategories.sId!,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
