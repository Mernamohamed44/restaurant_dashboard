import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restaurant_dashboard/app/flutter_admin_scaffold/admin_scaffold.dart';
import 'package:restaurant_dashboard/app/helper/extension.dart';
import 'package:restaurant_dashboard/app/routing/routes.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/utils/image_manager.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:restaurant_dashboard/app/widget/svg_icons.dart';
import 'package:restaurant_dashboard/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:restaurant_dashboard/features/settings/presentation/widgets/assets_brand.dart';
import 'package:restaurant_dashboard/features/settings/presentation/widgets/color_brand.dart';
import 'package:restaurant_dashboard/features/settings/presentation/widgets/preview.dart';
import 'package:restaurant_dashboard/features/settings/presentation/widgets/typography.dart';
import 'package:restaurant_dashboard/features/side_bar.dart';

class BrandSettingScreen extends StatelessWidget {
  const BrandSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit(),
      child: const BrandSettingBody(),
    );
  }
}

class BrandSettingBody extends StatefulWidget {
  const BrandSettingBody({super.key});

  @override
  State<BrandSettingBody> createState() => _BrandSettingBodyState();
}

class _BrandSettingBodyState extends State<BrandSettingBody> {
  bool isTypographyClicked = false;
  bool isAssetsClicked = false;
  bool isColorClicked = false;

  @override
  Widget build(BuildContext context) {
    SideBarWidget sideBar = SideBarWidget();
    final adminScaffoldKey = GlobalKey<AdminScaffoldState>();
    return AdminScaffold(
        sideBar: sideBar.sideBarMenus(context, Routes.brandSetting),
        body: Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
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
              text: 'Brand  Settings',
              color: AppColors.textColor,
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(
                color: const Color.fromRGBO(115, 129, 141, 0.16),
                height: 1,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                context.screenWidth < 800
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.red.withOpacity(.05),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      ImageManager.warning,
                                      height: 20,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Flexible(
                                      child: CustomText(
                                        maxLines: 3,
                                        text:
                                            'Please note that Realtime preview only available in large screens',
                                        color: Color(0xffC04027),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const CircleAvatar(
                                  radius: 8,
                                  backgroundColor: Color(0xffC04027),
                                  child: Icon(
                                    Icons.clear,
                                    color: AppColors.white,
                                    size: 10,
                                  ))
                            ],
                          ),
                        ),
                      )
                    : SizedBox(),
                BrandSettingRow(),
              ],
            ),
          ),
        ));
  }
}

class BrandSettingRow extends StatefulWidget {
  BrandSettingRow({super.key});

  @override
  State<BrandSettingRow> createState() => _BrandSettingRowState();
}

class _BrandSettingRowState extends State<BrandSettingRow> {
  bool isTypographyClicked = false;

  bool isAssetsClicked = false;

  bool isColorClicked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CustomText(
                      text: 'Typography',
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
                            isTypographyClicked = !isTypographyClicked;
                          });
                        },
                        child: isTypographyClicked
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
                isTypographyClicked
                    ? const TypographyWidget()
                    : const SizedBox(),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const CustomText(
                      text: 'Brand Assets',
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
                            isAssetsClicked = !isAssetsClicked;
                          });
                        },
                        child: isAssetsClicked
                            ? const Icon(
                                Icons.keyboard_arrow_up,
                                color: AppColors.textColor,
                              )
                            : const Icon(
                                Icons.keyboard_arrow_down,
                                color: AppColors.textColor,
                              )),
                  ],
                ),
                isAssetsClicked ? const AssetsBrand() : const SizedBox(),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const CustomText(
                      text: 'Brand Colors',
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
                            isColorClicked = !isColorClicked;
                          });
                        },
                        child: isColorClicked
                            ? const Icon(
                                Icons.keyboard_arrow_up,
                                color: AppColors.textColor,
                              )
                            : const Icon(
                                Icons.keyboard_arrow_down,
                                color: AppColors.textColor,
                              )),
                  ],
                ),
                isColorClicked ? const ColorBrand() : const SizedBox(),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
        context.screenWidth > 800
            ? Flexible(
                flex: 2,
                child: Container(
                    padding: EdgeInsets.all(10),
                    color: AppColors.boldContainerColor,
                    child: Preview()),
              )
            : SizedBox()
      ],
    );
  }
}
