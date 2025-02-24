import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant_dashboard/app/flutter_admin_scaffold/admin_scaffold.dart';
import 'package:restaurant_dashboard/app/helper/extension.dart';
import 'package:restaurant_dashboard/app/routing/routes.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/utils/image_manager.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:restaurant_dashboard/app/widget/custom_text_form_field.dart';
import 'package:restaurant_dashboard/app/widget/svg_icons.dart';
import 'package:restaurant_dashboard/features/side_bar.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SideBarWidget sideBar = SideBarWidget();
    final adminScaffoldKey = GlobalKey<AdminScaffoldState>();
    return AdminScaffold(
      key: adminScaffoldKey,
      sideBar: sideBar.sideBarMenus(context, Routes.store),
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
            text: 'Theme Store',
            color: AppColors.textColor,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
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
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                        width: 200,
                        child: CustomTextFormField(
                          borderColor: AppColors.containerColor,
                          hintText: 'Search',
                          titleFontSize: 12,
                          prefixIcon: SizedBox(
                            height: 0.02.sh,
                            child: GestureDetector(
                                onTap: () {},
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: SvgIcon(
                                    icon: ImageManager.search,
                                    color: AppColors.textColor,
                                  ),
                                )),
                          ),
                          title: '',
                        ),
                      ),
                    ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(
              color: const Color.fromRGBO(115, 129, 141, 0.16),
              height: 1,
            ),
          ),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgIcon(
                icon: ImageManager.theme,
                color: AppColors.accentContainerColor,
                height: 60,
              ),
              SizedBox(
                height: 20,
              ),
              CustomText(
                text: 'This Feature Still Under Development',
                color: AppColors.accentContainerColor,
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
