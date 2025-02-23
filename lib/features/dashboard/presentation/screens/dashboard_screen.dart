import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant_dashboard/app/flutter_admin_scaffold/admin_scaffold.dart';
import 'package:restaurant_dashboard/app/helper/extension.dart';
import 'package:restaurant_dashboard/app/routing/routes.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/utils/constance.dart';
import 'package:restaurant_dashboard/app/utils/image_manager.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:restaurant_dashboard/app/widget/svg_icons.dart';
import 'package:restaurant_dashboard/features/dashboard/presentation/widget/category_views.dart';
import 'package:restaurant_dashboard/features/dashboard/presentation/widget/column_chart.dart';
import 'package:restaurant_dashboard/features/dashboard/presentation/widget/device_platforms.dart';
import 'package:restaurant_dashboard/features/dashboard/presentation/widget/geographical.dart';
import 'package:restaurant_dashboard/features/dashboard/presentation/widget/item_views.dart';
import 'package:restaurant_dashboard/features/dashboard/presentation/widget/language_usage.dart';
import 'package:restaurant_dashboard/features/dashboard/presentation/widget/last_activities.dart';
import 'package:restaurant_dashboard/features/dashboard/presentation/widget/minutes_session.dart';
import 'package:restaurant_dashboard/features/side_bar.dart';

import '../widget/customer_rate.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final adminScaffoldKey = GlobalKey<AdminScaffoldState>();
    SideBarWidget sideBar = SideBarWidget();

    return AdminScaffold(
      key: adminScaffoldKey,
      backgroundColor: AppColors.white,
      sideBar: sideBar.sideBarMenus(context, Routes.dashboard),
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
                    height: 40,
                    color: AppColors.textColor,
                    icon: ImageManager.drawerIcon,
                  ),
                )
              : const SizedBox(),
          title: const CustomText(
            text: 'Dashboard',
            color: AppColors.textColor,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: SizedBox(
                width: 170,
                height: 40,
                child: DropDownTextField(
                  dropDownIconProperty: IconProperty(
                    icon: Icons.keyboard_arrow_down,
                    size: 24,
                    color: AppColors.textColor,
                  ),
                  textFieldDecoration: InputDecoration(
                    fillColor: AppColors.boldContainerColor,
                    filled: true,
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(10),
                      child: SvgIcon(
                        icon: ImageManager.dairy,
                        color: AppColors.accentContainerColor,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 1,
                        color: AppColors.transparent,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 1,
                        color: AppColors.transparent,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 1,
                        color: AppColors.palePrimary,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 1,
                        color: AppColors.red,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 1,
                        color: AppColors.red,
                      ),
                    ),
                    hintText: 'Last 30 days',
                    hintStyle: const TextStyle(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      fontFamily: AppConstance.appFontName,
                    ),
                    errorStyle: const TextStyle(
                      color: AppColors.red,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      fontFamily: AppConstance.appFontName,
                    ),
                  ),
                  clearOption: true,
                  clearIconProperty: IconProperty(color: Colors.green),
                  dropDownList: const [
                    DropDownValueModel(name: 'monthly', value: "value1"),
                    DropDownValueModel(name: 'daily', value: "value2"),
                    DropDownValueModel(name: 'yearly', value: "value3"),
                    DropDownValueModel(name: 'Last 30 days', value: "value4"),
                  ],
                ),
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
        body: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: SingleChildScrollView(
            child: context.screenWidth < 700
                ? const DashboardColumn()
                : const DashboardRow(),
          ),
        ),
      ),
    );
  }
}

class DashboardRow extends StatelessWidget {
  const DashboardRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(flex: 2, child: ColumnCart()),
                        const SizedBox(width: 10),
                        Flexible(
                          flex: 1,
                          child: Column(
                            children: [
                              const MinutesSession(),
                              const SizedBox(height: 10),
                              DevicesAndPlatform()
                            ],
                          ),
                        ),
                      ],
                    ),
                    10.verticalSpace,
                    Row(
                      children: [
                        Flexible(flex: 1, child: CategoryViews()),
                        10.horizontalSpace,
                        Flexible(flex: 1, child: ItemViews())
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(flex: 1, child: LatestActivities())
            ],
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Flexible(
                  child: GeographicalAccess(
                text: 'Geographical Access',
              )),
              10.horizontalSpace,
              Flexible(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Flexible(child: CustomerRate()),
                        10.horizontalSpace,
                        const Flexible(child: LanguagesUsage()),
                      ],
                    ),
                    10.verticalSpace,
                    const GeographicalAccess(
                      text: 'Traffic Leads',
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class DashboardColumn extends StatelessWidget {
  const DashboardColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [
          const Divider(
            color: Color.fromRGBO(115, 129, 141, 0.16),
          ),
          ColumnCart(),
          const MinutesSession(),
          const SizedBox(height: 10),
          DevicesAndPlatform(),
          CategoryViews(),
          ItemViews(),
          LatestActivities(),
          const GeographicalAccess(
            text: 'Geographical Access',
          ),
          const CustomerRate(),
          const LanguagesUsage(),
          const GeographicalAccess(
            text: 'Traffic Leads',
          )
        ],
      ),
    );
  }
}
