import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_dashboard/app/helper/extension.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/utils/image_manager.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:restaurant_dashboard/app/widget/svg_icons.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/cubit/categories_cubit.dart';
import 'package:restaurant_dashboard/features/menuItem/domain/entities/categories_items_entities.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/cubit/menu_cubit.dart';

class ListItem extends StatelessWidget {
  const ListItem({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () async {
        context.read<MenuCubit>().refreshItems(
              context
                  .read<CategoriesCubit>()
                  .categoriesMenu[context.read<CategoriesCubit>().selectedIndex]
                  .sId!,
            );
      },
      child: BlocBuilder<MenuCubit, MenuState>(
        builder: (context, state) {
          List<CategoriesItemEntity> itemsCategories =
              context.read<MenuCubit>().itemsData;
          if (state is GetItemCategoriesDataFailedState) {
            return Center(
              child: CustomText(
                text: state.message,
                color: Colors.red,
                fontSize: 16,
              ),
            );
          } else {
            scrollController.addListener(() {
              if (scrollController.position.pixels >=
                  scrollController.position.maxScrollExtent - 200) {
                context.read<MenuCubit>().currentPage++;
                // Trigger load more when near the bottom
                context.read<MenuCubit>().getItemsData(
                    loadMore: true,
                    id: context
                        .read<CategoriesCubit>()
                        .categoriesMenu[
                            context.read<CategoriesCubit>().selectedIndex]
                        .sId!,
                    items: 'subCategory');
              }
            });
            return SizedBox(
              height: 600,
              child: LayoutBuilder(builder: (context, constraints) {
                int crossAxisCount;
                if (context.screenWidth >= 1280) {
                  crossAxisCount = 2;
                } else if (context.screenWidth >= 1400) {
                  crossAxisCount = 2;
                } else if (context.screenWidth >= 1000) {
                  crossAxisCount = 2;
                } else if (context.screenWidth >= 400) {
                  crossAxisCount = 2;
                } else {
                  crossAxisCount = 1;
                }
                if (state is NoItemCategoriesDataState) {
                  return const Center(
                    child: CustomText(
                      text: 'No Items Yet',
                      color: AppColors.primary,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                } else {
                  return GridView.builder(
                      itemCount: itemsCategories.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 15,
                        mainAxisExtent: 80,
                      ),
                      itemBuilder: (context, index) {
                        return ItemsContainer(
                          itemsCategories: itemsCategories[index],
                        );
                      });
                }
              }),
            );
          }
        },
      ),
    );
  }
}

class ItemsContainer extends StatelessWidget {
  ItemsContainer({super.key, required this.itemsCategories});
  final CategoriesItemEntity itemsCategories;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: AppColors.containerColor,
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Row(
              children: [
                const CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.boldContainerColor,
                    child: SvgIcon(
                      icon: ImageManager.noImage,
                      color: AppColors.textColor,
                      height: 25,
                    )),
                const SizedBox(
                  width: 5,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: '${itemsCategories.price}',
                        color: AppColors.palePrimary,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                      CustomText(
                        text: itemsCategories.name!,
                        color: AppColors.textColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                      Flexible(
                        child: CustomText(
                          text: itemsCategories.description!,
                          color: AppColors.accentContainerColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          maxLines: 4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Image.asset(ImageManager.dotIcon)
        ],
      ),
    );
  }
}
