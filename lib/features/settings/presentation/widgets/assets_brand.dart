import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/utils/image_manager.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:restaurant_dashboard/app/widget/svg_icons.dart';
import 'package:restaurant_dashboard/features/settings/presentation/cubit/settings_cubit.dart';

class AssetsBrand extends StatelessWidget {
  const AssetsBrand({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        ImageContainer(),
        SizedBox(
          height: 10,
        ),
        IconContainer(),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class ImageContainer extends StatelessWidget {
  const ImageContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: AppColors.containerColor,
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            Image.asset(ImageManager.addImage),
            const SizedBox(
              width: 5,
            ),
            Flexible(
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'untitled.jpeg',
                    color: AppColors.textColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                  CustomText(
                    text: '12 MB',
                    color: AppColors.grey73818D99,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ],
              ),
            ),
            const Spacer(),
            const CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.white,
                child: SvgIcon(
                  icon: ImageManager.clear,
                  color: AppColors.red,
                  height: 25,
                )),
          ],
        ));
  }
}

class IconContainer extends StatelessWidget {
  const IconContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.primary.withOpacity(.05),
              border: Border.all(color: AppColors.primary)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(ImageManager.addImage),
              const SizedBox(
                width: 5,
              ),
              Flexible(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      text: 'Category Image',
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                    RichText(
                      maxLines: 4,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Click here',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.read<SettingsCubit>().chooseImage(
                                    source: ImageSource.gallery,
                                    context: context);
                                print("Clicked!");
                              },
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              // Make it bold
                              color: AppColors.primary,
                              // Make it look like a link
                              decoration: TextDecoration
                                  .underline, // Optional: underline effect
                            ),
                          ),
                          const TextSpan(
                            text:
                                ' to upload an image, min height 100px, these extensions are acceptable .svg, .png, .jpeg',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors
                                  .accentContainerColor, // Normal text color
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
