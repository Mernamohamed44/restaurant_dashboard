import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:restaurant_dashboard/app/flutter_admin_scaffold/admin_menu_item.dart';
import 'package:restaurant_dashboard/app/flutter_admin_scaffold/side_bar.dart';
import 'package:restaurant_dashboard/app/helper/extension.dart';
import 'package:restaurant_dashboard/app/routing/routes.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/utils/image_manager.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:restaurant_dashboard/app/widget/svg_icons.dart';

class SideBarWidget {
  sideBarMenus(BuildContext context, selectedRoute) {
    return SideBar(
      width: context.screenWidth > 900 ? 220 : 80,
      borderColor: Colors.transparent,
      backgroundColor: context.screenWidth > 377
          ? const Color.fromRGBO(115, 129, 141, 0.09)
          : AppColors.white,
      textStyle: const TextStyle(color: AppColors.white),
      activeTextStyle: const TextStyle(color: AppColors.white),
      selectedRoute: selectedRoute,
      onSelected: (item) {
        selectedRoute = item.route;
        // if (item.route == Routes.invoices && context.screenWidth < 900) {
        // } else {
        //   context.pushReplacementNamed(
        //     "${item.route}",
        //   );
        // }
        //log("xxx: ${item.route}");

        context.pushReplacementNamed(
          "${item.route}",
        );
      },
      items: [
        AdminMenuItem(
          title: 'Dashboard',
          route: Routes.dashboard,
          selectedWidget:
              SvgPicture.asset(ImageManager.dashboardActive, height: 20),
          unSelectedWidget:
              SvgPicture.asset(ImageManager.dashboardInactive, height: 20),
        ),
        AdminMenuItem(
          title: 'Categories',
          route: Routes.category,
          selectedWidget: SvgPicture.asset(
            ImageManager.category,
            height: 20,
            color: AppColors.white,
          ),
          unSelectedWidget: SvgPicture.asset(ImageManager.category, height: 20),
        ),
        AdminMenuItem(
          title: 'Menu Items',
          route: Routes.menuItem,
          selectedWidget: SvgPicture.asset(
            ImageManager.menuItem,
            height: 20,
            color: AppColors.white,
          ),
          unSelectedWidget: SvgPicture.asset(ImageManager.menuItem, height: 20),
        ),
        AdminMenuItem(
          title: 'Reviews',
          route: Routes.reviews,
          selectedWidget: SvgPicture.asset(
            ImageManager.reviews,
            height: 20,
            color: AppColors.white,
          ),
          unSelectedWidget: SvgPicture.asset(ImageManager.reviews, height: 20),
        ),
        AdminMenuItem(
          title: 'Subscription',
          route: Routes.subscribe,
          selectedWidget: SvgPicture.asset(
            ImageManager.subscribe,
            height: 20,
            color: AppColors.white,
          ),
          unSelectedWidget:
              SvgPicture.asset(ImageManager.subscribe, height: 20),
        ),
        AdminMenuItem(
          title: 'Theme Store',
          route: Routes.store,
          selectedWidget: SvgPicture.asset(
            ImageManager.store,
            height: 20,
            color: AppColors.white,
          ),
          unSelectedWidget: SvgPicture.asset(ImageManager.store, height: 20),
        ),
        AdminMenuItem(
          title: 'Settings',
          route: Routes.setting,
          selectedWidget: SvgPicture.asset(
            ImageManager.setting,
            height: 20,
            color: AppColors.primary,
          ),
          unSelectedWidget: SvgPicture.asset(ImageManager.setting, height: 20),
          children: [
            AdminMenuItem(
              title: 'General Settings',
              route: Routes.generalSetting,
              selectedWidget: const SvgIcon(
                icon: ImageManager.generalSetting,
                height: 10,
                color: AppColors.white,
              ),
              unSelectedWidget: SvgPicture.asset(ImageManager.generalSetting,
                  color: AppColors.textColor, height: 10),
            ),
            AdminMenuItem(
              title: 'Visual Identity',
              route: Routes.brandSetting,
              selectedWidget: SvgPicture.asset(
                ImageManager.brandSetting,
                height: 20,
                color: AppColors.white,
              ),
              unSelectedWidget:
                  SvgPicture.asset(ImageManager.brandSetting, height: 20),
            ),
            AdminMenuItem(
              title: 'Theme Settings',
              route: Routes.themeSetting,
              selectedWidget: SvgPicture.asset(
                ImageManager.themeSetting,
                height: 20,
                color: AppColors.white,
              ),
              unSelectedWidget:
                  SvgPicture.asset(ImageManager.themeSetting, height: 20),
            ),
          ],
        ),
      ],
      footer: Container(
        color: context.screenWidth > 377
            ? const Color.fromRGBO(115, 129, 141, 0.09)
            : AppColors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              child: Row(
                mainAxisAlignment: context.screenWidth > 900
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    ImageManager.headphone,
                    height: 22,
                    color: AppColors.grey73818D,
                  ),
                  context.screenWidth > 900
                      ? const SizedBox(
                          width: 15,
                        )
                      : const SizedBox(),
                  context.screenWidth > 900
                      ? const CustomText(
                          text: "Support",
                          color: AppColors.textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        )
                      : const SizedBox()
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 10),
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                mainAxisAlignment: context.screenWidth > 900
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(ImageManager.language),
                  context.screenWidth > 900
                      ? const SizedBox(
                          width: 15,
                        )
                      : const SizedBox(),
                  context.screenWidth > 900
                      ? const CustomText(
                          text: "English",
                          color: AppColors.textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        )
                      : const SizedBox(),
                ],
              ),
              // child: ListTile(
              //   leading: SvgPicture.asset(ImageManager.language),
              //   title: context.screenWidth > 900
              //       ? const CustomText(
              //           text: "English",
              //           color: AppColors.textColor,
              //           fontSize: 14,
              //           fontWeight: FontWeight.w400,
              //         )
              //       : const SizedBox(),
              // ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                context.pushNamed(Routes.account);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.all(7),
                decoration: context.screenWidth > 900
                    ? BoxDecoration(
                        color: const Color.fromRGBO(115, 129, 141, 0.07),
                        borderRadius: BorderRadius.circular(12))
                    : const BoxDecoration(),
                child: InkWell(
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    context.pushNamed(Routes.account);
                  },
                  child: Row(
                    mainAxisAlignment: context.screenWidth > 900
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                          radius: 15, child: Image.asset(ImageManager.logo)),
                      context.screenWidth > 900
                          ? const SizedBox(
                              width: 15,
                            )
                          : const SizedBox(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          context.screenWidth > 900
                              ? const CustomText(
                                  text: "Abu Shahab",
                                  color: AppColors.textColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                )
                              : const SizedBox(),
                          const SizedBox(
                            height: 2,
                          ),
                          context.screenWidth > 900
                              ? const CustomText(
                                  text: "admin@abu-shahab.com",
                                  color: AppColors.accentContainerColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                )
                              : const SizedBox(),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            // InkWell(
            //   onTap: () {
            //     context.pushNamed(Routes.account);
            //   },
            //   child: ListTile(
            //     leading: CircleAvatar(child: Image.asset(ImageManager.logo)),
            //     subtitle: context.screenWidth > 900
            //         ? const CustomText(
            //             text: "admin@abu-shahab.com",
            //             color: AppColors.textColor,
            //             fontSize: 14,
            //             fontWeight: FontWeight.w400,
            //           )
            //         : const SizedBox(),
            //     title: context.screenWidth > 900
            //         ? const CustomText(
            //             text: "Abu Shahab",
            //             color: AppColors.textColor,
            //             fontSize: 14,
            //             fontWeight: FontWeight.w400,
            //           )
            //         : const SizedBox(),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
