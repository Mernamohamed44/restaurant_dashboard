import 'dart:developer';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:restaurant_dashboard/app/helper/extension.dart';
import 'package:restaurant_dashboard/app/routing/routes.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/utils/constance.dart';
import 'package:restaurant_dashboard/app/utils/image_manager.dart';
import 'package:restaurant_dashboard/app/widget/custom_button.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:restaurant_dashboard/app/widget/custom_text_form_field.dart';
import 'package:restaurant_dashboard/app/widget/phone_number_input.dart';
import 'package:restaurant_dashboard/app/widget/toastification_widget.dart';
import 'package:restaurant_dashboard/features/settings/presentation/cubit/settings_cubit.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  void initState() {
    context.read<SettingsCubit>().addListenerFocusNode(0);
    context.read<SettingsCubit>().addListenerFocusNodeEmails(0);
    context.read<SettingsCubit>().addListenerFocusNodeAddress(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          final cubit = context.read<SettingsCubit>();
          return SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    const CustomText(
                      text: 'Contact Info',
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
                cubit.buildPhoneTextField(0),
                const SizedBox(
                  height: 10,
                ),
                ...cubit.phoneTextField,
                cubit.buildEmailTextField(0),
                const SizedBox(
                  height: 10,
                ),
                ...cubit.emailTextField,
                const SizedBox(
                  height: 10,
                ),
                cubit.buildAddressTextField(0),
                const SizedBox(
                  height: 10,
                ),
                ...cubit.addressTextField,
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const CustomText(
                      text: 'Social Media Links',
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
                  height: 20,
                ),
                context.screenWidth > 500
                    ? const Row(
                        children: [
                          PlatformSelection(),
                          SizedBox(
                            width: 5,
                          ),
                          Flexible(child: LinkTextField()),
                          SizedBox(
                            width: 5,
                          ),
                          AddButton()
                        ],
                      )
                    : const Column(
                        children: [
                          PlatformSelection(),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Flexible(child: LinkTextField()),
                              SizedBox(
                                width: 5,
                              ),
                              AddButton()
                            ],
                          )
                        ],
                      ),

                ...List.generate(
                    cubit.platformList.length,
                    (index) => SocialMediaLinksRow(
                          text: cubit.platformList[index]['url']!,
                          index: index,
                        )),
                const SizedBox(
                  height: 20,
                ),
                BlocConsumer<SettingsCubit, SettingsState>(
                  listener: (context, state) {
                    if (state is ContactsSuccessState) {
                      showToastificationWidget(
                        message: 'Contacts Create successfully',
                        context: context,
                      );
                      context.pushReplacementNamed(Routes.dashboard);
                    } else if (state is ContactsFailState) {
                      showToastificationWidget(
                        message: state.message,
                        context: context,
                      );
                    }
                  },
                  builder: (context, state) {
                    final cubit = context.read<SettingsCubit>();
                    if (state is ContactsLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      );
                    }
                    return CustomButton(
                      onTap: () {
                        context.read<SettingsCubit>().createContact();
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
      ),
    );
  }
}

class AddButton extends StatelessWidget {
  const AddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<SettingsCubit>().addLink();
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
    );
  }
}

class SocialMediaLinksRow extends StatelessWidget {
  const SocialMediaLinksRow(
      {super.key, required this.text, required this.index});

  final String text;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: AppColors.containerColor,
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Row(
                children: [
                  // SvgPicture.asset(ImageManager.facebook),
                  const SizedBox(
                    width: 15,
                  ),
                  Flexible(
                    child: CustomText(
                      text: text,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                      textDecoration: TextDecoration.underline,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                context.read<SettingsCubit>().clearLink(index);
              },
              child: SvgPicture.asset(
                ImageManager.clear,
                height: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LinkTextField extends StatelessWidget {
  const LinkTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter Link';
        }
        return null;
      },
      controller: context.read<SettingsCubit>().linksController,
      hintText: 'eg. htpps://facbook.com/geosid40...',
    );
  }
}

class PlatformSelection extends StatelessWidget {
  const PlatformSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenWidth > 500 ? 150 : double.infinity,
      child: DropDownTextField(
        controller: context.read<SettingsCubit>().platformController,
        dropDownIconProperty: IconProperty(
          icon: Icons.keyboard_arrow_down,
          size: 24,
          color: AppColors.textColor,
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "enter your platform";
          } else {
            return null;
          }
        },
        textFieldDecoration: InputDecoration(
          fillColor: AppColors.boldContainerColor,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              width: 1,
              color: AppColors.transparent,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              width: 1,
              color: AppColors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              width: 1,
              color: AppColors.palePrimary,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              width: 1,
              color: AppColors.red,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              width: 1,
              color: AppColors.red,
            ),
          ),
          hintText: 'Select Platform...',
          hintStyle: const TextStyle(
            color: AppColors.accentContainerColor,
            fontWeight: FontWeight.w400,
            fontSize: 14,
            fontFamily: AppConstance.appFontName,
          ),
          errorStyle: const TextStyle(
            color: AppColors.red,
            fontWeight: FontWeight.w400,
            fontSize: 12,
            fontFamily: AppConstance.appFontName,
          ),
        ),
        clearOption: true,
        clearIconProperty: IconProperty(color: Colors.green),
        dropDownList: const [
          DropDownValueModel(name: 'Facebook', value: "value1"),
          DropDownValueModel(name: 'Instagram', value: "value2"),
          DropDownValueModel(
            name: 'X',
            value: "value3",
          ),
        ],
      ),
    );
  }
}
