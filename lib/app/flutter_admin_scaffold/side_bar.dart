import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restaurant_dashboard/app/helper/extension.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/utils/image_manager.dart';

import 'admin_menu_item.dart';
import 'side_bar_item.dart';

class SideBar extends StatefulWidget {
  const SideBar({
    super.key,
    required this.items,
    required this.selectedRoute,
    this.onSelected,
    this.width = 240.0,
    this.iconColor,
    this.activeIconColor,
    this.textStyle = const TextStyle(
      color: Colors.white,
      fontSize: 12,
    ),
    this.activeTextStyle = const TextStyle(
      color: Colors.white,
      fontSize: 12,
    ),
    this.backgroundColor = const Color(0xFFEEEEEE),
    this.activeBackgroundColor = const Color(0xFFE7E7E7),
    this.borderColor = const Color(0xFFE7E7E7),
    this.scrollController,
    this.header,
    this.footer,
    this.header2,
  });

  final List<AdminMenuItem> items;
  final String selectedRoute;
  final void Function(AdminMenuItem item)? onSelected;
  final double width;
  final Color? iconColor;
  final Color? activeIconColor;
  final TextStyle textStyle;
  final TextStyle activeTextStyle;
  final Color backgroundColor;
  final Color activeBackgroundColor;
  final Color borderColor;
  final ScrollController? scrollController;
  final Widget? header;
  final Widget? header2;
  final Widget? footer;

  @override
  SideBarState createState() => SideBarState();
}

class SideBarState extends State<SideBar> with SingleTickerProviderStateMixin {
  late double _sideBarWidth;
  late Widget _child;

  @override
  void initState() {
    super.initState();
    _sideBarWidth = widget.width;
    _child = Column(
      children: [
        Expanded(
          child: Material(
            color: widget.backgroundColor,
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return SideBarItem(
                  items: widget.items,
                  index: index,
                  onSelected: widget.onSelected,
                  selectedRoute: widget.selectedRoute,
                  depth: 0,
                  iconColor: widget.iconColor,
                  activeIconColor: widget.activeIconColor,
                  textStyle: widget.textStyle,
                  activeTextStyle: widget.activeTextStyle,
                  backgroundColor: widget.backgroundColor,
                  activeBackgroundColor: widget.activeBackgroundColor,
                  borderColor: widget.borderColor,
                );
              },
              itemCount: widget.items.length,
              controller: widget.scrollController ?? ScrollController(),
            ),
          ),
        ),
        if (widget.footer != null) widget.footer!,
      ],
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final mediaQuery = MediaQuery.of(context);
    _sideBarWidth = min(mediaQuery.size.width * 0.7, widget.width);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _sideBarWidth,
      child: Column(
        children: [
          _sideBarWidth == 220
              ? Container(
                  width: 220,
                  color: const Color.fromRGBO(115, 129, 141, 0.09),
                  child: SvgPicture.asset(
                    ImageManager.ourMenu,
                  ))
              : Container(
                  width: 80,
                  color: context.screenWidth > 377
                      ? const Color.fromRGBO(115, 129, 141, 0.09)
                      : AppColors.white,
                  child: SvgPicture.asset(
                    ImageManager.cloud,
                  )),
          Expanded(child: _child),
        ],
      ),
    );
  }
}
