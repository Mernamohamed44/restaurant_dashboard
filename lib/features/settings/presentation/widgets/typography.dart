import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/utils/constance.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:restaurant_dashboard/app/widget/custom_text_form_field.dart';
import 'package:restaurant_dashboard/features/settings/presentation/cubit/settings_cubit.dart';

class TypographyWidget extends StatelessWidget {
  const TypographyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final cubit = context.read<SettingsCubit>();
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 200,
                height: 40,
                child: DropDownTextField(
                  dropDownIconProperty: IconProperty(
                    icon: Icons.keyboard_arrow_down,
                    size: 24,
                    color: AppColors.textColor,
                  ),
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
                    hintText: 'Font Family',
                    hintStyle: const TextStyle(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w700,
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
                    DropDownValueModel(name: 'Almarai', value: "value1"),
                    DropDownValueModel(name: 'Nunito', value: "value2"),
                    DropDownValueModel(
                      name: 'Montserrat',
                      value: "value3",
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      controller:
                          context.read<SettingsCubit>().keyWordsController,
                      title: 'Languages',
                      titleFontSize: 14,
                      hintText: 'Type the name...',
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  InkWell(
                    onTap: () {
                      cubit.addKeyWords();
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
              Row(
                children: [
                  Wrap(
                      alignment: WrapAlignment.start,
                      direction: Axis.horizontal,
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: List.generate(
                          cubit.words.length,
                          (index) => LanguagesContainer(
                                text: cubit.words[index],
                                index: index,
                              ))),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

class LanguagesContainer extends StatelessWidget {
  const LanguagesContainer(
      {super.key, required this.text, required this.index});

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
