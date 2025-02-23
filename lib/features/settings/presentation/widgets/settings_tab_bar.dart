import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/utils/image_manager.dart';
import 'package:restaurant_dashboard/app/widget/custom_tab_bar.dart';
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
          return GestureDetector(
            onTap: () {
              setState(() {
                _tabController!.index = index;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: _tabController!.index == index
                    ? AppColors.primary
                    : AppColors.white,
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
                  const SizedBox(
                    width: 10,
                  ),
                  Text(tabs[index]),
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
//
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:restaurant_dashboard/app/utils/colors.dart';
// import 'package:restaurant_dashboard/app/utils/image_manager.dart';
// import 'package:restaurant_dashboard/app/widget/custom_tab_bar.dart';
// import 'package:restaurant_dashboard/features/settings/presentation/widgets/about_body.dart';
// import 'package:restaurant_dashboard/features/settings/presentation/widgets/contact_us.dart';
//
// import 'reviews.dart';
//
// class SettingsTabBar extends StatefulWidget {
//   const SettingsTabBar({super.key});
//
//   @override
//   State<SettingsTabBar> createState() => _SettingsTabBarState();
// }
//
// class _SettingsTabBarState extends State<SettingsTabBar>
//     with SingleTickerProviderStateMixin {
//   TabController? _tabController;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(vsync: this, length: 3);
//     _tabController!.addListener(_handleTabSelection);
//   }
//
//   void _handleTabSelection() {
//     setState(() {});
//   }
//
//   List<String> tabs = [
//     'About',
//     'Contacts',
//     'Reviews',
//   ];
//   List<String> icons = [
//     ImageManager.about,
//     ImageManager.contact,
//     ImageManager.star,
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3,
//       child: CustomTabBar(
//         tabs: List.generate(3, (index) {
//           return GestureDetector(
//             // onTap: () {
//             //   setState(() {
//             //     _tabController!.index = index;
//             //   });
//             // },
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 // color: _tabController!.index == index
//                 //     ? AppColors.primary
//                 //     : AppColors.white,
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   // SvgPicture.asset(
//                   //   icons[index],
//                   //   height: 18,
//                   //   color: _tabController!.index == index
//                   //       ? AppColors.white
//                   //       : AppColors.textColor,
//                   // ),
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   Text(tabs[index]),
//                 ],
//               ),
//             ),
//           );
//         }),
//         pages: const[
//            AboutBody(),
//            ContactUs(),
//            Reviews(),
//         ],
//         isScrollable: false,
//         // controller: _tabController!,
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:restaurant_dashboard/app/utils/colors.dart';
// import 'package:restaurant_dashboard/app/utils/image_manager.dart';
// import 'package:restaurant_dashboard/app/widget/custom_tab_bar.dart';
// import 'package:restaurant_dashboard/features/settings/presentation/widgets/about_body.dart';
// import 'package:restaurant_dashboard/features/settings/presentation/widgets/contact_us.dart';
//
// class SettingsTabBar extends StatefulWidget {
//   const SettingsTabBar({super.key});
//
//   @override
//   State<SettingsTabBar> createState() => _SettingsTabBarState();
// }
//
// class _SettingsTabBarState extends State<SettingsTabBar>
//     with SingleTickerProviderStateMixin {
//   TabController? _tabController;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(vsync: this, length: 3);
//     _tabController!.addListener(_handleTabSelection);
//   }
//
//   void _handleTabSelection() {
//     setState(() {});
//   }
//
//   List<String> tabs = [
//     'About',
//     'Contacts',
//     'Reviews',
//   ];
//   List<String> icons = [
//     ImageManager.about,
//     ImageManager.contact,
//     ImageManager.star,
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3,
//       child: CustomTabBar(
//         pages: [
//           Expanded(child: AboutBody()),
//           Expanded(child: ContactUs()),
//           Expanded(child: ContactUs()),
//         ],
//         tabs: List.generate(3, (index) {
//           return GestureDetector(
//             onTap: () {
//               setState(() {
//                 _tabController!.index = index;
//               });
//             },
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 color: _tabController!.index == index
//                     ? AppColors.primary
//                     : AppColors.white,
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   SvgPicture.asset(
//                     icons[index],
//                     height: 18,
//                     color: _tabController!.index == index
//                         ? AppColors.white
//                         : AppColors.textColor,
//                   ),
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   Text(tabs[index]),
//                 ],
//               ),
//             ),
//           );
//         }),
//         isScrollable: true,
//         controller: _tabController!,
//       ),
//     );
//   }
// }
//
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:restaurant_dashboard/app/utils/colors.dart';
// import 'package:restaurant_dashboard/app/utils/constance.dart';
// import 'package:restaurant_dashboard/app/utils/image_manager.dart';
// import 'package:restaurant_dashboard/app/widget/custom_tab_bar.dart';
// import 'package:restaurant_dashboard/features/settings/presentation/widgets/about_body.dart';
// import 'package:restaurant_dashboard/features/settings/presentation/widgets/contact_us.dart';
//
// import 'reviews.dart';
//
// class SettingsTabBar extends StatefulWidget {
//   const SettingsTabBar({super.key});
//
//   @override
//   State<SettingsTabBar> createState() => _SettingsTabBarState();
// }
//
// class _SettingsTabBarState extends State<SettingsTabBar>
//     {
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     List<String> tabs = [
//       'About',
//       'Contacts',
//       'Reviews',
//     ];
//     List<String> icons = [
//       ImageManager.about,
//       ImageManager.contact,
//       ImageManager.star,
//     ];
//
//     return DefaultTabController(
//       length: 3,
//       child: Column(
//         children: [
//           TabBar(
//             labelColor: AppColors.white,
//             indicatorSize: TabBarIndicatorSize.tab,
//             labelStyle: const TextStyle(
//                 fontWeight: FontWeight.w700,
//                 fontSize: 16,
//                 fontFamily: AppConstance.appFontName),
//             unselectedLabelColor: const Color(0xff7C7C80),
//             indicator: BoxDecoration(
//               borderRadius: BorderRadius.circular(24),
//               color: AppColors.primary,
//             ),
//             dividerColor: Colors.transparent,
//             isScrollable: true,
//             labelPadding:
//             const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
//             unselectedLabelStyle: const TextStyle(
//               fontFamily: AppConstance.appFontName,
//               fontWeight: FontWeight.w400,
//             ),
//             tabAlignment: TabAlignment.start,
//             tabs: List.generate(3, (index) => Text(tabs[index])),
//           ),
//           Expanded(
//             child: TabBarView(
//               physics: const NeverScrollableScrollPhysics(),
//               children: [
//                 AboutBody(),
//                 ContactUs(),
//                 Reviews(),
//               ],
//             ),
//           )
//         ],
//       ),
//       // child: CustomTabBar(
//       //   tabs: List.generate(3, (index) {
//       //     return Container(
//       //       padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
//       //       decoration: BoxDecoration(
//       //         borderRadius: BorderRadius.circular(20),
//       //         // color: _tabController!.index == index
//       //         //     ? AppColors.primary
//       //         //     : AppColors.white,
//       //       ),
//       //       child: Row(
//       //         mainAxisAlignment: MainAxisAlignment.start,
//       //         children: [
//       //           // SvgPicture.asset(
//       //           //   icons[index],
//       //           //   height: 18,
//       //           //   color: _tabController!.index == index
//       //           //       ? AppColors.white
//       //           //       : AppColors.textColor,
//       //           // ),
//       //           const SizedBox(
//       //             width: 10,
//       //           ),
//       //           Text(tabs[index]),
//       //         ],
//       //       ),
//       //     );
//       //   }),
//       //   pages: const[
//       //     AboutBody(),
//       //     ContactUs(),
//       //     Reviews(),
//       //   ],
//       //   isScrollable: true,
//       //   // controller: _tabController!,
//       // ),
//     );
//   }
// }
