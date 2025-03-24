import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_dashboard/app/dependancy_injection/dependancy_injection.dart';
import 'package:restaurant_dashboard/app/flutter_admin_scaffold/admin_scaffold.dart';
import 'package:restaurant_dashboard/app/helper/extension.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/utils/image_manager.dart';
import 'package:restaurant_dashboard/app/widget/custom_button.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:restaurant_dashboard/app/widget/svg_icons.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/cubit/categories_cubit.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/widgets/add_categories.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/widgets/add_category_dialog.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/widgets/drinks_categories.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/widgets/food_categories.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/widgets/super_categories.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/widgets/sweets_categories.dart';
import 'package:restaurant_dashboard/features/side_bar.dart';

import '../../../../app/routing/routes.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CategoriesCubit>()..getCategoriesData(),
      child: const CategoriesBody(),
    );
  }
}

class CategoriesBody extends StatelessWidget {
  const CategoriesBody({super.key});

  @override
  Widget build(BuildContext context) {
    final adminScaffoldKey = GlobalKey<AdminScaffoldState>();
    SideBarWidget sideBar = SideBarWidget();

    return AdminScaffold(
      key: adminScaffoldKey,
      backgroundColor: AppColors.white,
      sideBar: sideBar.sideBarMenus(context, Routes.category),
      body: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
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
            text: 'Category List',
            color: AppColors.textColor,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CustomButton(
                width: 130,
                height: 35,
                borderRadius: 25,
                borderColor: AppColors.transparent,
                isGradient: true,
                widget: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: AppColors.white, size: 20),
                      SizedBox(
                        width: 5,
                      ),
                      Flexible(
                          child: FittedBox(
                              child: CustomText(
                                  text: 'New Category', color: Colors.white)))
                    ],
                  ),
                ),
                onTap: context.screenWidth > 600
                    ? () {
                        showDialog(
                            context: context,
                            builder: (c) {
                              return AddCategoryDialog(
                                categoriesCubit:
                                    context.read<CategoriesCubit>(),
                              );
                            });
                      }
                    : () => MagicRouter.navigateTo(page: const AddCategories()),
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
              ? const CategoriesColumn()
              : const CategoriesRow(),
        ),
      ),
    );
  }
}

class CategoriesRow extends StatelessWidget {
  const CategoriesRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SuperCategories(),
        SizedBox(
          height: 10,
        ),
        FoodCategories(),
        SizedBox(
          height: 10,
        ),
        DrinksCategories(),
        SizedBox(
          height: 10,
        ),
        SweetsCategories()
      ],
    );
  }
}

class CategoriesColumn extends StatelessWidget {
  const CategoriesColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Divider(
          color: Color.fromRGBO(115, 129, 141, 0.16),
        ),
        SuperCategories(),
        SizedBox(
          height: 10,
        ),
        FoodCategories(),
        SizedBox(
          height: 10,
        ),
        DrinksCategories(),
        SizedBox(
          height: 10,
        ),
        SweetsCategories(),
      ],
    );
  }
}
