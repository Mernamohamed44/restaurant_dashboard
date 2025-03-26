import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_dashboard/app/helper/extension.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/utils/image_manager.dart';
import 'package:restaurant_dashboard/app/widget/custom_button.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:restaurant_dashboard/app/widget/custom_text_form_field.dart';
import 'package:restaurant_dashboard/app/widget/svg_icons.dart';
import 'package:restaurant_dashboard/features/categories/domin/entities/categories_entities.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/cubit/categories_cubit.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/cubit/menu_cubit.dart';

class SuperCategories extends StatefulWidget {
  const SuperCategories({super.key});

  @override
  State<SuperCategories> createState() => _SuperCategoriesState();
}

class _SuperCategoriesState extends State<SuperCategories> {
  bool isClicked = false;
  TextEditingController superController = TextEditingController();
  List<CategoriesEntity> superCategories = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        final cubit = context.read<CategoriesCubit>();
        superCategories = cubit.superCategories;
        if (state is SuperCategoriesDataLoadingState) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  text: 'Super Categories',
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
                const SizedBox(
                  height: 5,
                ),
                context.screenWidth > 500
                    ? SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...List.generate(
                                superCategories.length,
                                (index) => CategoriesContainer(
                                      number:
                                          superCategories[index].itemsCount!,
                                      text: superCategories[index].name!,
                                    )),
                            isClicked ? buildTextField() : const SizedBox(),
                            const SizedBox(
                              width: 5,
                            ),
                            buildNewButton()
                          ],
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...List.generate(
                              superCategories.length,
                              (index) => CategoriesContainer(
                                    number: superCategories[index].itemsCount!,
                                    text: superCategories[index].name!,
                                  )),
                          const SizedBox(
                            height: 10,
                          ),
                          isClicked ? buildTextField() : const SizedBox(),
                          const SizedBox(
                            height: 10,
                          ),
                          buildNewButton()
                        ],
                      )
              ],
            ),
          );
        }
      },
    );
  }

  Widget buildNewButton() {
    return CustomButton(
      width: context.screenWidth > 500 ? 120 : double.infinity,
      height: 40,
      onTap: () {
        setState(() {
          isClicked = true;
          buildTextField();
          print(isClicked);
        });
      },
      fontColor: AppColors.primary,
      fontSize: 16,
      borderColor: AppColors.primary,
      borderRadius: 20,
      widget: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add, color: AppColors.primary, size: 20),
          SizedBox(
            width: 5,
          ),
          Flexible(
              child: FittedBox(
                  child: CustomText(
                      fontWeight: FontWeight.w700,
                      text: 'New',
                      color: AppColors.primary)))
        ],
      ),
    );
  }

  Widget buildTextField() {
    return SizedBox(
      width: context.screenWidth > 500 ? 120 : double.infinity,
      child: CustomTextFormField(
        textStyle: const TextStyle(fontSize: 12),
        controller: superController,
        borderColor: AppColors.primary,
        //contentPadding: 5,
        borderRadius: 10,
        maxLines: 1,
        suffixIcon: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocConsumer<CategoriesCubit, CategoriesState>(
              listener: (context, state) {
                if (state is AddCategorySuccessState) {
                  context.read<CategoriesCubit>().getSuperCategoriesData();
                }
              },
              builder: (BuildContext context, CategoriesState state) {
                return GestureDetector(
                  onTap: () {
                    print(superController.text);
                    context
                        .read<CategoriesCubit>()
                        .addCategory(name: superController.text);
                    // setState(() {
                    //   categories.add(CategoriesContainer(
                    //       text: itemController.text, number: '4'));
                    //   itemController.clear();
                    // });
                  },
                  child: const CustomText(
                    text: 'save',
                    textAlign: TextAlign.justify,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                );
              },
            ),
          ],
        ),
        title: '',
      ),
    );
  }
}

class CategoriesContainer extends StatelessWidget {
  const CategoriesContainer(
      {super.key, required this.text, required this.number});

  final String text;
  final int number;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: AppColors.containerColor,
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            CustomText(
              text: text,
              color: AppColors.textColor,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            const SizedBox(
              width: 5,
            ),
            CircleAvatar(
              radius: 8,
              backgroundColor: AppColors.palePrimary,
              child: CustomText(
                text: '$number',
                color: AppColors.white,
                fontWeight: FontWeight.w400,
                fontSize: 10,
              ),
            ),
            context.screenWidth > 500
                ? const SizedBox(
                    width: 5,
                  )
                : const Spacer(),
            const SvgIcon(
              icon: ImageManager.dots,
              color: AppColors.textColor,
              height: 15,
            )
          ],
        ),
      ),
    );
  }
}
