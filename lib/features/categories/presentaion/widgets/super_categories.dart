import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_dashboard/app/helper/extension.dart';
import 'package:restaurant_dashboard/app/routing/routes.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/utils/image_manager.dart';
import 'package:restaurant_dashboard/app/widget/custom_alert.dart';
import 'package:restaurant_dashboard/app/widget/custom_button.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:restaurant_dashboard/app/widget/custom_text_form_field.dart';
import 'package:restaurant_dashboard/app/widget/svg_icons.dart';
import 'package:restaurant_dashboard/app/widget/toastification_widget.dart';
import 'package:restaurant_dashboard/features/categories/domin/entities/categories_entities.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/cubit/categories_cubit.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/widgets/edit_categories_button.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/widgets/edit_dialog_super_category.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/widgets/language_drop_down.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/cubit/menu_cubit.dart';
import 'package:toastification/toastification.dart';

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
                                  categoriesCubit:cubit ,
                                      number: superCategories[index].itemsCount!,
                                      text: superCategories[index].name!,
                                      id: superCategories[index].sId!,
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
                                categoriesCubit: cubit,
                                    number: superCategories[index].itemsCount!,
                                    text: superCategories[index].name!,
                                    id: superCategories[index].sId!,
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
          Flexible(child: FittedBox(child: CustomText(fontWeight: FontWeight.w700, text: 'New', color: AppColors.primary)))
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
                  context.read<CategoriesCubit>().getItemSuperCategoriesData();
                }
              },
              builder: (BuildContext context, CategoriesState state) {
                return GestureDetector(
                  onTap: () {
                    print(superController.text);
                    context.read<CategoriesCubit>().addCategory(name: superController.text, context: context);
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

class CategoriesContainer extends StatefulWidget {
  const CategoriesContainer({super.key, required this.text, required this.number, required this.id, required this.categoriesCubit});

  final String text;
  final CategoriesCubit categoriesCubit;
  final int number;
  final String id;

  @override
  State<CategoriesContainer> createState() => _CategoriesContainerState();
}

class _CategoriesContainerState extends State<CategoriesContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: AppColors.containerColor, borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            CustomText(
              text: widget.text,
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
                text: '${widget.number}',
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
                              value: widget.categoriesCubit,
                              child: EditSuperCategory(
                                categoryId: widget.id,
                                text: widget.text,
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
                              value: widget.categoriesCubit,
                              child: CustomAlert(
                                title: ' Delete  Super Category',
                                body: 'Do You sure delete this Super Category?',
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
                                        context.read<CategoriesCubit>().deleteCategory(id: widget.id);
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
              child: const SvgIcon(
                icon: ImageManager.dots,
                color: AppColors.textColor,
                height: 15,
              ),
            )
          ],
        ),
      ),
    );
  }
}
