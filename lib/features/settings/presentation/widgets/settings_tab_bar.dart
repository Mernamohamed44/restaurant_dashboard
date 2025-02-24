import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/utils/image_manager.dart';
import 'package:restaurant_dashboard/app/widget/custom_tab_bar.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:restaurant_dashboard/features/settings/presentation/widgets/about_body.dart';
import 'package:restaurant_dashboard/features/settings/presentation/widgets/contact_us.dart';
import 'package:restaurant_dashboard/features/settings/presentation/widgets/reviews.dart';

class SettingsTabBar extends StatefulWidget {
  const SettingsTabBar({super.key});

  @override
  State<SettingsTabBar> createState() => _SettingsTabBarState();
}

class _SettingsTabBarState extends State<SettingsTabBar>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    _tabController!.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<String> tabs = [
      'About',
      'Contacts',
      'Reviews',
    ];
    List<String> icons = [
      ImageManager.about,
      ImageManager.contact,
      ImageManager.star,
    ];
    return DefaultTabController(
      length: 3,
      child: CustomTabBar(
        pages: const [
          AboutBody(),
          ContactUs(),
          Reviews(),
        ],
        tabs: List.generate(3, (index) {
          return InkWell(
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              setState(() {
                _tabController!.index = index;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: _tabController!.index == index
                    ? AppColors.primary
                    : AppColors.boldContainerColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    icons[index],
                    height: 18,
                    color: _tabController!.index == index
                        ? AppColors.white
                        : AppColors.textColor,
                  ),
                  const SizedBox(width: 10),
                  CustomText(
                    text: tabs[index],
                    color: _tabController!.index == index
                        ? AppColors.white
                        : AppColors.textColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ],
              ),
            ),
          );
        }),
        isScrollable: true,
        controller: _tabController!,
      ),
    );
  }
}
