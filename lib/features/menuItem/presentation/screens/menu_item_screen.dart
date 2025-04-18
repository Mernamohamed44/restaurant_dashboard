import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_dashboard/app/dependancy_injection/dependancy_injection.dart';
import 'package:restaurant_dashboard/app/flutter_admin_scaffold/admin_scaffold.dart';
import 'package:restaurant_dashboard/app/helper/extension.dart';
import 'package:restaurant_dashboard/app/routing/routes.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/widget/custom_button.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:restaurant_dashboard/features/categories/domin/entities/categories_entities.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/cubit/categories_cubit.dart';
import 'package:restaurant_dashboard/features/menuItem/domain/entities/categories_items_entities.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/cubit/menu_cubit.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/screens/add_menu_item.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/widgets/add_menu_item_dialog.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/widgets/drop_down_items.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/widgets/items_container.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/widgets/menu_item_container.dart';
import 'package:restaurant_dashboard/features/side_bar.dart';

import '../../../../app/utils/image_manager.dart';
import '../../../../app/widget/custom_text_form_field.dart';
import '../../../../app/widget/svg_icons.dart';

class MenuItemScreen extends StatelessWidget {
  const MenuItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<CategoriesCubit>()),
        BlocProvider(create: (context) => getIt<MenuCubit>()),
      ],
      child: const MenuItemBody(),
    );
  }
}

class MenuItemBody extends StatefulWidget {
  const MenuItemBody({super.key});

  @override
  State<MenuItemBody> createState() => _MenuItemBodyState();
}

class _MenuItemBodyState extends State<MenuItemBody> {
  @override
  void initState() {
    context.read<CategoriesCubit>().getSuperCategoriesData().whenComplete(() {
      if (context.read<CategoriesCubit>().superCategories.isNotEmpty) {
        context.read<CategoriesCubit>().getCategoriesDataForMenu(parent: context.read<CategoriesCubit>().superCategories[0].sId!).whenComplete(() {
          if (context.read<CategoriesCubit>().categoriesMenu.isNotEmpty) {
            context.read<MenuCubit>().getItemsData(id: context.read<CategoriesCubit>().categoriesMenu[0].sId!, items: 'subCategory');
          }
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SideBarWidget sideBar = SideBarWidget();
    final adminScaffoldKey = GlobalKey<AdminScaffoldState>();
    return AdminScaffold(
        sideBar: sideBar.sideBarMenus(context, Routes.menuItem),
        key: adminScaffoldKey,
        body: Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            toolbarHeight: 68,
            backgroundColor: AppColors.white,
            leadingWidth: 30,
            leading: context.screenWidth < 377
                ? Center(
                    child: InkWell(
                      onTap: () {
                        adminScaffoldKey.currentState!.toggleSidebar();
                      },
                      splashColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: const SvgIcon(
                        height: 20,
                        color: AppColors.textColor,
                        icon: ImageManager.drawerIcon,
                      ),
                    ),
                  )
                : const SizedBox(),
            titleSpacing: 5,
            title: const CustomText(
              text: 'Menu Items',
              color: AppColors.textColor,
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: context.screenWidth < 500
                    ? const Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: CircleAvatar(
                            radius: 20,
                            backgroundColor: AppColors.boldContainerColor,
                            child: SvgIcon(
                              icon: ImageManager.search,
                              color: AppColors.textColor,
                              height: 20,
                            )),
                      )
                    : SizedBox(
                        width: 200,
                        child: CustomTextFormField(
                          borderColor: AppColors.containerColor,
                          controller: context.read<MenuCubit>().searchController,
                          onFieldSubmitted: (value) {
                            context.read<MenuCubit>().getItemsData(items: 'subCategory', id: context.read<CategoriesCubit>().selectedCategory);
                          },
                          hintText: 'Search',
                          hintFontSize: 14,
                          filledColor: AppColors.boldContainerColor,
                          prefixIcon: GestureDetector(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.all(10),
                              child: SvgIcon(
                                icon: ImageManager.search,
                                color: AppColors.textColor,
                              ),
                            ),
                          ),
                        ),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CustomButton(
                  width: 130,
                  height: 40,
                  borderRadius: 25,
                  borderColor: AppColors.transparent,
                  isGradient: true,
                  widget: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: AppColors.white, size: 20),
                      SizedBox(
                        width: 5,
                      ),
                      Flexible(child: FittedBox(child: CustomText(text: 'New Item', color: Colors.white)))
                    ],
                  ),
                  onTap: context.screenWidth > 600
                      ? () {
                          showDialog(
                              context: context,
                              builder: (c) {
                                return AddMenuItemDialog(
                                  categoriesCubit: context.read<CategoriesCubit>(),
                                  menuCubit: context.read<MenuCubit>(),
                                );
                              });
                        }
                      : () => MagicRouter.navigateTo(
                              page: AddMenuItem(
                            categoriesCubit: context.read<CategoriesCubit>(),
                            menuCubit: context.read<MenuCubit>(),
                          )),
                ),
              )
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(
                color: const Color.fromRGBO(115, 129, 141, 0.16),
                height: 1,
              ),
            ),
          ),
          body: BlocBuilder<CategoriesCubit, CategoriesState>(
            builder: (context, state) {
              if (state is SuperCategoriesDataLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                );
              } else {
                return SingleChildScrollView(
                  child: context.screenWidth < 500 ? const MenuItemColumn() : const MenuItemRow(),
                );
              }
            },
          ),
        ));
  }
}

class MenuItemRow extends StatelessWidget {
  const MenuItemRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              DropDownItem(),
              const SizedBox(width: 20),
              const Expanded(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: ItemsMenuList(),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const CustomText(
                text: 'Items',
                color: AppColors.textColor,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  height: 1, // Thickness of the line
                  color: const Color.fromRGBO(115, 129, 141, 0.16),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const ListItem()
        ],
      ),
    );
  }
}

class ItemsMenuList extends StatefulWidget {
  const ItemsMenuList({super.key});

  @override
  State<ItemsMenuList> createState() => _ItemsMenuListState();
}

class _ItemsMenuListState extends State<ItemsMenuList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        List<CategoriesEntity> categories = context.read<CategoriesCubit>().categoriesMenu;
        return Row(
          children: [
            ...List.generate(
                categories.length,
                (index) => GestureDetector(
                    onTap: () {
                      context.read<CategoriesCubit>().changeSelectedIndex(index);
                      context.read<CategoriesCubit>().selectedCategory = categories[index].sId!;
                      context.read<MenuCubit>().getItemsData(items: 'subCategory', id: context.read<CategoriesCubit>().selectedCategory);
                    },
                    child: MenuItemContainer(
                      text: categories[index].name!,
                      isSelected: context.read<CategoriesCubit>().selectedIndex == index ? true : false,
                    )))
          ],
        );
      },
    );
  }
}

class MenuItemColumn extends StatelessWidget {
  const MenuItemColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          DropDownItem(),
          const SizedBox(
            height: 10,
          ),
          const SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: ItemsMenuList(),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const CustomText(
                text: 'Items',
                color: AppColors.textColor,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  height: 1, // Thickness of the line
                  color: const Color.fromRGBO(115, 129, 141, 0.16),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const ListItem()
        ],
      ),
    );
  }
}
