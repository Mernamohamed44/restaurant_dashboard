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
    return BlocBuilder<SubscriptionCubit, SubscriptionState>(
      builder: (context, state) {
        final plans = context.read<SubscriptionCubit>().plans;
        if (state is PlansDataLoadingState) {
          return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ));
        }
        return context.screenWidth > 500
            ? Row(
                children: [
                  ...List.generate(
                      plans.length,
                      (index) => Expanded(
                              child: InkWell(
                            hoverColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            highlightColor: Colors.transparent,
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
                              plansData: plans[index],
                            ),
                          )))
                ],
              )
            : Column(
                children: [
                  ...List.generate(
                      plans.length,
                      (index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: InkWell(
                              hoverColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                context
                                    .read<SubscriptionCubit>()
                                    .selectIndexContainer(index);
                              },
                              child: FreeContainer(
                                plansData: plans[index],
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
      },
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
