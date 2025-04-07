import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_dashboard/app/helper/extension.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:restaurant_dashboard/features/categories/domin/entities/categories_entities.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/cubit/categories_cubit.dart';

import 'category_list_item.dart';

class ItemsCategoriesList extends StatelessWidget {
  const ItemsCategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(builder: (context, state) {
      final itemsList = context.read<CategoriesCubit>().itemSuperCategories;
      if (state is SuperCategoriesDataFailedState) {
        return CustomText(text: state.message, color: AppColors.primary);
      }
      return Expanded(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: itemsList.length,
            itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ItemCategories(
                    itemSuperCategories: itemsList[index],
                  ),
                )),
      );
    });
  }
}

class ItemCategories extends StatefulWidget {
  const ItemCategories({
    super.key,
    required this.itemSuperCategories,
  });
  final CategoriesChildrenEntity itemSuperCategories;
  @override
  State<ItemCategories> createState() => _ItemCategoriesState();
}

class _ItemCategoriesState extends State<ItemCategories> {
  bool isFoodClicked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomText(
                text: widget.itemSuperCategories.name!,
                color: AppColors.textColor,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  height: 1, // Thickness of the line
                  color: const Color.fromRGBO(115, 129, 141, 0.16),
                ),
              ),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      isFoodClicked = !isFoodClicked;
                    });
                  },
                  child: isFoodClicked
                      ? const Icon(
                          Icons.keyboard_arrow_up,
                          color: AppColors.textColor,
                        )
                      : const Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.textColor,
                        ))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          isFoodClicked
              ? SizedBox(
                  height: 500,
                  child: LayoutBuilder(builder: (context, constraints) {
                    int crossAxisCount;
                    if (context.screenWidth >= 1600) {
                      crossAxisCount = 5;
                    } else if (context.screenWidth >= 1400) {
                      crossAxisCount = 4;
                    } else if (context.screenWidth >= 1000) {
                      crossAxisCount = 3;
                    } else if (context.screenWidth >= 400) {
                      crossAxisCount = 2;
                    } else {
                      crossAxisCount = 1;
                    }
                    return GridView.builder(
                        shrinkWrap: true,
                        itemCount: widget.itemSuperCategories.children.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 15,
                          mainAxisExtent: 80,
                        ),
                        itemBuilder: (context, index) {
                          return BlocBuilder<CategoriesCubit, CategoriesState>(
                            builder: (context, state) {
                              if (widget.itemSuperCategories.children.isEmpty) {
                                return const CustomText(
                                  text: 'No Items',
                                  color: AppColors.primary,
                                  fontSize: 20,
                                );
                              }
                              return CategoryListItem(
                                categoriesCubit: context.read<CategoriesCubit>(),
                                itemSuperCategories: widget.itemSuperCategories.children[index],
                                superCategoryName: widget.itemSuperCategories.name!,
                              );
                            },
                          );
                        });
                  }),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
