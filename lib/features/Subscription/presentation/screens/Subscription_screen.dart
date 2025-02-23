import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_dashboard/app/flutter_admin_scaffold/admin_scaffold.dart';
import 'package:restaurant_dashboard/app/helper/extension.dart';
import 'package:restaurant_dashboard/app/routing/routes.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/utils/image_manager.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:restaurant_dashboard/app/widget/svg_icons.dart';
import 'package:restaurant_dashboard/features/Subscription/presentation/cubit/subscription_cubit.dart';
import 'package:restaurant_dashboard/features/Subscription/presentation/widgets/reminder_for_subscription.dart';
import 'package:restaurant_dashboard/features/side_bar.dart';

import '../widgets/available_plans.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SubscriptionCubit(),
      child: const SubscriptionBody(),
    );
  }
}

class SubscriptionBody extends StatelessWidget {
  const SubscriptionBody({super.key});

  @override
  Widget build(BuildContext context) {
    SideBarWidget sideBar = SideBarWidget();
    final adminScaffoldKey = GlobalKey<AdminScaffoldState>();
    return AdminScaffold(
      key: adminScaffoldKey,
      sideBar: sideBar.sideBarMenus(context, Routes.subscribe),
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
            text: 'Subscription',
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                const ReminderSubscription(),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    const CustomText(
                      text: 'Available Plans',
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
                  ],
                ),
                const SizedBox(height: 15),
                BlocBuilder<SubscriptionCubit, SubscriptionState>(
                  builder: (context, state) {
                    return const AvailablePlans();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
