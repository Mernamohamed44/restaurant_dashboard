import 'package:flutter/material.dart';
import 'package:restaurant_dashboard/app/helper/extension.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';

import 'admin_menu_item.dart';

class SideBarItem extends StatelessWidget {
  const SideBarItem({
    super.key,
    required this.items,
    required this.index,
    this.onSelected,
    required this.selectedRoute,
    this.depth = 0,
    this.iconColor,
    this.activeIconColor,
    required this.textStyle,
    required this.activeTextStyle,
    required this.backgroundColor,
    required this.activeBackgroundColor,
    required this.borderColor,
  });

  final List<AdminMenuItem> items;
  final int index;
  final void Function(AdminMenuItem item)? onSelected;
  final String selectedRoute;
  final int depth;
  final Color? iconColor;
  final Color? activeIconColor;
  final TextStyle textStyle;
  final TextStyle activeTextStyle;
  final Color backgroundColor;
  final Color activeBackgroundColor;
  final Color borderColor;

  bool get isLast => index == items.length - 1;

  @override
  Widget build(BuildContext context) {
    if (depth > 0 && isLast) {
      return _buildTiles(context, items[index]);
    }
    return Container(
      padding: const EdgeInsetsDirectional.only(start: 10, end: 10, top: 5),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: borderColor)),
          borderRadius: BorderRadius.circular(12)),
      child: _buildTiles(context, items[index]),
    );
  }

  Widget _buildTiles(BuildContext context, AdminMenuItem item) {
    bool selected = _isSelected(selectedRoute, [item]);

    // todo
    // if (context.screenWidth < 900) {
    //   if (item.children.isNotEmpty) {
    //     item.children.clear();
    //   }
    // }

    if (item.children.isEmpty) {
      return AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          decoration: BoxDecoration(
              color: selected ? AppColors.primary : AppColors.transparent,
              borderRadius:
                  selected ? BorderRadius.circular(12) : BorderRadius.zero),
          child: InkWell(
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              if (onSelected != null) {
                onSelected!(item);
              }
            },
            // onTap: () {
            //     if (widget.onSelected != null) {
            //       if (item.route == Routes.invoices &&
            //           context.screenWidth < 900) {
            //         showPopover(
            //           context: context,
            //           direction: PopoverDirection.bottom,
            //           width: 220,
            //           height: 120,
            //           arrowHeight: 10,
            //           arrowWidth: 15,
            //           bodyBuilder: (context) => Center(
            //             child: Padding(
            //               padding: const EdgeInsets.all(20),
            //               child: Column(
            //                 crossAxisAlignment: CrossAxisAlignment.center,
            //                 children: [
            //                   GestureDetector(
            //                     onTap: () {
            //                       context.pushReplacementNamed(Routes.addInvoice);
            //                     },
            //                     child: Row(
            //                       children: [
            //                         SvgPicture.asset(ImageManager.expense,
            //                             height: 20),
            //                         15.horizontalSpace,
            //                         const Flexible(
            //                           child: CustomText(
            //                               text: 'Go to Add Invoices',
            //                               color: AppColors.primary),
            //                         )
            //                       ],
            //                     ),
            //                   ),
            //                   30.verticalSpace,
            //                   GestureDetector(
            //                     onTap: () {
            //                       context.pushReplacementNamed(Routes.getInvoice);
            //                     },
            //                     child: Row(
            //                       children: [
            //                         SvgPicture.asset(ImageManager.income,
            //                             height: 20),
            //                         15.horizontalSpace,
            //                         const Flexible(
            //                           child: CustomText(
            //                             text: 'Go to Get Invoices',
            //                             color: AppColors.primary,
            //                           ),
            //                         )
            //                       ],
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ),
            //         );
            //       } else {
            //         widget.onSelected!(item);
            //       }
            //     }
            //
            // },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: Row(
                mainAxisAlignment: context.screenWidth > 900
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.center,
                children: [
                  _buildIcon(
                      item.selectedWidget, item.unSelectedWidget, selected),
                  context.screenWidth > 900
                      ? const SizedBox(width: 15)
                      : const SizedBox(),
                  Flexible(child: _buildTitle(item.title, context, selected)),
                ],
              ),
            ),
          ));
    }

    int index = 0;
    final childrenTiles = item.children.map((child) {
      return SideBarItem(
        items: item.children,
        index: index++,
        onSelected: onSelected,
        selectedRoute: selectedRoute,
        depth: depth,
        iconColor: iconColor,
        activeIconColor: activeIconColor,
        textStyle: textStyle,
        activeTextStyle: activeTextStyle,
        backgroundColor: backgroundColor,
        activeBackgroundColor: activeBackgroundColor,
        borderColor: borderColor,
      );
    }).toList();

    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
        listTileTheme: ListTileTheme.of(context).copyWith(
          dense: true,
        ),
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: ExpansionTile(
        backgroundColor: const Color.fromRGBO(254, 145, 29, 0.05),
        tilePadding: context.screenWidth > 900
            ? const EdgeInsetsDirectional.only(start: 8)
            : const EdgeInsetsDirectional.only(start: 22),
        childrenPadding: EdgeInsets.zero,
        trailing: const SizedBox(),
        leading:
            _buildIcon(item.selectedWidget, item.unSelectedWidget, selected),
        title: _buildTitle(
          item.title,
          context,
          selected,
          true,
        ),
        initiallyExpanded: selected,
        // children: context.screenWidth > 900 ? childrenTiles : [],
        children: childrenTiles,
      ),
    );
  }

  bool _isSelected(String route, List<AdminMenuItem> items) {
    for (final item in items) {
      if (item.route == route) {
        return true;
      }
      if (item.children.isNotEmpty) {
        return _isSelected(route, item.children);
      }
    }
    return false;
  }

  Widget _buildIcon(Widget selectedWidget, Widget unSelectedWidget,
      [bool selected = false]) {
    return SizedBox(
      height: 18,
      width: 18,
      child: selected ? selectedWidget : unSelectedWidget,
    );
  }

  Widget _buildTitle(String title, BuildContext context,
      [bool selected = false, bool fromExpansionTile = false]) {
    return context.screenWidth > 900
        ? Text(
            title,
            style: selected
                ? TextStyle(
                    color:
                        fromExpansionTile ? AppColors.primary : AppColors.white)
                : const TextStyle(color: AppColors.textColor),
          )
        : const SizedBox();
  }
}
