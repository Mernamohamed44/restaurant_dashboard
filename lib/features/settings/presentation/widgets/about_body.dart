import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restaurant_dashboard/app/helper/extension.dart';
import 'package:restaurant_dashboard/app/routing/routes.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/utils/image_manager.dart';
import 'package:restaurant_dashboard/app/widget/custom_button.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:restaurant_dashboard/app/widget/custom_text_form_field.dart';
import 'package:restaurant_dashboard/app/widget/toastification_widget.dart';
import 'package:restaurant_dashboard/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:toastification/toastification.dart';

class AboutBody extends StatelessWidget {
  const AboutBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final cubit = context.read<SettingsCubit>();
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.red.withOpacity(.05),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              ImageManager.warning,
                              height: 20,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Flexible(
                              child: CustomText(
                                maxLines: 3,
                                text:
                                    'Please note that this info will help optimize the SEO for your Menu',
                                color: Color(0xffC04027),
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const CircleAvatar(
                          radius: 8,
                          backgroundColor: Color(0xffC04027),
                          child: Icon(
                            Icons.clear,
                            color: AppColors.white,
                            size: 10,
                          ))
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  const CustomText(
                    text: 'About Us',
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
              const SizedBox(
                height: 15,
              ),
              CustomTextFormField(
                title: 'Name',
                titleFontSize: 14,
                hintText: 'Name',
                controller: context.read<SettingsCubit>().nameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "please enter Name";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                title: ' Title',
                titleFontSize: 14,
                hintText: 'Add a title to be used in the browser taps...',
                validator: (value) {
                  if (value!.isEmpty) {
                    return "please enter Title";
                  }
                  return null;
                },
                controller: context.read<SettingsCubit>().titleController,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                title: 'Description',
                maxLines: 3,
                hintText: 'Tell your customer about your restaurant ...',
                titleFontSize: 14,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "please enter Description";
                  }
                  return null;
                },
                controller: context.read<SettingsCubit>().descriptionController,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      controller:
                          context.read<SettingsCubit>().keyWordsController,
                      title: 'Key Words',
                      titleFontSize: 14,
                      hintText: 'Add keywords to help the seo...',
                      validator: (value) {
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  InkWell(
                    onTap: () {
                      if (context
                          .read<SettingsCubit>()
                          .keyWordsController
                          .text
                          .isNotEmpty) {
                        cubit.addKeyWords();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: AppColors.accentContainerColor,
                          borderRadius: BorderRadius.circular(25)),
                      child: const CustomText(
                        text: 'Add',
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Wrap(
                      alignment: WrapAlignment.start,
                      direction: Axis.horizontal,
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: List.generate(
                          cubit.tags.length,
                          (index) => keywordContainer(
                                text: cubit.tags[index],
                                index: index,
                              ))),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              BlocConsumer<SettingsCubit, SettingsState>(
                listener: (context, state) {
                  if (state is AboutUsSuccessState) {
                    showToastificationWidget(
                      message: 'AboutUs Create successfully',
                      context: context,
                        notificationType: ToastificationType.success
                    );
                    context.pushReplacementNamed(Routes.dashboard);
                  } else if (state is AboutUsFailState) {
                    showToastificationWidget(
                      message: state.message,
                      context: context,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is AboutUsLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    );
                  }
                  return CustomButton(
                    onTap: () {
                      context.read<SettingsCubit>().createAboutUs();
                    },
                    text: 'Create',
                    fontColor: Colors.white,
                    fontSize: 16,
                    isGradient: true,
                    borderColor: AppColors.transparent,
                    borderRadius: 50,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class keywordContainer extends StatelessWidget {
  const keywordContainer({super.key, required this.text, required this.index});

  final String text;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.palePrimary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          CustomText(
            text: text,
            color: AppColors.white,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
          const SizedBox(
            width: 5,
          ),
          InkWell(
            onTap: () {
              context.read<SettingsCubit>().clearKeyWords(index);
            },
            child: CircleAvatar(
                radius: 10,
                backgroundColor: AppColors.white.withOpacity(.24),
                child: const Icon(
                  Icons.clear,
                  color: AppColors.white,
                  size: 10,
                )),
          )
        ],
      ),
    );
  }
}
