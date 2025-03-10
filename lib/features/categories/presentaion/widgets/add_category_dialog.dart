import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/utils/image_manager.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/cubit/categories_cubit.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/widgets/categories_text_feild.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/widgets/language_drop_down.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/widgets/categories_save_button.dart';

class AddCategoryDialog extends StatelessWidget {
  const AddCategoryDialog({super.key, required this.categoriesCubit});
 final CategoriesCubit categoriesCubit;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: categoriesCubit,
      child: Dialog(
        backgroundColor: AppColors.white,
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
                const Divider(
                  color: Color.fromRGBO(115, 129, 141, 0.16),
                ),
                const SizedBox(
                  height: 10,
                ),
                const AddImageContainer(),
                const SizedBox(
                  height: 10,
                ),
                CategoriesTextField(),
                const SizedBox(
                  height: 10,
                ),
                const CategoriesButtonSave()
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
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.primary.withOpacity(.05),
          border: Border.all(color: AppColors.primary)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(ImageManager.addImage),
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
                            context.read<CategoriesCubit>().chooseImage(
                                source: ImageSource.gallery, context: context);
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
  }
}