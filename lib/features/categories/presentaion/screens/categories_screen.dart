import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurant_dashboard/app/flutter_admin_scaffold/admin_scaffold.dart';
import 'package:restaurant_dashboard/app/helper/extension.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/utils/constance.dart';
import 'package:restaurant_dashboard/app/utils/image_manager.dart';
import 'package:restaurant_dashboard/app/widget/custom_button.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:restaurant_dashboard/app/widget/svg_icons.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/cubit/categories_cubit.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/widgets/add_categories.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/widgets/categories_text_feild.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/widgets/drinks_categories.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/widgets/food_categories.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/widgets/save_button.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/widgets/super_categories.dart';
import 'package:restaurant_dashboard/features/categories/presentaion/widgets/sweets_categories.dart';
import 'package:restaurant_dashboard/features/side_bar.dart';

import '../../../../app/routing/routes.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoriesCubit(),
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
          leadingWidth: 20,
          leading: context.screenWidth < 377
              ? InkWell(
                  child: const SvgIcon(
                    height: 100,
                    color: AppColors.textColor,
                    icon: ImageManager.drawerIcon,
                  ),
                  onTap: () {
                    adminScaffoldKey.currentState!.toggleSidebar();
                  },
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                )
              : const SizedBox(),
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
                              return BlocProvider.value(
                                value: context.read<CategoriesCubit>(),
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
                                          Row(
                                            children: [
                                              const CustomText(
                                                text: 'New Category',
                                                color: AppColors.textColor,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 20,
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
                                                    color: AppColors.textColor,
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
                                                          BorderRadius.circular(
                                                              10),
                                                      borderSide:
                                                          const BorderSide(
                                                        width: 1,
                                                        color: AppColors
                                                            .transparent,
                                                      ),
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
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
                                                          BorderRadius.circular(
                                                              10),
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
                                                          BorderRadius.circular(
                                                              10),
                                                      borderSide:
                                                          const BorderSide(
                                                        width: 1,
                                                        color: AppColors.red,
                                                      ),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      borderSide:
                                                          const BorderSide(
                                                        width: 1,
                                                        color: AppColors.red,
                                                      ),
                                                    ),
                                                    hintText: 'English',
                                                    hintStyle: const TextStyle(
                                                      color:
                                                          AppColors.textColor,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 14,
                                                      fontFamily: AppConstance
                                                          .appFontName,
                                                    ),
                                                    errorStyle: const TextStyle(
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
                                                          color: Colors.green),
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
                                          const AddImageContainer(),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          CategoriesTextField(),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SuperCategories(),
        const SizedBox(
          height: 10,
        ),
        const FoodCategories(),
        const SizedBox(
          height: 10,
        ),
        const DrinksCategories(),
        const SizedBox(
          height: 10,
        ),
        const SweetsCategories()
      ],
    );
  }
}

class CategoriesColumn extends StatelessWidget {
  const CategoriesColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          color: Color.fromRGBO(115, 129, 141, 0.16),
        ),
        SuperCategories(),
        const SizedBox(
          height: 10,
        ),
        const FoodCategories(),
        const SizedBox(
          height: 10,
        ),
        const DrinksCategories(),
        const SizedBox(
          height: 10,
        ),
        const SweetsCategories(),
      ],
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
