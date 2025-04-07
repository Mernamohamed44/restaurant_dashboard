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
import 'package:restaurant_dashboard/features/categories/presentaion/cubit/categories_cubit.dart';
import 'package:restaurant_dashboard/features/menuItem/domain/entities/categories_items_entities.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/cubit/menu_cubit.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/widgets/edit_item_dialog.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/widgets/edit_items_buttons.dart';
import 'package:toastification/toastification.dart';

import '../../../categories/domin/entities/categories_entities.dart';
import '../../../categories/presentaion/widgets/language_drop_down.dart';

class ListItem extends StatelessWidget {
  const ListItem({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () async {
        context.read<MenuCubit>().refreshItems(
              context.read<CategoriesCubit>().categoriesMenu[context.read<CategoriesCubit>().selectedIndex].sId!,
            );
      },
      child: BlocBuilder<MenuCubit, MenuState>(
        builder: (context, state) {
          List<CategoriesItemEntity> itemsCategories = context.read<MenuCubit>().itemsData;
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
              if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
                context.read<MenuCubit>().currentPage++;
                // Trigger load more when near the bottom
                context.read<MenuCubit>().getItemsData(loadMore: true, id: context.read<CategoriesCubit>().categoriesMenu[context.read<CategoriesCubit>().selectedIndex].sId!, items: 'subCategory');
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
                      text: 'No Items',
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
                          menuCubit: context.read<MenuCubit>(),
                          categoriesCubit: context.read<CategoriesCubit>(),
                          //categoriesName: context.read<CategoriesCubit>().categoriesMenu[index].name!,
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
  const ItemsContainer({
    super.key,
    required this.itemsCategories,
    required this.menuCubit,
    required this.categoriesCubit,
  });

  final CategoriesItemEntity itemsCategories;
  final MenuCubit menuCubit;
  final CategoriesCubit categoriesCubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: AppColors.containerColor, borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Row(
              children: [
                ClipOval(
                  child: CustomCachedImage(
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                    image: '${ApiConstants.baseImagesUrl}/${itemsCategories.image}',
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
          PopupMenuButton(
              color: AppColors.white,
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (c) {
                            return MultiBlocProvider(
                              providers: [
                                BlocProvider.value(
                                  value: menuCubit,
                                ),
                                BlocProvider.value(
                                  value: categoriesCubit,
                                ),
                              ],
                              child: EditItemDialog(
                                itemsCategories: itemsCategories,
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
                              value: menuCubit,
                              child: CustomAlert(
                                title: 'Delete Item',
                                body: 'Do You sure delete this Item?',
                                submitWidget: BlocConsumer<MenuCubit, MenuState>(
                                  listener: (context, state) {
                                    if (state is DeleteItemSuccessState) {
                                      showToastificationWidget(
                                        message: 'Item Deleted successfully',
                                        context: context,
                                        notificationType: ToastificationType.success,
                                      );
                                      context.pushReplacementNamed(Routes.menuItem);
                                    }
                                  },
                                  builder: (context, state) {
                                    return TextButton(
                                      onPressed: () {
                                        context.read<MenuCubit>().deleteItem(id: itemsCategories.sId!);
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
    );
  }
}
