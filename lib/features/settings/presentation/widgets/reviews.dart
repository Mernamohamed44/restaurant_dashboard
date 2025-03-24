import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restaurant_dashboard/app/helper/extension.dart';
import 'package:restaurant_dashboard/app/routing/routes.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/utils/constance.dart';
import 'package:restaurant_dashboard/app/utils/image_manager.dart';
import 'package:restaurant_dashboard/app/widget/custom_button.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:restaurant_dashboard/app/widget/custom_text_form_field.dart';
import 'package:restaurant_dashboard/app/widget/toastification_widget.dart';
import 'package:restaurant_dashboard/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:restaurant_dashboard/features/settings/presentation/widgets/options_input_widget.dart';

class Reviews extends StatefulWidget {
  const Reviews({super.key});

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  @override
  void initState() {
    //context.read<SettingsCubit>().addListenerFocusNodeoptions(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final cubit = context.read<SettingsCubit>();
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    const CustomText(
                      text: 'Customer Reviews Settings',
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
                ReviewsRow(
                    rate: 'Star Rating',
                    value: cubit.starRatingValue,
                    onChange: (value) {
                      cubit.changeStarRatingValue(value);
                    }),
                const SizedBox(
                  height: 8,
                ),
                ReviewsRow(
                    rate: 'General Comment',
                    value: cubit.generalCommentValue,
                    onChange: (value) {
                      cubit.changeGeneralCommentValue(value);
                    }),
                const SizedBox(
                  height: 8,
                ),
                ReviewsRow(
                    rate: 'Customer Name Required',
                    value: cubit.customerNameValue,
                    onChange: (value) {
                      cubit.changeCustomerNameValue(value);
                    }),
                const SizedBox(
                  height: 8,
                ),
                ReviewsRow(
                    rate: 'Customer Email Required',
                    value: cubit.customerEmailValue,
                    onChange: (value) {
                      cubit.changeCustomerEmailValue(value);
                    }),
                const SizedBox(
                  height: 8,
                ),
                ReviewsRow(
                    rate: 'Add Thank You Message',
                    value: cubit.thankValue,
                    onChange: (value) {
                      cubit.changeThankValue(value);
                    }),
                const SizedBox(
                  height: 8,
                ),
                cubit.thankValue
                    ? CustomTextFormField(
                        controller: cubit.thankMessageController,
                        maxLines: 3,
                        hintText: 'Type your message here...',
                        titleFontSize: 14,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "please enter message";
                          }
                          return null;
                        },
                      )
                    : const SizedBox(),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    const CustomText(
                      text: 'Custom Inputs',
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
                context.screenWidth > 500
                    ? const Row(
                        children: [
                          InputTypeSelection(),
                          SizedBox(
                            width: 5,
                          ),
                          Flexible(child: InputTypeTextField()),
                          SizedBox(
                            width: 5,
                          ),
                          AddButton()
                        ],
                      )
                    : const Column(
                        children: [
                          InputTypeSelection(),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Flexible(child: InputTypeTextField()),
                              SizedBox(
                                width: 5,
                              ),
                              AddButton()
                            ],
                          )
                        ],
                      ),
                const SizedBox(height: 10),
                context.read<SettingsCubit>().isCustomerOptions
                    ? const OptionInputWidget()
                    : const SizedBox(),
                ...List.generate(
                    cubit.customerInput.length,
                    (index) => AddInputTypeRow(
                          text: cubit.customerInput[index],
                          index: index,
                        )),
                const SizedBox(
                  height: 20,
                ),
                BlocConsumer<SettingsCubit, SettingsState>(
                  listener: (context, state) {
                    if (state is CreateReviewsSuccessState) {
                      showToastificationWidget(
                        message: 'Create Review successfully',
                        context: context,
                      );
                      context.pushReplacementNamed(Routes.dashboard);
                    } else if (state is CreateReviewsFailState) {
                      showToastificationWidget(
                        message: state.message,
                        context: context,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is CreateReviewsLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      );
                    }
                    return CustomButton(
                      onTap: cubit.createReviews,
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
          ),
        );
      },
    );
  }
}

class AddButton extends StatelessWidget {
  const AddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: context.read<SettingsCubit>().addCustomInput,
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

class ReviewsRow extends StatelessWidget {
  const ReviewsRow({
    super.key,
    required this.rate,
    required this.value,
    required this.onChange,
  });

  final String rate;
  final bool value;
  final Function(bool) onChange;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: AppColors.containerColor,
                borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                Transform.scale(
                  scale: .7,
                  child: Switch(
                      activeColor: AppColors.primary,
                      value: value,
                      onChanged: (value) {
                        onChange(value);
                      }),
                ),
                const SizedBox(
                  width: 10,
                ),
                CustomText(text: rate, color: AppColors.textColor)
              ],
            ),
          ),
        );
      },
    );
  }
}

class AddInputTypeRow extends StatelessWidget {
  const AddInputTypeRow({
    super.key,
    required this.text,
    required this.index,
  });

  final String text;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Padding(
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
                        SvgPicture.asset(ImageManager.extend),
                        const SizedBox(
                          width: 15,
                        ),
                        Flexible(
                          child: CustomText(
                            text: text,
                            color: AppColors.textColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      context.read<SettingsCubit>().clearCustomInput(index);
                    },
                    child: SvgPicture.asset(
                      ImageManager.clear,
                      height: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Transform.scale(
          scale: .7,
          child: Switch(
            activeColor: AppColors.primary,
            value: context.read<SettingsCubit>().requiredInputValues[index],
            onChanged: (value) {
              context.read<SettingsCubit>().changeInputValue(value,index);
            },
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        CustomText(
          text: context.read<SettingsCubit>().requiredInputValues[index]
              ? 'Required'
              : 'Not Required',
          color: AppColors.textColor,
          fontSize: 14,
        )
      ],
    );
  }
}

class InputTypeTextField extends StatelessWidget {
  const InputTypeTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: context.read<SettingsCubit>().customInputController,
      hintText: 'Input Title...',
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter Input Title";
        }
        return null;
      },
    );
  }
}

class InputTypeSelection extends StatelessWidget {
  const InputTypeSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenWidth > 500 ? 150 : double.infinity,
      child: DropDownTextField(
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter Input Type";
          }
          return null;
        },
        controller: context.read<SettingsCubit>().inputTypeController,
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
          hintText: 'InputType',
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
          DropDownValueModel(name: 'number', value: "value1"),
          DropDownValueModel(name: 'date', value: "value2"),
          DropDownValueModel(name: 'text', value: "value3"),
          DropDownValueModel(name: 'bool', value: "value4"),
          DropDownValueModel(name: 'select', value: "value5"),
        ],
      ),
    );
  }
}
