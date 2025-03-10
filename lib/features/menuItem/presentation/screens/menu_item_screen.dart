import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_dashboard/app/flutter_admin_scaffold/admin_scaffold.dart';
import 'package:restaurant_dashboard/app/helper/extension.dart';
import 'package:restaurant_dashboard/app/routing/routes.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/widget/custom_button.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/cubit/categories_cubit.dart';
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
    return BlocProvider(
      create: (context) => CategoriesCubit(),
      child: const MenuItemBody(),
    );
  }
}

class MenuItemBody extends StatelessWidget {
  const MenuItemBody({super.key});

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
                      Flexible(
                          child: FittedBox(
                              child: CustomText(
                                  text: 'New Item', color: Colors.white)))
                    ],
                  ),
                  onTap: context.screenWidth > 600
                      ? () {
                          showDialog(
                              context: context,
                              builder: (c) {
                                return AddMenuItemDialog(
                                  categoriesCubit: context.read<CategoriesCubit>(),
                                );
                              });
                        }
                      : () =>
                          MagicRouter.navigateTo(page: const AddMemnuItem()),
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
          body: SingleChildScrollView(
            child: context.screenWidth < 500
                ? const MenuItemColumn()
                : const MenuItemRow(),
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
  List<MenuItemContainer> categories = [
    const MenuItemContainer(
      text: 'Grilled',
    ),
    const MenuItemContainer(
      text: 'Salad',
    ),
    const MenuItemContainer(
      text: 'Main Course',
    ),
    const MenuItemContainer(
      text: 'Turkish Food',
    ),
    const MenuItemContainer(
      text: 'Masgouf Fish',
    ),
    const MenuItemContainer(
      text: 'Fast Food',
    ),
    const MenuItemContainer(
      text: 'Special Food',
    ),
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.generate(
            categories.length,
            (index) => GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: MenuItemContainer(
                  text: categories[index].text,
                  isSelected: selectedIndex == index ? true : false,
                )))
      ],
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


