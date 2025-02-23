import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_dashboard/app/helper/extension.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/utils/image_manager.dart';
import 'package:restaurant_dashboard/features/Subscription/presentation/cubit/subscription_cubit.dart';
import 'package:restaurant_dashboard/features/Subscription/presentation/screens/free_container.dart';

class AvailablePlans extends StatelessWidget {
  const AvailablePlans({super.key});

  @override
  Widget build(BuildContext context) {
    return context.screenWidth > 500
        ? Row(
            children: [
              ...List.generate(
                  3,
                  (index) => Expanded(
                          child: InkWell(
                        hoverColor: AppColors.transparent,
                        onTap: () {
                          context
                              .read<SubscriptionCubit>()
                              .selectIndexContainer(index);
                        },
                        child: FreeContainer(
                          isSelected:
                              context.read<SubscriptionCubit>().selectedIndex ==
                                      index
                                  ? true
                                  : false,
                          image: ImageManager.free,
                        ),
                      )))
            ],
          )
        : Column(
            children: [
              ...List.generate(
                  3,
                  (index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: InkWell(
                          hoverColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                          onTap: () {
                            context
                                .read<SubscriptionCubit>()
                                .selectIndexContainer(index);
                          },
                          child: FreeContainer(
                            isSelected: context
                                        .read<SubscriptionCubit>()
                                        .selectedIndex ==
                                    index
                                ? true
                                : false,
                            image: ImageManager.free,
                          ),
                        ),
                      ))
            ],
          );
  }
}

// class PlansRow extends StatelessWidget {
//   const PlansRow({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ...List.generate(
//             3,
//                 (index) => Padding(
//               padding: const EdgeInsets.symmetric(vertical: 10),
//               child: InkWell(
//                 hoverColor: Colors.transparent,
//                 splashColor: Colors.transparent,
//                 focusColor: Colors.transparent,
//                 highlightColor: Colors.transparent,
//                 overlayColor:
//                 MaterialStateProperty.all(Colors.transparent),
//                 onTap: () {
//                   setState(() {
//                     selectedIndex = index;
//                   });
//                 },
//                 child: FreeContainer(
//                   isSelected: selectedIndex == index ? true : false,
//                   image: ImageManager.free,
//                 ),
//               ),
//             ))
//       ],
//     );
//   }
// }
