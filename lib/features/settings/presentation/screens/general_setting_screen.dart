import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_dashboard/app/flutter_admin_scaffold/admin_scaffold.dart';
import 'package:restaurant_dashboard/app/helper/extension.dart';
import 'package:restaurant_dashboard/app/routing/routes.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/utils/image_manager.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:restaurant_dashboard/app/widget/svg_icons.dart';
import 'package:restaurant_dashboard/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:restaurant_dashboard/features/settings/presentation/widgets/settings_tab_bar.dart';
import 'package:restaurant_dashboard/features/side_bar.dart';

class GeneralSettingScreen extends StatelessWidget {
  const GeneralSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit(),
      child: const GeneralSettingBody(),
    );
  }
}

class GeneralSettingBody extends StatelessWidget {
  const GeneralSettingBody({super.key});

  @override
  Widget build(BuildContext context) {
    SideBarWidget sideBar = SideBarWidget();
    final adminScaffoldKey = GlobalKey<AdminScaffoldState>();
    return AdminScaffold(
      key: adminScaffoldKey,
      sideBar: sideBar.sideBarMenus(context, Routes.generalSetting),
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
            text: 'General Settings',
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
        body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SettingsTabBar(),
        ),
      ),
    );
  }
}
