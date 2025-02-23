import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_dashboard/app/flutter_admin_scaffold/admin_scaffold.dart';
import 'package:restaurant_dashboard/app/helper/extension.dart';
import 'package:restaurant_dashboard/app/routing/routes.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/widget/custom_button.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/cubit/categories_cubit.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/widgets/categories_text_feild.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/widgets/save_button.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/screens/add_menu_item.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/widgets/drop_down_items.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/widgets/items_container.dart';
import 'package:restaurant_dashboard/features/menuItem/presentation/widgets/menu_item_container.dart';
import 'package:restaurant_dashboard/features/side_bar.dart';

import '../../../../app/utils/constance.dart';
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
            leadingWidth: 20,
            leading: context.screenWidth < 377
                ? InkWell(
                    onTap: () {
                      adminScaffoldKey.currentState!.toggleSidebar();
                    },
                    splashColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: const SvgIcon(
                      height: 100,
                      color: AppColors.textColor,
                      icon: ImageManager.drawerIcon,
                    ),
                  )
                : const SizedBox(),
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
                                return BlocProvider.value(
                                  value: context.read<CategoriesCubit>(),
                                  child: Dialog(
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
                                            Row(
                                              children: [
                                                const FittedBox(
                                                  child: CustomText(
                                                    text: 'New Menu Item',
                                                    color: AppColors.textColor,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                const Spacer(),
                                                SizedBox(
                                                  width: 200,
                                                  height: 40,
                                                  child: DropDownTextField(
                                                    dropDownIconProperty:
                                                        IconProperty(
                                                      icon: Icons
                                                          .keyboard_arrow_down,
                                                      size: 24,
                                                      color:
                                                          AppColors.textColor,
                                                    ),
                                                    textFieldDecoration:
                                                        InputDecoration(
                                                      // fillColor: AppColors.boldContainerColor,
                                                      // filled: true,
                                                      prefixIcon: const Padding(
                                                        padding:
                                                            EdgeInsets.all(10),
                                                        child: SvgIcon(
                                                          icon: ImageManager
                                                              .language,
                                                          color: AppColors
                                                              .accentContainerColor,
                                                        ),
                                                      ),
                                                      contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                        horizontal: 15,
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide:
                                                            const BorderSide(
                                                          width: 1,
                                                          color: AppColors
                                                              .transparent,
                                                        ),
                                                      ),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide:
                                                            const BorderSide(
                                                          width: 1,
                                                          color: AppColors
                                                              .transparent,
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide:
                                                            const BorderSide(
                                                          width: 1,
                                                          color: AppColors
                                                              .palePrimary,
                                                        ),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide:
                                                            const BorderSide(
                                                          width: 1,
                                                          color: AppColors.red,
                                                        ),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide:
                                                            const BorderSide(
                                                          width: 1,
                                                          color: AppColors.red,
                                                        ),
                                                      ),
                                                      hintText: 'English',
                                                      hintStyle:
                                                          const TextStyle(
                                                        color:
                                                            AppColors.textColor,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 14,
                                                        fontFamily: AppConstance
                                                            .appFontName,
                                                      ),
                                                      errorStyle:
                                                          const TextStyle(
                                                        color: AppColors.red,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12,
                                                        fontFamily: AppConstance
                                                            .appFontName,
                                                      ),
                                                    ),
                                                    clearOption: true,
                                                    clearIconProperty:
                                                        IconProperty(
                                                            color:
                                                                Colors.green),
                                                    dropDownList: const [
                                                      DropDownValueModel(
                                                          name: 'English',
                                                          value: "value1"),
                                                      DropDownValueModel(
                                                          name: 'Arabic',
                                                          value: "value2"),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Divider(
                                              color: Color.fromRGBO(
                                                  115, 129, 141, 0.16),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const DeleteImageContainer(),
                                            CategoriesTextField(),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 200,
                                                  height: 40,
                                                  child: DropDownTextField(
                                                    dropDownIconProperty:
                                                        IconProperty(
                                                      icon: Icons
                                                          .keyboard_arrow_down,
                                                      size: 24,
                                                      color:
                                                          AppColors.textColor,
                                                    ),
                                                    textFieldDecoration:
                                                        InputDecoration(
                                                      fillColor: AppColors
                                                          .boldContainerColor,
                                                      filled: true,
                                                      contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                        horizontal: 15,
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        borderSide:
                                                            const BorderSide(
                                                          width: 1,
                                                          color: AppColors
                                                              .transparent,
                                                        ),
                                                      ),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        borderSide:
                                                            const BorderSide(
                                                          width: 1,
                                                          color: AppColors
                                                              .transparent,
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        borderSide:
                                                            const BorderSide(
                                                          width: 1,
                                                          color: AppColors
                                                              .palePrimary,
                                                        ),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        borderSide:
                                                            const BorderSide(
                                                          width: 1,
                                                          color: AppColors.red,
                                                        ),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        borderSide:
                                                            const BorderSide(
                                                          width: 1,
                                                          color: AppColors.red,
                                                        ),
                                                      ),
                                                      hintText: 'Food',
                                                      hintStyle:
                                                          const TextStyle(
                                                        color:
                                                            AppColors.textColor,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 14,
                                                        fontFamily: AppConstance
                                                            .appFontName,
                                                      ),
                                                      errorStyle:
                                                          const TextStyle(
                                                        color: AppColors.red,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12,
                                                        fontFamily: AppConstance
                                                            .appFontName,
                                                      ),
                                                    ),
                                                    clearOption: true,
                                                    clearIconProperty:
                                                        IconProperty(
                                                            color:
                                                                Colors.green),
                                                    dropDownList: const [
                                                      DropDownValueModel(
                                                          name: 'drinks',
                                                          value: "value1"),
                                                      DropDownValueModel(
                                                          name: 'food',
                                                          value: "value2"),
                                                      DropDownValueModel(
                                                        name: 'sweets',
                                                        value: "value3",
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 50,
                                                ),
                                                SizedBox(
                                                  width: 200,
                                                  height: 40,
                                                  child: DropDownTextField(
                                                    dropDownIconProperty:
                                                        IconProperty(
                                                      icon: Icons
                                                          .keyboard_arrow_down,
                                                      size: 24,
                                                      color:
                                                          AppColors.textColor,
                                                    ),
                                                    textFieldDecoration:
                                                        InputDecoration(
                                                      fillColor: AppColors
                                                          .boldContainerColor,
                                                      filled: true,
                                                      contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                        horizontal: 15,
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        borderSide:
                                                            const BorderSide(
                                                          width: 1,
                                                          color: AppColors
                                                              .transparent,
                                                        ),
                                                      ),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        borderSide:
                                                            const BorderSide(
                                                          width: 1,
                                                          color: AppColors
                                                              .transparent,
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        borderSide:
                                                            const BorderSide(
                                                          width: 1,
                                                          color: AppColors
                                                              .palePrimary,
                                                        ),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        borderSide:
                                                            const BorderSide(
                                                          width: 1,
                                                          color: AppColors.red,
                                                        ),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        borderSide:
                                                            const BorderSide(
                                                          width: 1,
                                                          color: AppColors.red,
                                                        ),
                                                      ),
                                                      hintText: 'New category',
                                                      hintStyle:
                                                          const TextStyle(
                                                        color:
                                                            AppColors.textColor,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 14,
                                                        fontFamily: AppConstance
                                                            .appFontName,
                                                      ),
                                                      errorStyle:
                                                          const TextStyle(
                                                        color: AppColors.red,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12,
                                                        fontFamily: AppConstance
                                                            .appFontName,
                                                      ),
                                                    ),
                                                    clearOption: true,
                                                    clearIconProperty:
                                                        IconProperty(
                                                            color:
                                                                Colors.green),
                                                    dropDownList: const [
                                                      DropDownValueModel(
                                                          name: 'drinks',
                                                          value: "value1"),
                                                      DropDownValueModel(
                                                          name: 'food',
                                                          value: "value2"),
                                                      DropDownValueModel(
                                                        name: 'sweets',
                                                        value: "value3",
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const CustomTextFormField(
                                              title:
                                                  'Item Description ( local: English )',
                                              titleFontSize: 14,
                                              borderColor:
                                                  AppColors.containerColor,
                                              maxLines: 3,
                                            ),
                                            const CustomTextFormField(
                                              title: 'Item Price',
                                              titleFontSize: 14,
                                              borderColor:
                                                  AppColors.containerColor,
                                              maxLines: 1,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const ButtonSave()
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
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

class DeleteImageContainer extends StatelessWidget {
  const DeleteImageContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: AppColors.containerColor,
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            Image.asset(ImageManager.addImage),
            const SizedBox(
              width: 5,
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'untitled.jpeg',
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
                CustomText(
                  text: '12 MB',
                  color: AppColors.grey73818D99,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ],
            ),
            const Spacer(),
            const CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.white,
                child: SvgIcon(
                  icon: ImageManager.clear,
                  color: AppColors.red,
                  height: 25,
                )),
          ],
        ));
  }
}
