import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/utils/image_manager.dart';
import 'package:restaurant_dashboard/app/widget/custom_button.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:restaurant_dashboard/app/widget/svg_icons.dart';
import 'package:restaurant_dashboard/features/Subscription/domain/entities/plans_entities.dart';

class FreeContainer extends StatelessWidget {
  const FreeContainer(
      {super.key,
      required this.isSelected,
      required this.image,
      required this.plansData});

  final bool isSelected;
  final String image;
  final PlansEntities plansData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: isSelected
                ? AppColors.palePrimary.withOpacity(.07)
                : AppColors.containerColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color:
                    isSelected ? AppColors.palePrimary : Colors.transparent)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(child: SvgPicture.asset(image)),
                  const SizedBox(
                    height: 10,
                  ),
                   Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: '${plansData.price!} /Mo' ,
                        color: AppColors.palePrimary,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ],
                  ),
                ],
              ),
              CustomText(
                text: '${plansData.name!} plan',
                color: AppColors.textColor,
                fontWeight: FontWeight.w800,
                fontSize: 20,
              ),
              const SizedBox(
                height: 3,
              ),
              CustomText(
                text: plansData.description!,
                color: AppColors.grey73818D99,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                onTap: () {},
                text: 'Downgrade',
                fontColor: Colors.white,
                fontSize: 16,
                isGradient: true,
                borderColor: AppColors.transparent,
                borderRadius: 50,
              ),
              const SizedBox(
                height: 10,
              ),
              ...List.generate(10, (index) => const FreeRow())
            ],
          ),
        ),
      ),
    );
  }
}

class FreeRow extends StatelessWidget {
  const FreeRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          SvgIcon(
            icon: ImageManager.trueIcon,
            color: AppColors.palePrimary,
            height: 15,
          ),
          SizedBox(
            width: 3,
          ),
          Flexible(
            child: CustomText(
              text: 'About Us Page',
              color: AppColors.grey73818D,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
